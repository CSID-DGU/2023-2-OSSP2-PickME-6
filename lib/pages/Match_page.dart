import 'dart:async';
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

  bool isMatching = false;
  late int remainingTime;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    selectedCategory = '한식';
    categoryToFoodMap = {
      '한식': ['족발보쌈', '김치찌개', '된장찌개', '부대찌개', '국밥', '설렁탕', '감자탕', '곱도리탕', '설렁탕', '찜닭', '불고기', '비빔밥', '아구찜', '해물찜', '낙곱새', '기타한식', '칼국수', '수제비', '냉면'],
      '중식': ['짜장면', '짬뽕', '탕수육', '마라탕', '마라상궈', '기타중식'],
      '일식': ['돈카츠', '초밥', '라멘', '소바', '타코야끼', '회덮밥', '기타일식'],
      '양식': ['햄버거', '피자', '파스타', '기타양식'],
      '분식': ['김밥', '떡볶이', '쫄면', '라면', '튀김', '순대', '기타분식'],
      '기타': ['샐러드', '베이글', '샌드위치', '카페류', '기타'],
    };
    categories = categoryToFoodMap.keys.toList();
    foods = categoryToFoodMap[selectedCategory] ?? [];
    selectedFood = foods.isNotEmpty ? foods.first : '';
  }

  void startMatching() {
    // Firestore에 매칭 정보들 저장하는 코드 작성

    // 매칭 버튼 누르면 타이머 돌아가게끔
    setState(() {
      isMatching = true;
      remainingTime = 300; // 5분!
    });

    // 타이머 설정
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        remainingTime--;
        if (remainingTime <= 0) {
          // 매칭 시간 종료 후 타이머 중지 및 매칭 상태 초기화
          timer.cancel();
          isMatching = false;
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
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
                color: Colors.black,
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
                color: Colors.black,
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return MatchingProgressDialog(
                        selectedCategory: selectedCategory,
                        selectedFood: selectedFood,
                        remainingTime: remainingTime,
                        onCancel: () {
                          // 매칭 취소 관련 코드

                          // 팝업 닫기 , 타이머 중지
                          Navigator.of(context).pop();
                          timer.cancel();
                          setState(() {
                            isMatching = false;
                          });
                        },
                      );
                    },
                  );
                  startMatching();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2B4177),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
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

class MatchingProgressDialog extends StatelessWidget {
  final String selectedCategory;
  final String selectedFood;
  final int remainingTime;
  final VoidCallback onCancel;

  MatchingProgressDialog({
    required this.selectedCategory,
    required this.selectedFood,
    required this.remainingTime,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('매칭 대기 중', style: TextStyle(fontSize: 20)),
            SizedBox(height: 16),
            Text('카테고리: $selectedCategory', style: TextStyle(fontSize: 16)),
            Text('희망메뉴: $selectedFood', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text('매칭 진행 중...', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            CountdownTimerWidget(remainingTime: remainingTime, onFinish: onCancel),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: onCancel,
              child: Text('매칭 취소', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

class CountdownTimerWidget extends StatefulWidget {
  final int remainingTime;
  final VoidCallback onFinish;

  CountdownTimerWidget({required this.remainingTime, required this.onFinish});

  @override
  _CountdownTimerWidgetState createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  late int timeInSeconds;

  @override
  void initState() {
    super.initState();
    timeInSeconds = widget.remainingTime;
    startTimer();
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        timeInSeconds--;
        if (timeInSeconds <= 0) {
          timer.cancel();
          widget.onFinish();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '남은 시간: ${formatDuration(Duration(seconds: timeInSeconds))}',
      style: TextStyle(fontSize: 18),
    );
  }

  String formatDuration(Duration duration) {
    return '${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }
}

void main() {
  runApp(MaterialApp(
    home: MatchingPage(),
  ));
}