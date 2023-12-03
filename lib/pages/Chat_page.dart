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
        return ChatRoom(
          name: data['name'],
          makerId: data['makerId'],
          category: data['category'],
          foodName: data['foodName'],
          members: data['members'],
          remainingTime: data['remainingTime'],
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
                items: ['한식', '중식', '양식', '일식'].map((category) {
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
                decoration: InputDecoration(labelText: '음식 이름'),
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
      name: '$category - $foodName',
      makerId: userId!,
      category: category,
      foodName: foodName,
      members: 0,
      remainingTime: timerSeconds,
    );
    await _db.collection('chatRooms').add({
      'name': newChatRoom.name,
      'makerId': newChatRoom.makerId,
      'category': newChatRoom.category,
      'foodName': newChatRoom.foodName,
      'members': newChatRoom.members,
      'remainingTime': newChatRoom.remainingTime,
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
  final String name;
  final String makerId;
  final String category;
  final String foodName;
  final int members;
  late Timer timer;
  late int remainingTime;

  ChatRoom({
    required this.name,
    required this.makerId,
    required this.category,
    required this.foodName,
    required this.members,
    required this.remainingTime,
  }) {
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--;
      } else {
        timer.cancel();
      }
    });
  }
}

class ChatRoomListItem extends StatelessWidget {
  final ChatRoom chatRoom;

  ChatRoomListItem({required this.chatRoom});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FutureBuilder(
        future: _getUserProfileImage(chatRoom.makerId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircleAvatar(); // 대기 중에 기본 이미지 또는 로딩 스피너 표시
          }
          if (snapshot.hasError) {
            return CircleAvatar(); // 오류 발생 시 기본 이미지 표시
          }

          String? profileImage = snapshot.data as String?;
          return CircleAvatar(
            backgroundImage: profileImage != null ? NetworkImage(profileImage) : null,
          );
        },
      ),
      title: Text(chatRoom.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('남은 시간: ${chatRoom.remainingTime ~/ 60}분 ${chatRoom.remainingTime % 60}초'),
          Text('${chatRoom.members}명이 참여 중'),
        ],
      ),
      trailing: ElevatedButton(
        onPressed: () {
          navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (context) => const ChatScreen(),
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

  Future<String?> _getUserProfileImage(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
      await FirebaseFirestore.instance.collection('user').doc(userId).get();
      if (userSnapshot.exists) {
        return userSnapshot.data()?['profile_image'];
      }
    } catch (e) {
      print('Error fetching user profile image: $e');
    }
    return null;
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
