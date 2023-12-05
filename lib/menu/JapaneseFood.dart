import 'package:flutter/material.dart';

class JapaneseFood extends StatefulWidget {
const JapaneseFood({Key? key}) : super(key: key);

  @override
  State<JapaneseFood> createState() => _JapaneseState();

}

class _JapaneseState extends State<JapaneseFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('일식'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: ListView(
scrollDirection: Axis.vertical,
children: <Widget>[
 ListTile(leading: Icon(Icons.food_bank),
 title: Text('돈카츠'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
 ListTile(leading: Icon(Icons.food_bank),
 title: Text('라멘'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('소바'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('초밥'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('타코야끼'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('회덮밥'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
 ListTile(leading: Icon(Icons.food_bank),
 title: Text('기타 음식'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
],

      ),
    );
  }

}