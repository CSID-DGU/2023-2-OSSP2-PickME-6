import 'package:flutter/material.dart';

void main() {
  runApp(const myPage());
}

class myPage extends StatelessWidget {
  const myPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(children: [
          Pp(),
        ]),
      ),
    );
  }
}

class Pp extends StatelessWidget {
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
                top: 46,
                child: SizedBox(
                  width: 360,
                  height: 41,
                  child: Text(
                    '마이페이지',
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
              Positioned(
                left: -2,
                top: 91,
                child: Container(
                  width: 368.17,
                  height: 194,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 360,
                          height: 194,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x19000000),
                                blurRadius: 5,
                                offset: Offset(2, 4),
                                spreadRadius: 3,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 111,
                        top: 71.80,
                        child: SizedBox(
                          width: 135,
                          height: 25,
                          child: Text(
                            '동국대 서울캠 00학번',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: -0.30,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 111,
                        top: 46.84,
                        child: SizedBox(
                          width: 92.28,
                          height: 20,
                          child: Text(
                            '실명',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: -0.30,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 22,
                        top: 11.90,
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
                        left: 180.57,
                        top: 181.60,
                        child: Transform(
                          transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-1.57),
                          child: Container(
                            width: 28.74,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 0.50,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Color(0xFFC4C4C4),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 69,
                        top: 156,
                        child: SizedBox(
                          width: 71.77,
                          height: 25,
                          child: Text(
                            '주문내역',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: -0.30,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 234.54,
                        top: 156.53,
                        child: SizedBox(
                          width: 92.28,
                          height: 25,
                          child: Text(
                            '리뷰관리',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: -0.30,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 111,
                        top: 17.39,
                        child: SizedBox(
                          width: 257.17,
                          height: 30,
                          child: Text(
                            '닉네임',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
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
