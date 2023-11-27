
import 'package:flutter/material.dart';
import 'package:ossp_pickme/pages/MatchRecord_page.dart';
import 'package:ossp_pickme/pages/Login_page.dart';
import 'package:ossp_pickme/pages/Inquiry_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
class MyInfoPage extends StatefulWidget {
  const MyInfoPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>_MyInfoState();
}

class _MyInfoState extends State<MyInfoPage> {
  final _authentication = FirebaseAuth.instance;

  @override
  final List<Widget> _pages = [
    const MatchRecord(),
    const LoginPage(),
  ];

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
              width: 368.17,
              //height: 194,
              child: Stack(
                children: [
                  Positioned(
                    //left: 0,
                    //top: 0,
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
                    top: 50,
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
                    left: 69,
                    top: 156,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MatchRecord()),
                        );
                      },
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
          child: InkWell(
            onTap: () {
              // 문의하기 버튼을 눌렀을 때 InquiryPage로 이동
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InquiryPage()),
              );
            },
            child: SizedBox(
              width: 321,
              height: 40,
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
        ),
        Positioned(
          child: SizedBox(
            width: 321,
            height: 40,
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
            width: 321,
            height: 40,
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
            width: 321,
            height: 40,
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
          child: InkWell(
            onTap: () {
              _authentication.signOut();
              Navigator.pop(context);
            },
            child: SizedBox(
              width: 321,
              height: 40,
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
        ),
        Positioned(
          child: InkWell(
            onTap: () {
              // 회원 탈퇴 팝업창 띄우기
              _showConfirmationDialog();
            },
            child: SizedBox(
              width: 321,
              height: 40,
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
        ),
      ],
    );
  }
  // 회원 탈퇴 확인 팝업창
  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('회원 탈퇴'),
          content: Text('정말 탈퇴하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // 취소 버튼
                Navigator.of(context).pop();
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                // 확인 버튼
                User? user = _authentication.currentUser;
                user!.delete();
                // 로그인 화면으로 이동
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
