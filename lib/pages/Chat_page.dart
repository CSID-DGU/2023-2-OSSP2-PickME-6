import 'package:flutter/material.dart';
import 'package:ossp_pickme/main.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../chatting/chat/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<String?> _getCurrentUserId() async {
    User? user = _authentication.currentUser;
    if (user != null) {
      return user.uid;
    }
    return null;
  }

  Stream<List<ChatRoom>> _getChatRoomsStream() {
    return _db.collection('chatRooms').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        int timerStartTime = data['timerStartTime'];
        int timerSetTime = data['timerSetTime'];
        int currentTime = DateTime.now().millisecondsSinceEpoch;
        int remainingTime = timerSetTime - (currentTime - timerStartTime) ~/ 1000; // 남은 시간 계산
        return ChatRoom(
          makerId: data['makerId'],
          category: data['category'],
          foodName: data['foodName'],
          members: data['members'],
          remainingTime: remainingTime > 0 ? remainingTime : 0,
          timerStartTime: timerStartTime, // 수정: 필드 추가
          timerSetTime: timerSetTime,
        );
      }).toList();
    });
  }
  Future<void> _showCreateChatRoomDialog() async {
    TextEditingController categoryController = TextEditingController();
    TextEditingController foodNameController = TextEditingController();
    TextEditingController timerController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
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
              onPressed: () {
                // 입력 받은 값으로 채팅방 생성
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
        );
      },
    );
  }
  void _createChatRoom(String category, String foodName, int timerSeconds) async {
    String? userId = await _getCurrentUserId();
    ChatRoom newChatRoom = ChatRoom(
      makerId: userId!,
      category: category,
      foodName: foodName,
      members: 1,
      timerStartTime: DateTime.now().millisecondsSinceEpoch, // 타이머 시작 시간 추가
      timerSetTime: timerSeconds,
      remainingTime: timerSeconds,
    );
    await _db.collection('chatRooms').doc(newChatRoom.makerId).set({
      'makerId': newChatRoom.makerId,
      'category': newChatRoom.category,
      'foodName': newChatRoom.foodName,
      'members': newChatRoom.members,
      'timerStartTime': newChatRoom.timerStartTime, // 서버에 타이머 시작 시간 저장
      'timerSetTime': newChatRoom.timerSetTime, // 서버에 타이머 설정 시간 저장
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
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<ChatRoom>>(
              stream: _getChatRoomsStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<ChatRoom> chatRooms = snapshot.data!;
                  return ListView.builder(
                    itemCount: chatRooms.length,
                    itemBuilder: (context, index) {
                      return ChatRoomListItem(chatRoom: chatRooms[index]);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('데이터를 불러오는 중 오류가 발생했습니다.'),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          AdvertisementItem(),
        ],
      ),
    );
  }
}

class ChatRoom {
  final String makerId;
  final String category;
  final String foodName;
  final int members;
  final int timerStartTime; // 추가: 타이머 시작 시간
  final int timerSetTime;
  late int remainingTime;

  ChatRoom({
    required this.makerId,
    required this.category,
    required this.foodName,
    required this.members,
    required this.remainingTime,
    required this.timerStartTime, // 수정: 필드 추가
    required this.timerSetTime, // 수정: 필드 추가
  });
}

class ChatRoomListItem extends StatefulWidget {
  final ChatRoom chatRoom;

  ChatRoomListItem({required this.chatRoom});

  @override
  _ChatRoomListItemState createState() => _ChatRoomListItemState();
}

class _ChatRoomListItemState extends State<ChatRoomListItem> {
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
          navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (context) => ChatScreen(documentId: widget.chatRoom.makerId),
            ),
          );
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
