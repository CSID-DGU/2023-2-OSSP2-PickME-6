import 'package:flutter/material.dart';
import 'package:ossp_pickme/pages/Match_page.dart';
import 'package:ossp_pickme/pages/Inquiry_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MatchRecord extends StatelessWidget {
  const MatchRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // 뒤로가기 버튼을 눌렀을 때 MyInfoPage로 이동
          },
        ),
        title: Text('매칭기록'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: FutureBuilder<QuerySnapshot>(
        // Firestore에서 데이터 가져오기
        future: FirebaseFirestore.instance.collection('matchingInfo').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // 데이터 로딩 중일 때 표시할 UI
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // 오류가 발생한 경우
          }

          // 데이터 가져오기 성공
          final data = snapshot.data!.docs;

          return ListView(
            children: [
              AdvertisementItem(),
              for (var document in data)
                MatchingRecord(
                  matchingInfo: document,
                ),
            ],
          );
        },
      ),
    );
  }
}

class AdvertisementItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      alignment: Alignment.center,
      child: Text('광고'),
    );
  }
}

class MatchingRecord extends StatelessWidget {
  final DocumentSnapshot matchingInfo;

  const MatchingRecord({
    required this.matchingInfo,
  });

  @override
  Widget build(BuildContext context) {
    String category = matchingInfo['user1']['selectedCategory'] ?? '';
    String food = matchingInfo['user1']['selectedFood'] ?? '';
    Timestamp timestamp = matchingInfo['timestamp'] ?? Timestamp.now();

    // Timestamp를 DateTime으로 변환
    DateTime date = timestamp.toDate();
    String formattedDate = '${date.year}. ${date.month}. ${date.day}';

    return Column(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  height: 140,  // 재주문, 문의하기 버튼 크기 조절
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(side: BorderSide(width: 1)),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 8,
                        top: 7,
                        child: SizedBox(
                          width: 103,
                          height: 16,
                          child: Text(
                            formattedDate,
                            style: TextStyle(
                              //color: Color(0xFF424242),
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1.0,  // 텍스트 높이를 조정하여 중앙에 맞춤
                              letterSpacing: -0.30,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 8,
                        top: 39,
                        child: SizedBox(
                          width: 230,
                          height: 20,
                          child: Text(
                            '카테고리: $category',  // 카테고리 출력 방식 변경
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1.0,  // 텍스트 높이를 조정하여 중앙에 맞춤
                              letterSpacing: -0.30,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 8,
                        top: 63,
                        child: SizedBox(
                          //width: 110,
                          height: 15,
                          child: Text(
                            '음식: $food',  // 음식 출력 방식 변경
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1.0,  // 텍스트 높이를 조정하여 중앙에 맞춤
                              letterSpacing: -0.30,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 101,
                        child: Container(
                          width: 150,
                          height: 34,  // 재주문 버튼 크기 조절
                          decoration: ShapeDecoration(
                            color: Color(0xFFFCFCFC),
                            shape: RoundedRectangleBorder(side: BorderSide(width: 1)),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 101,
                        child: Container(
                          width: 150,
                          height: 34,  // 문의하기 버튼 크기 조절
                          decoration: ShapeDecoration(
                            color: Color(0xFFFCFCFC),
                            shape: RoundedRectangleBorder(side: BorderSide(width: 1)),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 55,
                        top: 106,
                        child: SizedBox(
                          width: 60,
                          height: 30,  // 재주문 버튼 크기 조절
                          child: TextButton(
                            onPressed: () {
                              // "재주문" 버튼이 클릭되었을 때의 동작
                              // 여기서는 Match_page.dart로 이동하도록 설정
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MatchingPage(
                                    // 주문내역 정보를 초기 선택값으로 전달
                                    initialCategory: category,
                                    initialFood: food,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              '재주문',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 1.0,  // 텍스트 높이를 조정하여 중앙에 맞춤
                                letterSpacing: -0.30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 45,
                        top: 106,
                        child: SizedBox(
                          width: 80,
                          height: 30,  // 문의하기 버튼 크기 조절
                          child: TextButton(
                            onPressed: () {
                              // "문의하기" 버튼이 클릭되었을 때의 동작
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InquiryPage(), // InquiryPage로 이동
                                ),
                              );
                            },
                            child: Text(
                              '문의하기',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 1.0,  // 텍스트 높이를 조정하여 중앙에 맞춤
                                letterSpacing: -0.30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}