import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ossp_pickme/pages/Login_page.dart';
import '../main.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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

  Future<void> addUser(String userId, String userName, String university, String studentID, String nickName, String email, String password) async {
    try {
      await _db.collection('user').doc(userId).set({
        'userName': userName,
        'university': university,
        'studentID': studentID,
        'nickName': nickName,
        'email': email,
        'password': password,
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
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _studentIDController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();
  final ImagePicker _picker = ImagePicker(); // 이미지 피커 인스턴스

  File? _studentIDImage; // 학생증 이미지 파일

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
                controller: _userNameController,
                decoration: InputDecoration(labelText: '이름'),
              ),
            ),
            SizedBox(height: 10),

            // 닉네임 입력
            SizedBox(
              width: 200,
              child: TextField(
                controller: _nickNameController,
                decoration: InputDecoration(labelText: '닉네임'),
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

            // 비밀번호 확인 입력
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: '비밀번호 확인'),
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

                // 학번 입력
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

            // 학생증 첨부 버튼
            ElevatedButton(
              onPressed: _pickStudentIDImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2B4177),
              ),
              child: Text(
                '학생증 첨부',
                style: TextStyle(color: Color(0xFFC4C4C4)),
              ),
            ),

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
                    _userNameController.text,
                    _universityController.text,
                    _studentIDController.text,
                    _nickNameController.text,
                    _emailController.text,
                    _passwordController.text,
                  );

                  // 학생증 이미지 업로드 및 URL 가져오기 아직 안씀
                  final studentIDImageUrl = await _uploadStudentIDImage(newUser.user!.uid);

                  // 회원가입 승인 대기 팝업
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('회원가입 승인대기'),
                        content: Text('회원가입이 되었습니다. 관리자 승인 후 로그인 가능합니다. (약 1시간 소요될 수 있습니다.)'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // 팝업 창 닫기
                              Navigator.of(context).pop();
                              // 로그인 화면으로 이동
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ));
                            },
                            child: Text('확인'),
                          ),
                        ],
                      );
                    },
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
  //이미지 첨부
  Future<void> _pickStudentIDImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _studentIDImage = File(pickedFile.path);
      });
    }
  }

  Future<String> _uploadStudentIDImage(String userId) async {
    try {
      final storage = FirebaseStorage.instance;
      final ref = storage.ref().child('studentIDImages/$userId.jpg');
      await ref.putFile(_studentIDImage!);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      // 이미지 업로드 에러 처리
      rethrow;
    }
  }
}
