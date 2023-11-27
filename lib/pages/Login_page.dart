import 'package:flutter/material.dart';
import 'package:ossp_pickme/pages/SignUp_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ossp_pickme/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _authentication = FirebaseAuth.instance;

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

            // 아이디 입력
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: '아이디',
                hintText: '아이디를 입력하세요',
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

            // 로그인 버튼
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try{
                  final newUser =
                      await _authentication.signInWithEmailAndPassword(
                      email: _idController.text,
                      password: _passwordController.text
                  );
                  if (newUser.user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return MyHomePage(
                          title: 'PickME',
                        );
                      }),
                    );
                  }
                }catch(e){
                  print(e);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                      Text('존재하지 않는 아이디나 비밀번호입니다.'),
                      backgroundColor: Colors.blue,
                    ),
                  );
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

            // 다른 로그인 방법 버튼
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                // 다른 로그인 방법 버튼 -> 카카오(?) 하거나 삭제.
              },
              child: Text(
                '다른 로그인 방법',
                style: TextStyle(color: Colors.black), // 글자색
              ),
            ),
            // 회원가입 문구
            SizedBox(height: 10),
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
          ],
        ),
      ),
    );
  }
}
