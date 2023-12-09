import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import '../chatting/chat/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MatchingPage extends StatefulWidget {
  const MatchingPage({Key? key}) : super(key: key);

  @override
  State<MatchingPage> createState() => _MatchingState();
}

class _MatchingState extends State<MatchingPage> {
  late String selectedCategory;
  late String selectedFood;
  late List<String> foods;
  late Map<String, List<String>> categoryToFoodMap;
  late List<String> categories;

  bool isMatching = false;
  late int remainingTime;
  late Timer timer;
  late DocumentReference? matchingDocument;

  DateTime? matchingStartTime;
  static const int defaultMatchingTime = 300;

  bool isChatRoomCreated = false;
  late String matchingId;
  final int minimumRequiredUsers = 2;
  DocumentReference? chatRoomRef;

  @override
  void initState() {
    super.initState();
    selectedCategory = '한식';
    categoryToFoodMap = {
      '한식': ['족발보쌈', '김치찌개', '된장찌개', '부대찌개', '국밥', '설렁탕', '감자탕', '곱도리탕', '찜닭', '불고기', '비빔밥', '아구찜', '해물찜', '낙곱새', '냉면', '칼국수', '수제비', '기타한식'],
      '중식': ['짜장면', '짬뽕', '탕수육', '마라탕', '마라상궈', '기타중식'],
      '일식': ['돈카츠', '초밥', '라멘', '소바', '타코야끼', '회덮밥', '기타일식'],
      '양식': ['햄버거', '피자', '파스타', '기타양식'],
      '분식': ['김밥', '떡볶이', '쫄면', '라면', '튀김', '순대', '기타분식'],
      '기타': ['샐러드', '베이글', '샌드위치', '카페류', '기타'],
    };
    categories = categoryToFoodMap.keys.toList();
    foods = categoryToFoodMap[selectedCategory] ?? [];
    selectedFood = foods.isNotEmpty ? foods.first : '';
    remainingTime = defaultMatchingTime;
  }

