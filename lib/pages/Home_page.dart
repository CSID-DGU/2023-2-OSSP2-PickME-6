import 'dart:math';

import 'package:flutter/material.dart';
import '../menu/KoreanFood.dart';
import '../menu/ChineseFood.dart';
import '../menu/JapaneseFood.dart';
import '../menu/Snack.dart';
import '../menu/WesternFood.dart';
import '../menu/etcFood.dart';
//광고 슬라이더 작성 패키지
import 'package:carousel_slider/carousel_slider.dart';

//광고 이미지
final dummyItems = [
  'https://cdn.pixabay.com/photo/2016/03/23/15/00/ice-cream-1274894_1280.jpg',
  'https://cdn.pixabay.com/photo/2022/01/05/15/22/man-6917326_1280.jpg',
  'https://cdn.pixabay.com/photo/2017/08/03/21/48/drinks-2578446_1280.jpg',
];


class HomePage extends StatefulWidget {
const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
 final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText = "";

  _HomePageState(){
  _filter.addListener(() {
    setState(() {
      _searchText=_filter.text;
    });
  });
  }

  @override
  Widget build(BuildContext context) {
   return ListView(
      children: <Widget>[
    //랜덤 메뉴 추천
    Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: AssetImage(
              'menu.png'
            ),
            fit: BoxFit.cover,
            )
          ),
        ),
        TextButton(
          onPressed: () => random_menu(), 
          child: Text(
            '메뉴 추천 받기',
            style: TextStyle(
              fontSize: 30,
              color: const Color.fromARGB(255, 255, 255, 255),
              letterSpacing: 3.0,
            ),
            ),
          ),
      ],
    ),
    //랜덤 메뉴 추천 끝
    //검색창
    Container(
      color: Colors.white, 
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: Row(
        children: <Widget>[
          Expanded(flex: 6, 
                   child: TextField(
                    focusNode: focusNode,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    autofocus: true,
                    controller: _filter,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white12,
                      prefixIcon: Icon(
                        Icons.search, 
                        color: Colors.white60, 
                        size: 20, 
                        ),
                        suffixIcon: focusNode.hasFocus ? IconButton(
                          icon: Icon(
                            Icons.cancel, 
                            size: 20,
                            ),
                            onPressed: (){
                              setState(() {
                                _filter.clear();
                                _searchText="";
                              });
                            },
                          )
                           : Container(),
                           hintText: 'Search For Food',
                           labelStyle: TextStyle(color: Colors.white),
                           focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                           enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                           border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
          ),
          focusNode.hasFocus 
          ? Expanded(
            child: TextButton(
            child: Text('취소'),
            onPressed: () {
              setState(() {
                _filter.clear();
                _searchText="";
                focusNode.unfocus();
              });
            },
            ),
          )
          : Expanded(
            flex: 0,
            child: Container(),
            )
        ],
      ),
    ),
    //검색창 끝
    //여백 주기
          SizedBox(
            height: 20,
          ),
    //메뉴 첫번째 줄 : 한식, 중식, 일식
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
                Column(
                  children: <Widget>[
                    IconButton(
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => KoreanFood()),
                        );
                    }, 
                    icon: Icon(Icons.food_bank),
                    iconSize: 40, 
                  ),
                    Text('한식'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                    onPressed: () {
                       Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => ChineseFood()),
                        );
                    }, 
                    icon: Icon(Icons.food_bank),
                    iconSize: 40, 
                  ),
                    Text('중식'),
                  ],
                ),
                Column(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                       Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => JapaneseFood()),
                        );
                    }, 
                    icon: Icon(Icons.food_bank),
                    iconSize: 40, 
                  ),
                  Text('일식'),
                ],
              ),
            ],
          ),
          //여백 주기
          SizedBox(
            height: 20,
          ),
      //메뉴 두번째 줄 : 양식, 분식, 기타
      Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
                Column(
                  children: <Widget>[
                    IconButton(
                    onPressed: () {
                       Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => WesternFood()),
                        );
                    }, 
                    icon: Icon(Icons.food_bank),
                    iconSize: 40, 
                  ),
                    Text('양식'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                    onPressed: () {
                       Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => Snack()),
                        );
                    }, 
                    icon: Icon(Icons.food_bank),
                    iconSize: 40, 
                  ),
                    Text('분식'),
                  ],
                ),
                Column(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                       Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => etcFood()),
                        );
                    }, 
                    icon: Icon(Icons.food_bank),
                    iconSize: 40, 
                  ),
                  Text('기타'),
                ],
              ),
            ],
          ),
        //메뉴 버튼 끝
        //여백 주기
          SizedBox( 
            height: 40,
          ),
          //광고 슬라이더
          CarouselSlider(
            options: CarouselOptions(
              height: 150,
              autoPlay: true,
              ),
             items: dummyItems.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    ),
    //광고 슬라이더 끝
   ],
   );
  }
  
  random_menu() {

    List<String> _menus = [
     '한식',
     '중식',
     '양식',
  ];

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: Column(
              children: <Widget>[
                new Text("메뉴 추천"),
              ],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "한식",
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text("다른 메뉴"),
                onPressed: () {
                  
                },
              ),
              TextButton(
                child: Text("확인"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}

