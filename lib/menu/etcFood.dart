import 'package:flutter/material.dart';

class etcFood extends StatefulWidget {
const etcFood({Key? key}) : super(key: key);

  @override
  State<etcFood> createState() => _etcState();

}

class _etcState extends State<etcFood> {
  @override
  Widget build(BuildContext context) {
    return Text(
      '기타 음식입니다',
      style: TextStyle(fontSize: 40),
    );
  }

}