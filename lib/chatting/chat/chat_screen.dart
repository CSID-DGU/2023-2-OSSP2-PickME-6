import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ossp_pickme/chatting/chat/messages.dart';
import 'package:firebase_auth/firebase_auth.dart'

class ChatScreen extends StatefulWidget{
  const ChatScreen({Key? key}) : super(key : key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>{
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;

  void getCurrentUser(){
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
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
      ),
      body:

    )
  }

}