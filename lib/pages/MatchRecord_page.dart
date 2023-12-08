import 'package:flutter/material.dart';
import 'package:ossp_pickme/pages/OrderDetail_page.dart';
import 'package:ossp_pickme/pages/Review_page.dart';
import 'package:ossp_pickme/pages/Match_page.dart';
import 'package:ossp_pickme/pages/Inquiry_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MatchRecord extends StatelessWidget {
  const MatchRecord({super.key});

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
    String category = matchingInfo['category'] ?? '';
    String food = matchingInfo['food'] ?? '';
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
                  height: 130,
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
                              color: Colors.black.withOpacity(0.20000000298023224),
                              fontSize: 11,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: -0.30,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 37,
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: Text(
                            '이미지',  // 여기서 이미지를 어떻게 처리할지에 대한 정보가 없어서 임시로 '이미지'라고 표시함
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: -0.30,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 108,
                        top: 39,
                        child: SizedBox(
                          width: 110,
                          height: 20,
                          child: Text(
                            category,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: -0.30,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 108,
                        top: 63,
                        child: SizedBox(
                          //width: 110,
                          height: 15,
                          child: Text(
                            food,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 9,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: -0.30,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 108,
                        top: 89,
                        child: Container(
                          width: 70,
                          height: 27,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFCFCFC),
                            shape: RoundedRectangleBorder(side: BorderSide(width: 1)),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 189,
                        top: 89,
                        child: Container(
                          width: 70,
                          height: 27,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFCFCFC),
                            shape: RoundedRectangleBorder(side: BorderSide(width: 1)),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 194,
                        top: 91,
                        child: SizedBox(
                          width: 60,
                          height: 24,
                          child: TextButton(
                            onPressed: () {
                              // 리뷰쓰기 버튼이 클릭되었을 때의 동작
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReviewPage(
                                    restaurantName: category,
                                    menuName: food,
                                    orderDate: formattedDate,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              '리뷰쓰기',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0,
                                letterSpacing: -0.30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 270,
                        top: 89,
                        child: Container(
                          width: 70,
                          height: 27,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFCFCFC),
                            shape: RoundedRectangleBorder(side: BorderSide(width: 1)),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 113,
                        top: 91,
                        child: SizedBox(
                          width: 60,
                          height: 24,
                          child: TextButton(
                            onPressed: () {
                              // "재주문" 버튼이 클릭되었을 때의 동작
                              // 여기서는 Match_page.dart로 이동하도록 설정
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MatchingPage(),
                                ),
                              );
                            },
                            child: Text(
                              '재주문',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0,
                                letterSpacing: -0.30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 275,
                        top: 91,
                        child: SizedBox(
                          width: 60,
                          height: 24,
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
                                fontSize: 11,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0,
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