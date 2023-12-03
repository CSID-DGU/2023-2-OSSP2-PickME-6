import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_8.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatBubbles extends StatelessWidget {
  ChatBubbles(this.message, this.isMe, this.userImage, {Key? key}):super(key:key);

  final String message;
  final bool isMe;
  final String userImage; //userID를 받아와 실시간 이미지로 반환


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

  Future<String> _getUserNickName(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
      await FirebaseFirestore.instance.collection('user').doc(userId).get();
      if (userSnapshot.exists) {
        return userSnapshot.data()?['nickName'] ?? '';
      }
    } catch (e) {
      print('Error fetching user nickName: $e');
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUserNickName(userImage),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // 대기 중에 로딩 스피너 표시
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // 오류 발생 시 에러 메시지 표시
        }
      String nickName = snapshot.data as String? ?? '';
      return Stack(
          children: [
            Row(
              mainAxisAlignment: isMe
                  ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                if(isMe)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 45, 0),
                    child:
                    ChatBubble(
                      clipper: ChatBubbleClipper8(type: BubbleType.sendBubble),
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(top: 20),
                      backGroundColor: Colors.blue,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery
                              .of(context)
                              .size
                              .width * 0.7,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                nickName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )
                            ),
                            Text(
                              message,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if(!isMe)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(45, 10, 0, 0),
                    child:

                    ChatBubble(
                      clipper: ChatBubbleClipper8(
                          type: BubbleType.receiverBubble),
                      backGroundColor: Color(0xffE7E7ED),
                      margin: EdgeInsets.only(top: 20),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery
                              .of(context)
                              .size
                              .width * 0.7,
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  nickName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  )
                              ), Text(
                                message,
                                style: TextStyle(color: Colors.black),
                              ),
                            ]
                        ),
                      ),
                    ),
                  )
              ],
            ),
            Positioned(
              top: 0,
              right: isMe ? 5 : null,
              left: isMe ? null : 5,
              child: FutureBuilder(
                future: _getUserProfileImage(userImage),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircleAvatar(); // 대기 중에 기본 이미지 또는 로딩 스피너 표시
                  }
                  if (snapshot.hasError) {
                    return CircleAvatar(); // 오류 발생 시 기본 이미지 표시
                  }

                  String? profileImage = snapshot.data as String?;
                  return CircleAvatar(
                    backgroundImage: profileImage != null ? NetworkImage(
                        profileImage) : null,
                  );
                },
              ),
            )
          ]
      );
     },
    );
  }


}
