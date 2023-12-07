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
  List<FoodLabel> searchHistory = <FoodLabel>[];

  //검색 기록
  Iterable<Widget> getHistoryList(SearchController controller) {
    return searchHistory.map(
      (FoodLabel result) => ListTile(
        leading: const Icon(Icons.history),
        title: Text(result.name),
        trailing: IconButton(
          icon: const Icon(Icons.call_missed),
          onPressed: () {
            controller.text = result.name;
            controller.selection = TextSelection.collapsed(offset: controller.text.length);
          },
        ),
      ),
    );
  }

  //검색 제안
  Iterable<Widget> getSuggestions(SearchController controller) {
    final String input = controller.value.text;
    return FoodLabel.values
        .where((FoodLabel result) => result.name.contains(input))
        .map(
          (FoodLabel filteredFood) => ListTile(
            title: Text(filteredFood.name),
            trailing: IconButton(
              icon: const Icon(Icons.call_missed),
              onPressed: () {
                controller.text = filteredFood.name;
                controller.selection =
                TextSelection.collapsed(offset: controller.text.length); 
              },
            ),
            onTap: () {
              controller.closeView(filteredFood.name);
              handleSelection(filteredFood);
              //각 카테고리에 맞게 옮기기
               if(filteredFood.category=='한식'){
                     Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => KoreanFood()),
                        );
                  }
                else if(filteredFood.category=='중식'){
                  Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => ChineseFood()),
                        );
                }
                else if(filteredFood.category=='일식'){
                  Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => JapaneseFood()),
                        );
                }
                else if(filteredFood.category=='양식'){
                  Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => WesternFood()),
                        );
                }
                else if(filteredFood.category=='분식'){
                  Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => Snack()),
                        );
                }
                else {
                  Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => etcFood()),
                        );
                }
            },
          ),
        );
  }

//검색 기록 누적 및 삭제
void handleSelection(FoodLabel selectedFood) {
    setState(() {
      if (searchHistory.length >= 5) {
        searchHistory.removeLast();
      }
      searchHistory.insert(0, selectedFood);
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
    //여백 주기
          SizedBox(
            height: 16,
          ),
    //검색창
    SearchAnchor.bar(
                barHintText: '먹고싶은 음식을 검색해보세요.',
                barHintStyle: MaterialStateProperty.all(
                  TextStyle(color: Colors.grey)
                ),
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  if (controller.text.isEmpty) {
                    if (searchHistory.isNotEmpty) {
                      return getHistoryList(controller);
                    }
                    return <Widget>[
                      Center(
                          child: Text('검색 기록이 없어요.'),
                          ),
                    ];
                  }
                  return getSuggestions(controller);
                },
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
     '일식',
     '분식',
  ];

   String recommendedMenu = getRandomMenu(_menus);
   String result = "$recommendedMenu 어때요?"; 

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
                  "$result",
                ),
              ],
            ),
            actions: <Widget>[
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


String getRandomMenu(List<String> menuList) {
  final random = Random();
  final randomIndex = random.nextInt(menuList.length);

  // 랜덤으로 선택된 메뉴 반환
  return menuList[randomIndex];
}


//검색용 메뉴 카테고리
enum FoodLabel {
  korea('한식', '감자탕'),
  korea2('한식', '곱도리탕'),
  korea3('한식', '국밥'),
  korea4('한식', '김치찌개'),
  korea5('한식', '낙곱새'),
  korea6('한식', '냉면'),
  korea7('한식', '된장찌개'),
  korea8('한식', '부대찌개'),
  korea9('한식', '불고기'),
  korea10('한식', '비빔밥'),
  korea11('한식', '설렁탕'),
  korea12('한식', '수제비'),
  korea13('한식', '아구찜'),
  korea14('한식', '족발보쌈'),
  korea15('한식', '칼국수'),
  korea16('한식', '해물찜'),
  korea17('한식', '찜닭'),
  china('중식', '마라탕'),
  china2('중식', '짜장면'),
  china3('중식', '짬뽕'),
  china4('중식', '탕수육'),
  japan('일식', '돈카츠'),
  japan2('일식', '라멘'),
  japan3('일식', '소바'),
  japan4('일식', '초밥'),
  japan5('일식', '타코야끼'),
  japan6('일식', '회덮밥'),
  snack('분식', '김밥'),
  snack2('분식', '라면'),
  snack3('분식', '순대'),
  snack4('분식', '튀김'),
  snack5('분식', '떡볶이'),
  snack6('분식', '쫄면'),
  west('양식', '파스타'),
  west2('양식', '피자'),
  west3('양식', '햄버거'),
  etc('기타', '베이글'),
  etc2('기타', '샌드위치'),
  etc3('기타', '샐러드'),
  etc4('기타', '카페'),
  ;

  const FoodLabel(this.category, this.name);
  final String category;
  final String name;
}