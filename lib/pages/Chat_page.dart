import 'package:flutter/material.dart';
import 'package:ossp_pickme/main.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../chatting/chat/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatRoomListPage(),
        debugShowCheckedModeBanner: false
    );
  }
}

class ChatRoomListPage extends StatefulWidget {
  @override
  _ChatRoomListPageState createState() => _ChatRoomListPageState();
}

class _ChatRoomListPageState extends State<ChatRoomListPage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _authentication = FirebaseAuth.instance;
  late Future<Position> position;
  @override
  void initState() {
    super.initState();
    position = getCurrentLocation();
  }

  Future<String?> _getCurrentUserId() async {
    User? user = _authentication.currentUser;
    if (user != null) {
      return user.uid;
    }
    return null;
  }

  Future<Position> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void deleteChatRooms(String roomNum) async{
    CollectionReference collectionReference = _db.collection('chatRooms').doc(roomNum).collection('chat');
    try {
      QuerySnapshot querySnapshot = await collectionReference.get();
      querySnapshot.docs.forEach((document) {
        _db.collection('chatRooms').doc(roomNum).collection('chat').doc(document.id).delete();
      });
    } catch (e) {
      print("Error getting documents: $e");
    }

    _db.collection('chatRooms').doc(roomNum).delete();
  }
  Stream<List<ChatRoom>> _getChatRoomsStream(Position userLocation) {
    return _db.collection('chatRooms').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        int timerStartTime = data['timerStartTime'];
        int timerSetTime = data['timerSetTime'];
        int currentTime = DateTime.now().millisecondsSinceEpoch;
        double distanceInMeters = Geolocator.distanceBetween(userLocation.latitude, userLocation.longitude, data['latitude'], data['longitude']);
        int remainingTime = timerSetTime - (currentTime - timerStartTime) ~/ 1000; // 남은 시간 계산
        if(data['members'] == 0){
          deleteChatRooms(doc.id);
          return null;
        }
        if (remainingTime <= 0 || distanceInMeters > 1000) {
          return null;
        }

        return ChatRoom(
          latitude: data['latitude'],
          longitude: data['longitude'],
          makerId: data['makerId'],
          category: data['category'],
          foodName: data['foodName'],
          members: data['members'],
          remainingTime: remainingTime > 0 ? remainingTime : 0,
          timerStartTime: timerStartTime,
          timerSetTime: timerSetTime,
        );
      }).where((chatRoom) => chatRoom != null).cast<ChatRoom>().toList()
        ..sort((a, b) => a.remainingTime.compareTo(b.remainingTime));
    });
  }
  Future<void> _showCreateChatRoomDialog() async {
    TextEditingController categoryController = TextEditingController();
    TextEditingController foodNameController = TextEditingController();
    TextEditingController timerController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
            child :
            AlertDialog(
              title: Text('채팅방 생성'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField(
                    items: ['한식', '중식', '일식', '양식', '분식', '기타'].map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      // 선택한 음식 카테고리 처리
                      categoryController.text = value.toString();
                    },
                    decoration: InputDecoration(labelText: '음식 카테고리'),
                  ),
                  TextFormField(
                    controller: foodNameController,
                    decoration: InputDecoration(labelText: '음식점 이름'),
                  ),
                  TextFormField(
                    controller: timerController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: '타이머 설정 (초)'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('취소'),
                ),
                TextButton(
                  onPressed: ()  async {
                    String? userId =  await _getCurrentUserId();
                    _createChatRoom(
                      categoryController.text,
                      foodNameController.text,
                      int.tryParse(timerController.text) ?? 0,
                    );
                    Navigator.of(context).pop();
                  },
                  child: Text('생성'),
                ),
              ],
            ),
          );

      },
    );
  }
  void _createChatRoom(String category, String foodName, int timerSeconds) async {
    String? userId = await _getCurrentUserId();
    Position position = await getCurrentLocation();
    ChatRoom newChatRoom = ChatRoom(
      latitude: position.latitude,
      longitude: position.longitude,
      makerId: userId!,
      category: category,
      foodName: foodName,
      members: 1,
      timerStartTime: DateTime.now().millisecondsSinceEpoch, // 타이머 시작 시간 추가
      timerSetTime: timerSeconds,
      remainingTime: timerSeconds,
    );
    await _db.collection('chatRooms').doc(newChatRoom.makerId).set({
      'latitude': newChatRoom.latitude,
      'longitude': newChatRoom.longitude,
      'makerId': newChatRoom.makerId,
      'category': newChatRoom.category,
      'foodName': newChatRoom.foodName,
      'members': newChatRoom.members,
      'timerStartTime': newChatRoom.timerStartTime, // 서버에 타이머 시작 시간 저장
      'timerSetTime': newChatRoom.timerSetTime, // 서버에 타이머 설정 시간 저장
      'users': FieldValue.arrayUnion([userId]),
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('채팅방 목록'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showCreateChatRoomDialog();
            },
          ),
        ],
      ),
      body: FutureBuilder<Position>(
        future: position,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('데이터를 불러오는 중 오류가 발생했습니다.'));
          }

          Position userLocation = snapshot.data!;
          return StreamBuilder<List<ChatRoom>>(
            stream: _getChatRoomsStream(userLocation),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('데이터를 불러오는 중 오류가 발생했습니다.'));
              }

              List<ChatRoom>? chatRooms = snapshot.data;

              if (chatRooms == null || chatRooms.isEmpty) {
                return Center(child: Text('채팅방이 없습니다.'));
              }

              return ListView.builder(
                itemCount: chatRooms.length,
                itemBuilder: (context, index) {
                  return ChatRoomListItem(chatRoom: chatRooms[index]);
                },
              );
            },
          );
        },
      ),
    );
  }
}

