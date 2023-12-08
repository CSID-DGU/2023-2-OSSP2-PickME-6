import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_8.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatBubbles extends StatelessWidget {
  ChatBubbles(this.message, this.isMe, this.userId, {Key? key}):super(key:key);

  final String message;
  final bool isMe;
  final String userId;
  List<String> reportReasons = ['욕설', '기타'];

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
      future: _getUserNickName(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
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
              child: Row(
                children: [
                  FutureBuilder(
                    future: _getUserProfileImage(userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircleAvatar();
                      }
                      if (snapshot.hasError) {
                        return CircleAvatar();
                      }

                      String? profileImage = snapshot.data as String?;
                      return CircleAvatar(
                        backgroundImage: profileImage != null ? NetworkImage(
                            profileImage) : null,
                      );
                    },
                  ),
                  SizedBox(width: 2),
                  if (!isMe)
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            String selectedReason = reportReasons[0]; // 초기값 설정
                            TextEditingController detailedReasonController =
                            TextEditingController();
                            return SingleChildScrollView(
                              child: AlertDialog(
                                title: Text('신고'),
                                content: Container(
                                  height : 200,
                                  width: 200,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('신고 사유를 선택하세요'),
                                      DropdownButton<String>(
                                        value: selectedReason,
                                        onChanged: (String? newValue) {
                                          if (newValue != null) {
                                            selectedReason = newValue;
                                          }
                                        },
                                        items: reportReasons
                                            .map<DropdownMenuItem<String>>(
                                              (String value) =>
                                              DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              ),
                                        ).toList(),
                                      ),
                                      SizedBox(height: 10),
                                      Text('상세한 내용을 입력하세요'),
                                      Container(
                                        height: 100,
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: TextFormField(
                                          controller: detailedReasonController,
                                          maxLines: 5,
                                          maxLength : 100,
                                          decoration: InputDecoration.collapsed(
                                            hintText: '상세한 내용 입력',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('경고'),
                                            content: Text(
                                                '채팅 기록이 수집될 수 있습니다. 신고하시겠습니까?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('아니요'),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  await FirebaseFirestore.instance.collection('report').add({
                                                    'reportedId' : ' ',
                                                    'category' : selectedReason,
                                                    'reportcontent' : detailedReasonController.text,
                                                  });
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('예'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text('신고'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.report,
                        size: 18,
                        color: Colors.black, // You can customize the color
                      ),
                    ),
                ],
              ),
            )
          ]
      );
     },
    );
  }


}
