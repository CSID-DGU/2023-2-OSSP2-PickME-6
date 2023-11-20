import 'package:flutter/material.dart';

class MatchingPage extends StatefulWidget {
  const MatchingPage({Key? key}) : super(key: key);

  @override
  State<MatchingPage> createState() => _MatchingState();
}

class _MatchingState extends State<MatchingPage> {
  String selectedCategory = '한식'; // 한식으로 보이게 설정
  String selectedFood = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matching'),
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
                });
              }, // 드롭다운버튼 사용 (카테고리 선택)
              items: <String>['한식', '중식', '일식', '양식'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              '희망 주문 메뉴를 적어주세요',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      selectedFood = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '메뉴를 입력하세요',
                  ),
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // 버튼 누르고 이후 코드 작성 필요
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2B4177), // 버튼색
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
