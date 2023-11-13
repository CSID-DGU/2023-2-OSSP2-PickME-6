import 'package:flutter/material.dart';

class MatchingPage extends StatefulWidget {
const MatchingPage({Key? key}) : super(key: key);

  @override
  State<MatchingPage> createState() => _MatchingState();

}

class _MatchingState extends State<MatchingPage> {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Matching',
      style: TextStyle(fontSize: 40),
    );
  }

}