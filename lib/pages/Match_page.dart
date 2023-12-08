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

  void startMatching() async {
    // 위치 정보 얻기
    Position? userLocation = await getUserLocation();

    // 매칭 버튼 누르면 타이머 돌아가게끔
    setState(() {
      isMatching = true;
      matchingStartTime = DateTime.now(); // 매칭 시작 시간 저장
    });

    // 타이머 설정
    timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      setState(() async {
        remainingTime--;
        if (remainingTime <= 0) {
          // 매칭 시간 종료 후 타이머 중지 및 매칭 상태 초기화
          timer.cancel();
          isMatching = false;
          // 사용자 정보 업데이트
          await updateUserMatchingInfo();
        }
      });
    });

    // Firestore에 매칭 정보 및 위치 정보 저장
    matchingDocument = await saveMatchingInfo(selectedCategory, selectedFood, userLocation);

    // 매칭 시도
    await tryMatch(userLocation);
  }

  Future<void> saveAcceptedUserIds(List<String> userIds) async {
    try {
      // Firestore에 동시에 수락한 사용자들의 UID를 저장하는 로직을 추가
      await FirebaseFirestore.instance.collection('yourCollection').doc('yourDocument').update({
        'acceptedUserIds': FieldValue.arrayUnion(userIds),
      });
    } catch (e) {
      print('Error saving accepted user IDs: $e');
      // 에러 처리
    }
  }

  Future<void> setMakerId(String chatRoomId, String makerId) async {
    try {
      // 채팅방의 makerId 필드를 설정
      await FirebaseFirestore.instance.collection('yourChatRoomsCollection').doc(chatRoomId).update({
        'makerId': makerId,
      });
    } catch (e) {
      print('Error setting maker ID: $e');
      // 에러 처리
    }
  }

  Future<DocumentReference> createChatRoomIfNotCreated(List<String> userIds) async {
    try {
      final chatRoomRef = await FirebaseFirestore.instance.collection('yourChatRoomsCollection').add({
        'userIds': userIds,
      });
      return chatRoomRef;
    } catch (e) {
      print('Error creating chat room: $e');
      // 에러 처리
      rethrow;
    }
  }

  Future<void> deleteMatchingInfo(String matchingInfoId) async {
    try {
      // 매칭 정보를 Firestore에서 삭제
      await FirebaseFirestore.instance.collection('matchingInfo').doc(matchingInfoId).delete();
    } catch (e) {
      print('Error deleting matching info: $e');
      // 에러 처리
    }
  }

  Future<DocumentReference> getChatRoomRef(String matchingInfoId) async {
    try {
      final matchingInfoDoc = await FirebaseFirestore.instance.collection('matchingInfo').doc(matchingInfoId).get();
      final chatRoomId = matchingInfoDoc['chatRoomId'];
      return FirebaseFirestore.instance.collection('yourChatRoomsCollection').doc(chatRoomId);
    } catch (e) {
      print('Error getting chat room reference: $e');
      // 에러 처리
      rethrow;
    }
  }

  Future<void> updateUserMatchingInfo() async {
    // 사용자 정보 업데이트
    final user = FirebaseAuth.instance.currentUser;
    final matchingInfoRef = FirebaseFirestore.instance.collection('matchingInfo').doc(user!.uid);
    await matchingInfoRef.update({'isMatching': false});
  }

  Future<String?> getCurrentUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }
    Future<void> tryMatch(Position? userLocation) async {
      // 현재 사용자의 정보
      final currentUserInfo = {
        'selectedCategory': selectedCategory,
        'selectedFood': selectedFood,
        'userLocation': userLocation != null ? GeoPoint(
            userLocation.latitude, userLocation.longitude) : null,
        'userId': await getCurrentUserId(), // 현재 사용자의 UID 추가
      };

      // 매칭을 시도하고, 조건에 맞는 사용자
      final matchingSnapshot = await FirebaseFirestore.instance
          .collection('matchingInfo')
          .where('selectedCategory', isEqualTo: selectedCategory)
          .where('selectedFood', isEqualTo: selectedFood)
          .where('isMatching', isEqualTo: true)
          .get();

      if (matchingSnapshot.docs.length >= 2) {
        final currentUserUid = currentUserInfo['userId'];

        final matchedUsers = <String>[]; // 매칭성공 사용자들의 UID를 저장할 리스트

        for (final matchingDoc in matchingSnapshot.docs) {
          final matchingData = matchingDoc.data() as Map<String, dynamic>;

          if (currentUserUid != matchingData['userId']) {
            final matchingUserLocation = matchingData['userLocation'] as GeoPoint?;

            if (matchingUserLocation != null) {
              final double distance = Geolocator.distanceBetween(
                userLocation!.latitude,
                userLocation.longitude,
                matchingUserLocation.latitude,
                matchingUserLocation.longitude,
              );

              if (distance <= 500) {
                // 거리가 500m 이내이면 매칭 성공
                matchedUsers.add(matchingData['userId']);
              }
            }
          }
        }

        if (matchedUsers.length >= 1) {
          // 매칭 성공한 유저들에게 팝업
          bool shouldNavigateToChat = await showMatchSuccessPopup();

          // 수락한 사용자들의 UID를 Firestore에 저장
          await saveAcceptedUserIds(matchedUsers);

          // 최소 사용자 수 이상이면 채팅방 생성
          if (matchedUsers.length >= minimumRequiredUsers) {
            final chatRoomRef = await createChatRoomIfNotCreated(matchedUsers);

          }
        } else {
          // 매칭 실패
          print('매칭 실패: 조건에 맞는 사용자가 없거나 거리가 500m 이내가 아님');
        }
      }
    }
  Future<DocumentReference> createChatRoom(Map<String, dynamic> user1, Map<String, dynamic> user2) async {
    // 채팅방 생성
    final chatRoomRef = await FirebaseFirestore.instance.collection('chatRooms').add({
      'users': [user1['userId'], user2['userId']],
      'timestamp': FieldValue.serverTimestamp(),
    });

    // 매칭 성공 시 팝업 표시
    bool shouldNavigateToChat = await showMatchSuccessPopup();

    print('채팅방 생성 완료: ${chatRoomRef.id}');

    // 팝업에서 수락한 경우에만 채팅방으로 이동
    if (shouldNavigateToChat) {
      // 현재 화면 종료하고 ChatScreen으로 이동
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(documentId: chatRoomRef.id),
        ),
      );
    } else {
      // 사용자가 거절한 경우 매칭 페이지로 이동
      Navigator.of(context).pop();
    }
    return chatRoomRef;
  }


  Future<bool> showMatchSuccessPopup() async {
    // 매칭 성공 시 팝업 표시
    return await showDialog(
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

  Future<DocumentReference> saveMatchingInfo(String selectedCategory, String selectedFood, Position? userLocation) async {
    // Firestore 컬렉션에 "matchingInfo"라는 이름으로 저장
    CollectionReference matchingCollection = FirebaseFirestore.instance.collection('matchingInfo');

    // 매칭 정보 및 위치 정보를 Map으로 만들어서 Firestore에 저장하고 DocumentReference 반환
    return await matchingCollection.add({
      'selectedCategory': selectedCategory,
      'selectedFood': selectedFood,
      'timestamp': FieldValue.serverTimestamp(),
      'isMatching': true,
      'userLocation': userLocation != null ? GeoPoint(userLocation.latitude, userLocation.longitude) : null,
    });
  }

  void cancelMatching() async {
    // 매칭 정보가 저장되었는지 확인
    if (matchingDocument != null) {
      // Firestore에서 해당 문서 삭제
      await matchingDocument!.delete();
    }

    // 팝업 닫기, 타이머 중지, 매칭 상태 초기화
    Navigator.of(context).pop();
    timer.cancel();
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