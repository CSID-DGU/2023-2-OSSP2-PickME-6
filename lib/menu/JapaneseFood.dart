import 'package:flutter/material.dart';

class JapaneseFood extends StatefulWidget {
const JapaneseFood({Key? key}) : super(key: key);

  @override
  State<JapaneseFood> createState() => _JapaneseState();

}

class _JapaneseState extends State<JapaneseFood> {
  @override
  Widget build(BuildContext context) {
    return Text(
      '일식입니다',
      style: TextStyle(fontSize: 40),
    );
  }

}