class ChatRoom {
  final double latitude;
  final double longitude;
  final String makerId;
  final String category;
  final String foodName;
  final int members;
  final int timerStartTime;
  final int timerSetTime;
  late int remainingTime;

  ChatRoom({
    required this.latitude,
    required this.longitude,
    required this.makerId,
    required this.category,
    required this.foodName,
    required this.members,
    required this.remainingTime,
    required this.timerStartTime,
    required this.timerSetTime,
  });
}

class ChatRoomListItem extends StatefulWidget {
  final ChatRoom chatRoom;

  ChatRoomListItem({required this.chatRoom});

  @override
  _ChatRoomListItemState createState() => _ChatRoomListItemState();
}

class _ChatRoomListItemState extends State<ChatRoomListItem> {
  late FirebaseFirestore _db = FirebaseFirestore.instance;
  late FirebaseAuth _authentication = FirebaseAuth.instance;
  late Future<String?> _profileImageFuture;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _profileImageFuture = _getUserProfileImage(widget.chatRoom.makerId);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (widget.chatRoom.remainingTime > 0) {
          widget.chatRoom.remainingTime--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  void _showEntryNotAllowedDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('입장 제한'),
          content: Text('이 채팅방은 이미 팀 매칭이 종료되었습니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }
  void _enterChatRoom() async{
    String? userId = await _authentication.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> chatRoomDoc = await _db.collection('chatRooms').doc(widget.chatRoom.makerId).get();

    List<dynamic> users = chatRoomDoc['users'];

    if (!users.contains(userId)) {
      users.add(userId);

      await _db.collection('chatRooms').doc(widget.chatRoom.makerId).update({
        'members': FieldValue.increment(1),
        'users': users,
      });
    }
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => ChatScreen(documentId: widget.chatRoom.makerId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FutureBuilder<String?>(
        future: _profileImageFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircleAvatar();
          }
          if (snapshot.hasError) {
            return CircleAvatar();
          }
          String? profileImage = snapshot.data;
          return CircleAvatar(
            backgroundImage: profileImage != null ? NetworkImage(profileImage) : null,
          );
        },
      ),
      title: Text('[${widget.chatRoom.category}]${widget.chatRoom.foodName}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('남은 시간: ${widget.chatRoom.remainingTime ~/ 60}분 ${widget.chatRoom.remainingTime % 60}초'),
          Text('${widget.chatRoom.members}명이 참여 중'),
        ],
      ),
      trailing: ElevatedButton(
        onPressed: () {
          if(widget.chatRoom.remainingTime >0 ) {
            _enterChatRoom();
          }
          else {
            _showEntryNotAllowedDialog();
          }
        },
        child: Text('입장'),
      ),
      onTap: () {
        // 채팅방 터치
      },
    );
  }

  Future<String?> _getUserProfileImage(String userId) {
    return FirebaseFirestore.instance.collection('user').doc(userId).get().then((snapshot) {
      return snapshot.data()?['profile_image'];
    });
  }
}

class AdvertisementItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      alignment: Alignment.center,
      child: Text('광고'),
    );
  }
}
