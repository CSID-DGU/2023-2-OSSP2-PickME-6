import 'package:flutter/material.dart';

class KoreanFood extends StatefulWidget {
const KoreanFood({Key? key}) : super(key: key);

  @override
  State<KoreanFood> createState() => _KoreanState();

}

class _KoreanState extends State<KoreanFood> {
  @override
  Widget build(BuildContext context) {
    return Text(
      '한식입니다',
      style: TextStyle(fontSize: 40),
    );
  }

}