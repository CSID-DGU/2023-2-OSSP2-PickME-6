import 'package:flutter/material.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>_MyInfoState();

}

class _MyInfoState extends State<MyInfoPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildTop(),
        _buildBottom(),
      ],
    );
  }

  Widget _buildTop() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: <Widget>[
          Positioned(
            child: Container(
              width: 450,
              height: 200,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 450,
                      height: 200,
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
                    left: 160,
                    top: 30,
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
                  Positioned(
                    left: 160,
                    top: 100,
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
                    left: 160,
                    top: 75,
                    child: SizedBox(
                      width: 92.28,
                      height: 30,
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
                    left: 50,
                    top: 70,
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
                    left: 225,
                    top: 181.60,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..translate(0.0, 0.0)
                        ..rotateZ(-1.57),
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
                    left: 90,
                    top: 156,
                    child: SizedBox(
                      width: 100,
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
                    left: 310,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return Column(
      children: [
        Positioned(
          child: SizedBox(
            width: 420,
            height: 45,
            child: Text(
              '문의하기',
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
          child: SizedBox(
            width: 420,
            height: 45,
            child: Text(
              '비밀번호 변경',
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
          child: SizedBox(
            width: 420,
            height: 45,
            child: Text(
              '프로필 이미지 변경',
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
          child: SizedBox(
            width: 420,
            height: 45,
            child: Text(
              '닉네임 설정',
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
          child: SizedBox(
            width: 420,
            height: 45,
            child: Text(
              '로그아웃',
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
          child: SizedBox(
            width: 420,
            height: 45,
            child: Text(
              '회원탈퇴',
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
    );
  }
}
