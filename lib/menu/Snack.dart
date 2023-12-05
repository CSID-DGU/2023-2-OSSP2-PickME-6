import 'package:flutter/material.dart';

class Snack extends StatefulWidget {
const Snack({Key? key}) : super(key: key);

  @override
  State<Snack> createState() => _SnackState();

}

class _SnackState extends State<Snack> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: const Text('분식'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: ListView(
scrollDirection: Axis.vertical,
children: <Widget>[
 ListTile(leading: Icon(Icons.food_bank),
 title: Text('김밥'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
 ListTile(leading: Icon(Icons.food_bank),
 title: Text('라면'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('순대'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('튀김'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('떡볶이'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('쫄면'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
   ListTile(leading: Icon(Icons.food_bank),
 title: Text('기타 분식'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
],

      ),
    );
  }

}