import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ossp_pickme/chatting/chat/messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ossp_pickme/chatting/chat/new_messages.dart';
class ChatScreen extends StatefulWidget{
  const ChatScreen({Key? key}) : super(key : key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>{
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;

  @override
  void initState(){
    super.initState();
    getCurrentUser();

  }
  void getCurrentUser(){
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat screen'),
        actions : [
          IconButton(
            icon : const Icon(
              Icons.exit_to_app_sharp,
              color: Colors.white,
            ),
            onPressed: (){
              //_authentication.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Container(
        child: const Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ]
        )
      )

    );
  }
}