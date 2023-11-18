import 'package:flutter/material.dart';
import 'dart:async';

import '../chatting/chat/chat_screen.dart';

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
  List<ChatRoom> chatRooms = [
    ChatRoom(
      name: '라화방마라탕',
      profileImage: '',
      members: 3,
      remainingTime: 300,
    ),
    ChatRoom(
      name: '필동반점',
      profileImage: '',
      members: 2,
      remainingTime: 600,
    ),
    ChatRoom(
      name: '행복은 간장밥',
      profileImage: '',
      members: 2,
      remainingTime: 200,
    ),
    ChatRoom(
      name: '동국반점',
      profileImage: '',
      members: 1,
      remainingTime: 400,
    ),
    ChatRoom(
      name: '라화방마라탕',
      profileImage: '',
      members: 3,
      remainingTime: 300,
    ),
    ChatRoom(
      name: '필동반점',
      profileImage: '',
      members: 2,
      remainingTime: 600,
    ),
    ChatRoom(
      name: '행복은 간장밥',
      profileImage: '',
      members: 2,
      remainingTime: 200,
    ),
    ChatRoom(
      name: '동국반점',
      profileImage: '',
      members: 1,
      remainingTime: 400,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('채팅방 목록'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // 채팅방 생성
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatRooms.length,
              itemBuilder: (context, index) {
                return ChatRoomListItem(chatRoom: chatRooms[index]);
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
  final String profileImage;
  final int members;
  late Timer timer;
  late int remainingTime;

  ChatRoom({
    required this.name,
    required this.profileImage,
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
      leading: CircleAvatar(
        backgroundImage: AssetImage(chatRoom.profileImage),
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatScreen()),
          );
        },
        child: Text('입장'),
      ),
      onTap: () {
        // 채팅방 터치
      },
    );
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
