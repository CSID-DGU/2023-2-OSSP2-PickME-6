import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ossp_pickme/chatting/chat/messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ossp_pickme/chatting/chat/new_messages.dart';

class ChatScreen extends StatefulWidget {
  final String documentId;
  const ChatScreen({Key? key, required this.documentId}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  bool hasTeamFormationPermission = false;
  bool isTeamFormed = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    checkTeamFormationPermission();
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> checkTeamFormationPermission() async {
    DocumentSnapshot<Map<String, dynamic>> chatRoomDoc =
    await FirebaseFirestore.instance.collection('chatRooms').doc(widget.documentId).get();

    List<dynamic> users = chatRoomDoc['users'] ?? [];

    if (users.isNotEmpty && loggedUser?.uid == users[0]) {
      setState(() {
        hasTeamFormationPermission = true;
      });
    }

    FirebaseFirestore.instance.collection('chatRooms').doc(widget.documentId).snapshots().listen((snapshot) {
      if (snapshot.exists) {
        setState(() {
          isTeamFormed = snapshot['isTeamFormed'] ?? false;
        });

        if (snapshot['isTeamFormed'] == true) {
          setState(() {
            hasTeamFormationPermission = true;
          });
        }
        if (snapshot['acceptedCount'] == snapshot['members']) {
            _deleteChatRoom(widget.documentId);
            Navigator.of(context).pop();
        }
      }
    });
  }

  Future<void> _updateTimerSetTimeToZero(String documentId) async {
    await FirebaseFirestore.instance.collection('chatRooms').doc(documentId).update({
      'timerSetTime': 0,
    });
  }

  Future<void> _completeTeamFormation(String documentId) async {
    await FirebaseFirestore.instance.collection('chatRooms').doc(documentId).update({
      'isTeamFormed': true,
    });
  }

  Future<void> _deleteChatRoom(String documentId) async {
    await FirebaseFirestore.instance.collection('chatRooms').doc(documentId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat screen'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 16.0),
            child:
              ElevatedButton.icon(
                onPressed: hasTeamFormationPermission
                    ? () {
                  if (!isTeamFormed) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('팀 구성'),
                          content: Text('이대로 팀을 구성하시겠습니까?'),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                await _updateTimerSetTimeToZero(widget.documentId);
                                await _completeTeamFormation(widget.documentId);
                                Navigator.of(context).pop();
                              },
                              child: Text('예'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('아니오'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('주문 완료 확인'),
                          content: Text('주문이 완료되었음을 확인하시겠습니까?'),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance.collection('chatRooms').doc(widget.documentId).update({
                                  'acceptedCount': FieldValue.increment(1),
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text('예'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('아니오'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
                    : null,
                style: ElevatedButton.styleFrom(primary: Colors.blue),
              icon: Icon(
                isTeamFormed ? Icons.check : Icons.star,
                color: Colors.white,
              ),
              label: Text(
                isTeamFormed ? '완료' : '구성',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.exit_to_app_sharp,
              color: Colors.black,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('나가기'),
                    content: Text('정말로 나가시겠습니까?'),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          DocumentSnapshot<Map<String, dynamic>> chatRoomDoc =
                          await FirebaseFirestore.instance.collection('chatRooms').doc(widget.documentId).get();

                          String? userId = loggedUser?.uid;

                          if (userId != null) {
                            await FirebaseFirestore.instance.collection('chatRooms').doc(widget.documentId).update({
                              'members': FieldValue.increment(-1),
                              'users': FieldValue.arrayRemove([userId]),
                            });
                            // 성사 버튼을 눌렀을 때의 처리 추가
                            if (isTeamFormed) {
                              await _deleteChatRoom(widget.documentId);
                            }
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text('예'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('아니오'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(documentId: widget.documentId),
            ),
            NewMessage(documentId: widget.documentId),
          ],
        ),
      ),
    );
  }
}
