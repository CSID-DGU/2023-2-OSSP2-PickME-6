import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'detail/comment_screen.dart';

class ChineseFood extends StatefulWidget {
const ChineseFood({Key? key}) : super(key: key);

  @override
  State<ChineseFood> createState() => _ChineseState();

}

class _ChineseState extends State<ChineseFood> {
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
 title: Text('마라탕'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => comment_screen(name: 'bagel')),
                        );
 },
 ),
 ListTile(leading: Icon(Icons.food_bank),
 title: Text('짜장면'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => comment_screen(name: 'bagel')),
                        );
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('짬뽕'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => comment_screen(name: 'bagel')),
                        );
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('탕수육'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => comment_screen(name: 'bagel')),
                        );
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('기타 중식'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => comment_screen(name: 'bagel')),
                        );
 },
 ),
],

      ),
    );
  }

}