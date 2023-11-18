import 'package:flutter/material.dart';

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
          MatchingRecord(),
          MatchingRecord(),
          MatchingRecord(),
          MatchingRecord(),
        ],
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
          //width: 360,
          //height: 640,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                //left: 0,
                //top: 148,
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
            ],
          ),
        ),
      ],
    );
  }
}