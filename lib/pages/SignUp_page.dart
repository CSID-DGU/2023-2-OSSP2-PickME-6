import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signUp(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      // 에러 처리
      rethrow;
    }
  }

}

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser(String userId, String name, String university, String studentID) async {
    try {
      await _db.collection('users').doc(userId).set({
        'name': name,
        'university': university,
        'studentID': studentID,
        'role': 0,
      });
    } catch (e) {
      // 에러 처리
      rethrow;
    }
  }

}

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _studentIDController = TextEditingController();

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
            // 이름 입력
            SizedBox(
              width: 200,
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: '이름'),
              ),
            ),
            SizedBox(height: 10),
            // 이메일 입력
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: '이메일'),
            ),
            SizedBox(height: 10),
            // 비밀번호 입력
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: '비밀번호'),
            ),
            SizedBox(height: 10),
            // 비밀번호 재입력
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: '비밀번호 재입력'),
            ),
            SizedBox(height: 10),
            // 대학교 입력, 학번 입력
            Row(
              children: [
                // 대학교 입력
                Expanded(
                  child: TextField(
                    controller: _universityController,
                    decoration: InputDecoration(labelText: '대학교'),
                  ),
                ),
                SizedBox(width: 10), // 간격 조절
                // 학번 입력칸
                SizedBox(
                  width: 150, //크기 조절
                  child: TextField(
                    controller: _studentIDController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: '학번'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10), // 간격 조절
            // 회원가입 버튼
            ElevatedButton(
              onPressed: () async {
                try {
                  final newUser = await AuthService().signUp(
                    _emailController.text,
                    _passwordController.text,
                  );

                  await FirestoreService().addUser(
                    newUser.user!.uid,
                    _nameController.text,
                    _universityController.text,
                    _studentIDController.text,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return MyHomePage(
                        title: 'PickME',
                      );
                    }),
                  );
                } catch (e) {
                  // 에러 처리
                  if (e is FirebaseAuthException) {
                    if (e.code == 'email-already-in-use') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('이미 생성된 이메일 주소입니다.'),
                          backgroundColor: Colors.blue,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('회원가입에 실패했습니다. 다시 시도해주세요.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
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