import 'package:flutter/material.dart';
import '../menu/KoreanFood.dart';
import '../menu/ChineseFood.dart';
import '../menu/JapaneseFood.dart';
import '../menu/Snack.dart';
import '../menu/WesternFood.dart';
import '../menu/etcFood.dart';


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
   return Container(
    child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(30),
        ),
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

   ],
   ),
   );
  }
}