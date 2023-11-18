import 'package:flutter/material.dart';

class WesternFood extends StatefulWidget {
const WesternFood({Key? key}) : super(key: key);

  @override
  State<WesternFood> createState() => _WesternState();

}

class _WesternState extends State<WesternFood> {
  @override
  Widget build(BuildContext context) {
    return Text(
      '양식입니다',
      style: TextStyle(fontSize: 40),
    );
  }

}