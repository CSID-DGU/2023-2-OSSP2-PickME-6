import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewPage extends StatefulWidget {
  final String restaurantName;
  final String menuName;
  final String orderDate;

  ReviewPage({
    required this.restaurantName,
    required this.menuName,
    required this.orderDate,
  });

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('리뷰 쓰기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('카테고리: ${widget.restaurantName}'),
            Text('메뉴: ${widget.menuName}'),
            Text('주문일시: ${widget.orderDate}'),
            SizedBox(height: 20),
            Text('리뷰 내용:'),
            TextField(
              controller: _reviewController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '리뷰를 작성해주세요.',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveReviewToFirestore();
              },
              child: Text('리뷰 작성 완료'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveReviewToFirestore() async {
    String reviewContent = _reviewController.text.trim();

    if (reviewContent.isNotEmpty) {
      try {
        // Firestore에 리뷰 저장
        await FirebaseFirestore.instance
            .collection('review')
            .add({
          'restaurantName': widget.restaurantName,
          'menuName': widget.menuName,
          'orderDate': widget.orderDate,
          'reviewContent': reviewContent,
        });

        // 리뷰 작성 완료 후 이전 페이지로 이동
        Navigator.pop(context);
      } catch (e) {
        print('리뷰를 Firestore에 저장하는 중 오류 발생: $e');
      }
    } else {
      // 리뷰 내용이 비어있을 경우 경고 표시
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('리뷰 내용이 비어있습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('확인'),
              ),
            ],
          );
        },
      );
    }
  }
}