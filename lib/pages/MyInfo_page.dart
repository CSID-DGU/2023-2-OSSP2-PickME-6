import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ossp_pickme/pages/MatchRecord_page.dart';
import 'package:ossp_pickme/pages/Login_page.dart';
import 'package:ossp_pickme/pages/Inquiry_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'add_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>_MyInfoState();
}

class _MyInfoState extends State<MyInfoPage> {
  final _authentication = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String _profileImage = 'assets/silhouette_image.jpg'; // 기본 이미지 경로
  String _nickname = '';


  @override
  void initState() {
    super.initState();
    // 페이지가 생성될 때 닉네임을 Firestore에서 가져와서 업데이트
    _fetchNickname();
  }

  Future<void> _fetchNickname() async {
    try {
      User? user = _authentication.currentUser;

      if (user != null) {
        // Firestore에서 닉네임 가져오기
        DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore.collection('user').doc(user.uid).get();

        // 가져온 닉네임을 상태에 반영
        setState(() {
          _nickname = snapshot['nickName'] ?? '';
        });
      }
    } catch (e) {
      print('닉네임을 가져오는 동안 오류 발생: $e');
    }
  }

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
                    left: 120,
                    top: 27.39,
                    child: SizedBox(
                      width: 257.17,
                      height: 30,
                      child: Text(
                        _nickname,
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
                    left: 120,
                    top: 81.80,
                    child: SizedBox(
                      width: 135,
                      height: 25,
                      child: Text(
                        '동국대 서울캠퍼스',
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
                    left: 120,
                    top: 56.84,
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
                    top: 30,
                    child: SizedBox(  // 이미지
                      width: 80,
                      height: 80,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(_profileImage),
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
          child: InkWell(
            onTap: () {
              // 비밀번호 변경 버튼을 눌렀을 때 비밀번호 변경 창으로 이동
              _showChangePasswordDialog();
            },
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
        ),
        Positioned(
          child: InkWell(
            onTap: () {
              _showChangeProfileImageDialog(context);
            },
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
        ),
        Positioned(
          child: InkWell(
            onTap: () {
              _showChangeNicknameDialog();
            },
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
                _firestore.collection("user").doc(user!.uid).delete().then(
                      (doc) => print("Document deleted"),
                  onError: (e) => print("Error updating document $e"),
                );
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

  // 비밀번호 변경 팝업창
  Future<void> _showChangePasswordDialog() async {
    String? currentPassword;
    String? newPassword;
    String? confirmPassword;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('비밀번호 변경'),
          content: Column(
            children: [
              TextField(
                obscureText: true,
                onChanged: (value) {
                  currentPassword = value;
                },
                decoration: InputDecoration(labelText: '현재 비밀번호'),
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  newPassword = value;
                },
                decoration: InputDecoration(labelText: '새 비밀번호'),
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  confirmPassword = value;
                },
                decoration: InputDecoration(labelText: '새 비밀번호 확인'),
              ),
            ],
          ),
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
                if (currentPassword != null && newPassword != null && confirmPassword != null && newPassword == confirmPassword) {
                  // 현재 비밀번호 확인 및 새 비밀번호 일치 여부 확인 후 비밀번호 변경 로직 수행
                  _changePassword(currentPassword!, confirmPassword!, newPassword!);
                  Navigator.of(context).pop();
                } else {
                  // 비밀번호 불일치 에러 처리
                }
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  // 비밀번호 변경 로직
  void _changePassword(String currentPassword, String confirmPassword, String newPassword) async {
    try {
      User? user = _authentication.currentUser;

      // 현재 비밀번호 확인
      if (!await _checkCurrentPassword(user!.email!, currentPassword)) {
        // 실패 메시지 표시
        _showFailureDialog('현재 비밀번호를 잘못 입력했습니다.');
        return;
      }

      // 새 비밀번호가 6자리 이상인지 확인
      if (newPassword.length < 6) {
        // 실패 메시지 표시
        _showFailureDialog('새 비밀번호는 6자리 이상이어야 합니다.');
        return;
      }

      // 새 비밀번호와 확인 값이 일치하는지 확인
      if (confirmPassword != newPassword) {
        // 실패 메시지 표시
        _showFailureDialog('새 비밀번호 입력과 새 비밀번호 확인이 일치하지 않습니다.');
        return;
      }

      // 비밀번호 변경 성공 시 Firestore DB에 반영
      await user.updatePassword(newPassword);

      // Firestore DB에도 반영
      await _firestore.collection('user').doc(user.uid).update({
        'password': newPassword,
      });

      // 비밀번호 변경 성공 메시지 등 추가 로직 수행
      print('비밀번호가 성공적으로 변경되었습니다.');
    } catch (e) {
      // 실패 메시지 표시
      _showFailureDialog('비밀번호 변경 중 오류 발생');
    }
  }

// 현재 비밀번호 확인 함수
  Future<bool> _checkCurrentPassword(String email, String currentPassword) async {
    try {
      UserCredential userCredential = await _authentication.signInWithEmailAndPassword(
        email: email,
        password: currentPassword,
      );
      // 로그인에 성공하면 현재 비밀번호가 맞는 것으로 간주
      return true;
    } catch (e) {
      // 로그인 실패 시
      return false;
    }
  }

  // 비밀번호 변경 실패 팝업창
  void _showFailureDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('오류'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  /*
  Future<void> _updatePasswordInFirestore(String userId, String newPassword) async {
    try {
      DocumentReference<Map<String, dynamic>> userDoc =
      _firestore.collection('user').doc(userId);

      // 사용자의 비밀번호를 업데이트
      await userDoc.update({'password': newPassword});

      print('Firestore에 사용자의 비밀번호를 성공적으로 업데이트했습니다.');
    } catch (e) {
      print('Firestore에서 비밀번호 업데이트 중 오류 발생: $e');
    }
  }
*/
  // 이미지 변경
  void _showChangeProfileImageDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (context){
          return Dialog(
            backgroundColor: Colors.white,
            child: AddImage(),
          );
        },
    );
  }

  // 닉네임 변경 다이얼로그
  Future<void> _showChangeNicknameDialog() async {
    String newNickname = '';
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // 사용자의 현재 닉네임을 가져옵니다.
      final currentNickname = user.displayName;

      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('닉네임 변경'),
            content: Column(
              children: [
                // 기존 닉네임을 보여줍니다.
                Text('기존 닉네임: $currentNickname'),

                // 새로운 닉네임을 입력받습니다.
                TextField(
                  onChanged: (value) {
                    newNickname = value;
                  },
                  decoration: InputDecoration(labelText: '새로운 닉네임'),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('취소'),
              ),
              TextButton(
                onPressed: () async {
                  await _updateNickname(user, newNickname);
                  Navigator.of(context).pop();
                },
                child: Text('변경'),
              ),
            ],
          );
        },
      );
    } else {
      // 사용자가 로그인되어 있지 않은 경우에 대한 예외 처리
      print('사용자가 로그인되어 있지 않습니다.');
    }
  }

  // 새로운 닉네임으로 업데이트하는 함수 (Firebase 사용)
  Future<void> _updateNickname(User user, String newNickname) async {
    try {
      DocumentReference<Map<String, dynamic>> userDoc =
      _firestore.collection('user').doc(user.uid);

      // 사용자의 닉네임을 업데이트합니다.
      await user.updateDisplayName(newNickname);

      // Firestore에도 닉네임을 업데이트합니다.
      await userDoc.update({'nickName': newNickname});

      // 닉네임이 성공적으로 업데이트되면 해당 정보를 출력하고 상태를 업데이트
      print('Firebase에서 사용자의 닉네임을 성공적으로 업데이트했습니다. 새로운 닉네임: $newNickname');

      // 상태에 반영
      setState(() {
        _nickname = newNickname;
      });

    } catch (e) {
      // 업데이트 중에 오류가 발생한 경우에 대한 예외 처리
      print('닉네임 업데이트 중 오류 발생: $e');
    }
  }
}