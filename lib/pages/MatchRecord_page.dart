import 'package:flutter/material.dart';
import 'package:ossp_pickme/pages/OrderDetail_page.dart';

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
        title: Text('주문내역'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: ListView(
        children: [
          AdvertisementItem(),
          MatchingRecord(
            date: '11. 15(수) · 배달완료',
            image: '이미지',
            restaurantName: '라화방마라탕',
            menuName: '마라탕 1개 + 마라샹궈 1개 + 코카콜라제로 2개',
          ),
          MatchingRecord(
            date: '11. 12(일) · 배달완료',
            image: '이미지',
            restaurantName: '동국반점',
            menuName: '해오름세트',
          ),
          MatchingRecord(
            date: '11. 8(수) · 배달완료',
            image: '이미지',
            restaurantName: '행복은간장밥',
            menuName: '행복한 싱글 SET 1개',
          ),
          MatchingRecord(
            date: '11. 4(토) · 배달완료',
            image: '이미지',
            restaurantName: '필동반점',
            menuName: '간짜장 1개 + 차돌짬뽕 2개',
          ),
          MatchingRecord(
            date: '10. 30(월) · 배달완료',
            image: '이미지',
            restaurantName: '동국반점',
            menuName: 'A세트 1개',
          ),
        ],
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
  final String date;
  final String image;
  final String restaurantName;
  final String menuName;

  const MatchingRecord({
    required this.date,
    required this.image,
    required this.restaurantName,
    required this.menuName,
  });

  @override
  Widget build(BuildContext context) {
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
                            date,
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
                            image,
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
                            restaurantName,
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
                            menuName,
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
                      Positioned(
                        left: 275,
                        top: 91,
                        child: SizedBox(
                          width: 60,
                          height: 24,
                          child: TextButton(
                            onPressed: () {
                              // 주문상세 버튼이 클릭되었을 때의 동작
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderDetailPage(
                                    restaurantName: restaurantName,
                                    menuName: menuName,
                                    orderTime: date,
                                    isRepresentative: false, // 대표결제자 여부
                                    matchingMembers: 3, // 매칭된 인원 수
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              '주문상세',
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