import 'package:flutter/material.dart';

import 'detail/comment_screen.dart';

class WesternFood extends StatefulWidget {
const WesternFood({Key? key}) : super(key: key);

  @override
  State<WesternFood> createState() => _WesternState();

}

class _WesternState extends State<WesternFood> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: const Text('양식'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: ListView(
scrollDirection: Axis.vertical,
children: <Widget>[
 ListTile(leading: Icon(Icons.food_bank),
 title: Text('파스타'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => comment_screen(name: 'bagel')),
                        );
 },
 ),
 ListTile(leading: Icon(Icons.food_bank),
 title: Text('피자'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => comment_screen(name: 'bagel')),
                        );
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('햄버거'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => comment_screen(name: 'bagel')),
                        );
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('기타 음식'),
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