import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _verificationCodeController = TextEditingController();
  final _authentication = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  bool _isIdAvailable = true; // 아이디 중복 확인 결과 (일단 true로 초기화)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 이름 입력칸
            SizedBox(
              width: 200,
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: '이름'),
              ),
            ),
            SizedBox(height: 10),
            // 아이디 입력칸 및 중복확인 버튼
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _idController,
                    decoration: InputDecoration(labelText: '아이디'),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // 중복 확인 코드 구현 필요
                    _isIdAvailable = true;
                    // 임시로 true 설정
                  },
                  child: Text('중복확인',style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            // 비밀번호 입력칸
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: '비밀번호'),
            ),
            SizedBox(height: 10),
            // 비밀번호 재입력칸
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: '비밀번호 재입력'),
            ),
            SizedBox(height: 10),
            // 휴대폰 번호 입력칸과 인증하기 버튼
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(labelText: '휴대폰 번호'),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // 휴대전화 인증 번호 발송 코드 짜기
                  },
                  child: Text('인증하기',
                  style: TextStyle(color: Colors.black),
                ),
                )
              ],
            ),
            SizedBox(height: 10),
            // 인증번호 확인 칸
            TextField(
              controller: _verificationCodeController,
              decoration: InputDecoration(labelText: '인증번호 확인'),
            ),
            SizedBox(height: 20),
            // 회원가입 버튼
            ElevatedButton(
              onPressed: () async{
                try {
                  final newUser = await _authentication
                      .createUserWithEmailAndPassword(
                    email: _phoneNumberController.text,
                    password: _passwordController.text,
                  );
                  await _db.collection('member').add({'name' : _nameController.text});
                  if(newUser.user!=null){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context){
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
                        Text('이미 생성된 이메일 주소입니다.'),
                        backgroundColor: Colors.blue,
                      ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2B4177),
              ),
              child: Text(
                '회원가입',
                style: TextStyle(color: Color(0xFFC4C4C4)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
