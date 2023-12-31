import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class NewMessage extends StatefulWidget {
  final String documentId;
  const NewMessage({super.key, required this.documentId});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _userEnterMessage = '';
  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection('user').doc(user!.uid).get();
    FirebaseFirestore.instance.collection('chatRooms').doc(widget.documentId).collection('chat').add({
      'text' : _userEnterMessage,
      'time' : Timestamp.now(),
      'userID' : user!.uid,
    });

    _controller.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child : Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: null,
              controller: _controller,
              decoration: InputDecoration(labelText: 'Send a mesaage....'),
              onChanged: (value){
                setState(() {
                  _userEnterMessage=value;
                });
              },
            ),
          ),
          IconButton(
              onPressed: _userEnterMessage.trim().isEmpty ? null : _sendMessage,
              icon: Icon(Icons.send),
              color: Colors.blue,
          )
        ],
      ),
    );
  }
}
