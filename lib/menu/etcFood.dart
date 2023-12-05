import 'package:flutter/material.dart';

class etcFood extends StatefulWidget {
const etcFood({Key? key}) : super(key: key);

  @override
  State<etcFood> createState() => _etcState();

}

class _etcState extends State<etcFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('기타'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: ListView(
scrollDirection: Axis.vertical,
children: <Widget>[
 ListTile(leading: Icon(Icons.food_bank),
 title: Text('베이글'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
 ListTile(leading: Icon(Icons.food_bank),
 title: Text('샌드위치'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('샐러드'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('카페'),
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