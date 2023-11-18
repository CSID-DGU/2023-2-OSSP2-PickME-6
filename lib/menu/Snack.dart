import 'package:flutter/material.dart';

class Snack extends StatefulWidget {
const Snack({Key? key}) : super(key: key);

  @override
  State<Snack> createState() => _SnackState();

}

class _SnackState extends State<Snack> {
  @override
  Widget build(BuildContext context) {
    return Text(
      '분식입니다',
      style: TextStyle(fontSize: 40),
    );
  }

}