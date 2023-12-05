import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ossp_pickme/main.dart';
import 'package:ossp_pickme/pages/SignUp_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _authentication = FirebaseAuth.instance;
  bool _showSignUp = true;

  Future<void> _resetPassword(String email) async {
    try {
      await _authentication.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('비밀번호 재설정 이메일을 보냈습니다. 이메일을 확인해주세요.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('이메일을 확인하고 다시 시도해주세요.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인 페이지 구현'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 로고 이미지 추가
            Transform.translate(
              offset: Offset(0, -50), // Y 값 조절하여 로고 위쪽으로 이동
              child: Image.asset(
                'assets/logo.png',
                height: 120, // 이미지 크기 조절
              ),
            ),

            // 이메일 입력
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: '이메일',
                hintText: '이메일을 입력하세요',
                border: UnderlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),

            // 비밀번호 입력
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: '비밀번호',
                hintText: '비밀번호를 입력하세요',
                border: UnderlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),

            // 로그인/회원가입/비밀번호 찾기 버튼
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  final newUser = await _authentication.signInWithEmailAndPassword(
                    email: _idController.text,
                    password: _passwordController.text,
                  );

                  if (newUser.user != null) {
                    // 로그인 성공 후 role 확인
                    int role = await _getUserRole(newUser.user!.uid);

                    if (role == 0) {
                      // 승인 대기 중인 경우
                      _showPendingApprovalDialog(context);
                    } else if (role == 1) {
                      // 회원인 경우
                      _navigateToMemberScreen(context);
                    }
                  }
                } catch (e) {
                  // 로그인 실패 처리
                  print(e);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('존재하지 않는 이메일 또는 비밀번호입니다.'),
                      backgroundColor: Colors.blue,
                    ),
                  );

                  // 로그인 실패 시 회원가입/비밀번호 찾기 문구 보이도록 설정
                  setState(() {
                    _showSignUp = false;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2B4177), // 버튼색
              ),
              child: Text(
                '로그인',
                style: TextStyle(color: Colors.white), // 글자색
              ),
            ),

            // 회원가입 문구 / 비밀번호 찾기 문구
            SizedBox(height: 10),
            if (_showSignUp)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                child: Column(
                  children: [
                    Text(
                      '아직 회원이 아니신가요?',
                      style: TextStyle(color: Color(0xFFC4C4C4)),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '회원가입하기',
                      style: TextStyle(
                        color: Color(0xFF2B4177),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            if (!_showSignUp)
              GestureDetector(
                onTap: () {
                  _resetPassword(_idController.text);
                },
                child: Column(
                  children: [
                    Text(
                      '비밀번호를 잊어버리셨나요?',
                      style: TextStyle(color: Color(0xFFC4C4C4)),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '비밀번호 찾기',
                      style: TextStyle(
                        color: Color(0xFF2B4177),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // 사용자의 role 가져오기
  Future<int> _getUserRole(String userId) async {
    try {
      // 사용자 정보 가져오기
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('user').doc(userId).get();

      // role 값
      return userSnapshot['role'];
    } catch (e) {
      // 에러 처리
      print(e);
      return -1; // 에러 발생 리턴값
    }
  }

  // role == 0 인 경우 팝업
  void _showPendingApprovalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('학생 인증 검토중'),
          content: Text('학생 인증 정보 검토중 입니다.'),
          actions: [
            TextButton(
              onPressed: () {
                // 팝업 닫기
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  // 회원인 경우 로그인 성공
  void _navigateToMemberScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return MyHomePage (
          title: 'PickME',
        );
      }),
    );
  }
}
