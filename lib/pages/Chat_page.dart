import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatState();

}

class _ChatState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Chat',
      style: TextStyle(fontSize: 40),
    );
  }

}