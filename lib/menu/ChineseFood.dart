import 'package:flutter/material.dart';

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
        title: const Text('중식'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: GridView.count(
        scrollDirection: Axis.vertical,
          crossAxisCount: 2,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          padding: const EdgeInsets.all(5.0),
          children: <Widget>[
            //1번
            GestureDetector(
              onTap: () {
                print('container click test');
              },
              child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          padding: EdgeInsets.all(20),
          child: Text(
            '음식1',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
          decoration: BoxDecoration(
          color: const Color.fromARGB(245, 255, 255, 255),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            blurRadius: 5.0,
            spreadRadius: 0.0,
            offset: const Offset(0,7),
            )
          ]
          ),
        ),
        )

        
          ],


      )
    );
  }

}