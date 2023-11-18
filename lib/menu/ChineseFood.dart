import 'package:flutter/material.dart';

class ChineseFood extends StatefulWidget {
const ChineseFood({Key? key}) : super(key: key);

  @override
  State<ChineseFood> createState() => _ChineseState();

}

class _ChineseState extends State<ChineseFood> {
  @override
  Widget build(BuildContext context) {
    return Text(
      '중식입니다',
      style: TextStyle(fontSize: 40),
    );
  }

}