  Future<String?> getCurrentUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  void startMatching() async {
    // 위치 정보 얻기
    Position? userLocation = await getUserLocation();

    setState(() {
      isMatching = true;
      matchingStartTime = DateTime.now();
    });

    // tryMatch를 호출하여 매칭 시도 (userLocation을 전달)
    await tryMatch(userLocation);

    // 타이머 설정
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        remainingTime--;
        if (remainingTime <= 0) {
          timer.cancel();
          isMatching = false;
        }
      });
    });
  // 이제 tryMatch를 호출하여 매칭 시도
    await tryMatch(userLocation);
  }

  Future<void> tryMatch(Position? userLocation) async {
    final currentUserUid = await getCurrentUserId();
    final currentUserInfo = {
      'selectedCategory': selectedCategory,
      'selectedFood': selectedFood,
      'userLocation': userLocation != null ? GeoPoint(userLocation.latitude, userLocation.longitude) : null,
      'userId': currentUserUid,
      'accept': 0, // 초기값은 0
    };

    // 1. 파이어베이스 탐색
    final matchingCollection = FirebaseFirestore.instance.collection('wait_Matching');
    final query = matchingCollection
        .where('selectedCategory', isEqualTo: selectedCategory)
        .where('selectedFood', isEqualTo: selectedFood)
        .where('accept', isEqualTo: 0);

    final matchingSnapshot = await query.get();

    if (matchingSnapshot.docs.isNotEmpty) {
      // 1-1. 조건을 충족하는 문서가 있다면
      final matchingDoc = matchingSnapshot.docs.first;
      final matchingDocId = matchingDoc.id;

      await matchingCollection.doc(matchingDocId).update({
        'user1': currentUserInfo, // 현재 사용자 정보 저장
      });

      // 2. 여기서 사용자가 2명 이상인 경우 다이얼로그를 띄워준다.
      if (matchingDoc['user1'] != null && matchingDoc['user2'] != null) {
        await showMatchSuccessDialog(matchingDoc);
      }
    } else {
      // 1-2. 조건을 충족하는 문서가 없다면 새로운 문서를 생성
      await matchingCollection.add({
        'user1': currentUserInfo,
      });
    }
  }


  Future<void> showMatchSuccessDialog(DocumentSnapshot matchingDoc) async {
    // 2. 다이얼로그 표시 및 채팅방 생성
    bool shouldNavigateToChat = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('매칭 성공!'),
          content: Text('채팅방에 입장하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // 거절
              },
              child: Text('거절'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // 수락
              },
              child: Text('수락'),
            ),
          ],
        );
      },
    );

    if (shouldNavigateToChat) {
      // 2-1. 채팅방으로 이동
      await navigateToChat(matchingDoc);
    } else {
      // 2-2. 거절한 경우 wait_Matching 문서에서 현재 사용자 정보 삭제
      final currentUserUid = await getCurrentUserId();
      await matchingDoc.reference.update({
        if (matchingDoc['user1']['userId'] == currentUserUid) 'user1': null,
        if (matchingDoc['user2']['userId'] == currentUserUid) 'user2': null,
      });
    }
  }

  Future<void> navigateToChat(DocumentSnapshot matchingDoc) async {
    // 2-1. 채팅방 생성
    final user1 = matchingDoc['user1'];
    final user2 = matchingDoc['user2'];

    final chatRoomRef = await createChatRoom(user1, user2);

    // 3. 해당 문서의 사용자가 수락을 눌렀을 경우 accept 필드값을 1로 업데이트
    final currentUserUid = await getCurrentUserId();
    if (user1 != null && user2 != null) {
      if (user1['userId'] == currentUserUid) {
        // user1이 현재 사용자인 경우
        await matchingDoc.reference.update({'user1.accept': 1});
      } else if (user2['userId'] == currentUserUid) {
        // user2가 현재 사용자인 경우
        await matchingDoc.reference.update({'user2.accept': 1});
      }
    }
  }


  Future<Position?> getUserLocation() async {
    // 위치 권한 요청
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      // 위치 권한이 거부된 경우
      return null;
    }

    // 현재 위치 정보 얻기
    return await Geolocator.getCurrentPosition();
  }
  Future<DocumentReference> createChatRoom(Map<String, dynamic> user1, Map<String, dynamic> user2) async {
    // 채팅방 생성
    final chatRoomRef = await FirebaseFirestore.instance.collection('chatRooms').add({
      'users': [user1['userId'], user2['userId']],
      'created_at': FieldValue.serverTimestamp(),
    });

    // 사용자 정보에 채팅방 ID 추가
    await FirebaseFirestore.instance.collection('users').doc(user1['userId']).update({
      'chatRoomIds': FieldValue.arrayUnion([chatRoomRef.id]),
    });

    await FirebaseFirestore.instance.collection('users').doc(user2['userId']).update({
      'chatRoomIds': FieldValue.arrayUnion([chatRoomRef.id]),
    });

    return chatRoomRef;
  }

  void cancelMatching() {
    cancelMatchingAsync();
  }

  Future<void> cancelMatchingAsync() async {
    // 비동기 작업 수행
    final currentUserUid = await getCurrentUserId();
    final matchingCollection = FirebaseFirestore.instance.collection('wait_Matching');
    final query = matchingCollection
        .where('user1.userId', isEqualTo: currentUserUid)
        .where('accept', isEqualTo: 0);

    final matchingSnapshot = await query.get();

    if (matchingSnapshot.docs.isNotEmpty) {
      // Firestore에서 해당 문서 삭제
      final matchingDoc = matchingSnapshot.docs.first;
      await matchingDoc.reference.delete();
    }

    // 팝업 닫기, 타이머 중지, 매칭 상태 초기화
    Navigator.of(context).pop();
    timer.cancel();

    // 비동기 작업 완료 후 setState 호출
    setState(() {
      isMatching = false;
      matchingStartTime = null;
      remainingTime = defaultMatchingTime; // 매칭 취소 시 기본값으로 초기화
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox.shrink(),
        leading: Container(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '카테고리를 선택하세요',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                  foods = categoryToFoodMap[selectedCategory] ?? [];
                  selectedFood = foods.isNotEmpty ? foods.first : '';
                });
              },
              style: TextStyle(fontSize: 18, color: Colors.black),
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 36,
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              elevation: 8,
              isExpanded: true,
              items: categories.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              '희망 주문 메뉴를 선택하세요',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedFood,
              onChanged: (String? newValue) {
                setState(() {
                  selectedFood = newValue!;
                });
              },
              style: TextStyle(fontSize: 18, color: Colors.black),
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 36,
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              elevation: 8,
              isExpanded: true,
              items: foods.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return MatchingProgressDialog(
                        selectedCategory: selectedCategory,
                        selectedFood: selectedFood,
                        remainingTime: remainingTime,
                        onCancel: cancelMatching,
                      );
                    },
                  );
                  startMatching();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2B4177),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '매칭시작',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MatchingProgressDialog extends StatelessWidget {
  final String selectedCategory;
  final String selectedFood;
  final int remainingTime;
  final VoidCallback onCancel;

  MatchingProgressDialog({
    required this.selectedCategory,
    required this.selectedFood,
    required this.remainingTime,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('매칭 대기 중', style: TextStyle(fontSize: 20)),
            SizedBox(height: 16),
            Text('카테고리: $selectedCategory', style: TextStyle(fontSize: 16)),
            Text('희망메뉴: $selectedFood', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text('매칭 진행 중...', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            CountdownTimerWidget(remainingTime: remainingTime, onFinish: onCancel),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: onCancel,
              child: Text('매칭 취소', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

class CountdownTimerWidget extends StatefulWidget {
  final int remainingTime;
  final VoidCallback onFinish;

  CountdownTimerWidget({required this.remainingTime, required this.onFinish});

  @override
  _CountdownTimerWidgetState createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  late int timeInSeconds;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timeInSeconds = widget.remainingTime;
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          timeInSeconds--;
          if (timeInSeconds <= 0) {
            timer.cancel();
            widget.onFinish();
          }
        });
      } else {
        //타이머 취소
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer.cancel(); // 위젯이 dispose-> 타이머를 취소
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '남은 시간: ${formatDuration(Duration(seconds: timeInSeconds))}',
      style: TextStyle(fontSize: 18),
    );
  }

  String formatDuration(Duration duration) {
    return '${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }
}