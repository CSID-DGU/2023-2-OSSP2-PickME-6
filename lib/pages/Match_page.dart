import 'package:flutter/material.dart';

class MatchingPage extends StatefulWidget {
  const MatchingPage({Key? key}) : super(key: key);

  @override
  State<MatchingPage> createState() => _MatchingState();
}

class _MatchingState extends State<MatchingPage> {
  late String selectedCategory;
  late String selectedFood;
  late List<String> foods;
  late Map<String, List<String>> categoryToFoodMap;
  late List<String> categories;

  @override
  void initState() {
    super.initState();
    selectedCategory = '한식'; //기본설정
    categoryToFoodMap = { // 더 추가하기
      '한식': ['삼겹살', '국밥', '설렁탕'],
      '중식': ['짜장면', '짬뽕', '탕수육', '마라탕'],
      '일식': ['초밥', '라멘'],
      '양식': ['햄버거', '파스타'],
      '분식': ['김밥', '떡볶이'],
      '기타': ['커피', '간식'],
    };
    categories = categoryToFoodMap.keys.toList();
    foods = categoryToFoodMap[selectedCategory] ?? [];
    selectedFood = foods.isNotEmpty ? foods.first : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox.shrink(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '카테고리를 선택하세요',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                  foods = categoryToFoodMap[selectedCategory] ?? [];
                  selectedFood = foods.isNotEmpty ? foods.first : '';
                });
              },
              style: TextStyle(fontSize: 18, color: Colors.black),
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 36,
              underline: Container(
                height: 2,
                color: Colors.blue,
              ),
              elevation: 8,
              isExpanded: true,
              items: categories.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              '희망 주문 메뉴를 선택하세요',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedFood,
              onChanged: (String? newValue) {
                setState(() {
                  selectedFood = newValue!;
                });
              },
              style: TextStyle(fontSize: 18, color: Colors.black),
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 36,
              underline: Container(
                height: 2,
                color: Colors.blue,
              ),
              elevation: 8,
              isExpanded: true,
              items: foods.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // 버튼 누른 이후 코드
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2B4177),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '매칭시작',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
