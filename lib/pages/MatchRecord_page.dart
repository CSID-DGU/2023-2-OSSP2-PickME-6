import 'package:flutter/material.dart';

void main() {
  runApp(const MatchRecord());
}

class MatchRecord extends StatelessWidget {
  const MatchRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(children: [
          MatchingRecord(),
        ]),
      ),
    );
  }
}

class MatchingRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 360,
          height: 640,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 148,
                child: Container(
                  width: 360,
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
                            '11. 3(금) · 배달완료',
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
                            '이미지',
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
                            '음식점 이름',
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
                          width: 110,
                          height: 15,
                          child: Text(
                            '메뉴명',
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
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 148,
                child: Container(
                  width: 360,
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
                            '11. 3(금) · 배달완료',
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
                            '이미지',
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
                            '음식점 이름',
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
                          width: 110,
                          height: 15,
                          child: Text(
                            '메뉴명',
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
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 416,
                child: Container(
                  width: 360,
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
                            '10. 20(금) · 배달완료',
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
                            '이미지',
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
                            '음식점 이름',
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
                          width: 110,
                          height: 15,
                          child: Text(
                            '메뉴명',
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
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 282,
                child: Container(
                  width: 360,
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
                            '11. 1(수) · 배달완료',
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
                            '이미지',
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
                            '음식점 이름',
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
                          width: 110,
                          height: 15,
                          child: Text(
                            '메뉴명',
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
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 87,
                child: Container(
                  width: 360,
                  height: 60,
                  decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                ),
              ),
              Positioned(
                left: 138,
                top: 102,
                child: SizedBox(
                  width: 85,
                  height: 30,
                  child: Text(
                    '광고',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: -0.33,
                    ),
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