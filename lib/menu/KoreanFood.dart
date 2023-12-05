import 'package:flutter/material.dart';

class KoreanFood extends StatefulWidget {
const KoreanFood({Key? key}) : super(key: key);

  @override
  State<KoreanFood> createState() => _KoreanState();

}

class _KoreanState extends State<KoreanFood> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: const Text('한식'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: ListView(
scrollDirection: Axis.vertical,
children: <Widget>[
 ListTile(leading: Icon(Icons.food_bank),
 title: Text('감자탕'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
 ListTile(leading: Icon(Icons.food_bank),
 title: Text('곱도리탕'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('국밥'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('김치찌개'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('낙곱새'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('냉면'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
 ListTile(leading: Icon(Icons.food_bank),
 title: Text('된장찌개'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
   ListTile(leading: Icon(Icons.food_bank),
 title: Text('부대찌개'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('불고기'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('비빔밥'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('설렁탕'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
 ListTile(leading: Icon(Icons.food_bank),
 title: Text('수제비'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('아구찜'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
   ListTile(leading: Icon(Icons.food_bank),
 title: Text('족발보쌈'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('칼국수'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('해물찜'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('찜닭'),
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