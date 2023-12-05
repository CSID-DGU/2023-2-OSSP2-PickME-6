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
      body: ListView(
scrollDirection: Axis.vertical,
children: <Widget>[
 ListTile(leading: Icon(Icons.food_bank),
 title: Text('마라탕'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
 ListTile(leading: Icon(Icons.food_bank),
 title: Text('짜장면'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('짬뽕'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('탕수육'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
  ListTile(leading: Icon(Icons.food_bank),
 title: Text('기타 중식'),
 trailing: Icon(Icons.navigate_next),
 onTap: () {
   
 },
 ),
],
      ),
    );
  }
}



// GridView.count(
//         scrollDirection: Axis.vertical,
//           crossAxisCount: 2,
//           mainAxisSpacing: 5.0,
//           crossAxisSpacing: 5.0,
//           padding: const EdgeInsets.all(5.0),
//           children: <Widget>[
//             //1번
//               Container(
//           width: MediaQuery.of(context).size.width,
//           height: 100,
//           padding: EdgeInsets.all(20),
//           child: Column(
//             children: <Widget>[
//               Image.network('https://cdn.pixabay.com/photo/2016/03/23/15/00/ice-cream-1274894_1280.jpg'),
//               Text(
//             '음식1',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 25,
//             ),
//           ),
//           //매칭 현황 출력하기
//           Container(
//             child: Text('현재 매칭 현황',
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 12,
//             ),
//             ),
//           ),
//              ElevatedButton(
//               onPressed: (){
//                 //매칭 바로 선택되도록 이동하기 
//               }, 
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFF2B4177), 
//               ),
//               child: Text(
//               'Matching',
//                style: TextStyle(
//                 color: Colors.white,
//                 ),
//               ),
//               ),

//             ]
//           ),
//           //박스 채우기
//           decoration: BoxDecoration(
//           color: const Color.fromARGB(245, 255, 255, 255),
//           borderRadius: BorderRadius.circular(10.0),
//           boxShadow: [
//             BoxShadow(
//             color: Colors.grey.withOpacity(0.7),
//             blurRadius: 5.0,
//             spreadRadius: 0.0,
//             offset: const Offset(0,7),
//             )
//           ]
//           ),
//         ),
        
          


//           ],


//       )