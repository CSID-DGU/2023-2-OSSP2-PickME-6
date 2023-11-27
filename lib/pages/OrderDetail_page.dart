import 'package:flutter/material.dart';

class OrderDetailPage extends StatelessWidget {
  final String restaurantName;
  final String menuName;
  final String orderTime;
  final bool isRepresentative; // 대표결제자 여부
  final int matchingMembers; // 매칭된 인원 수

  OrderDetailPage({
    required this.restaurantName,
    required this.menuName,
    required this.orderTime,
    required this.isRepresentative,
    required this.matchingMembers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('주문상세'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 첫 번째 블록: 주문 정보
            Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                margin: EdgeInsets.all(16.0),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$restaurantName',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '$menuName',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '주문 시간: $orderTime',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '대표결제자 여부: ${isRepresentative ? '예' : '아니오'}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '매칭된 인원: $matchingMembers 명',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // 문의하기 버튼 클릭 시 동작
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('문의하기'),
                                  content: Text('문의사항을 입력하세요.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('취소'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // 실제 문의하기 동작 추가
                                        Navigator.pop(context);
                                      },
                                      child: Text('확인'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Text('문의하기'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // 재주문 버튼 클릭 시 동작
                            },
                            child: Text('재주문'),
                          ),
                        ],
                      ),
                    ],
                  ),
              ),
            ),
            for (int i = 0; i < matchingMembers; i++)
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                margin: EdgeInsets.all(16.0),
                child: MatchingMemberDetailBlock(),
              ),
          ],
        ),
      ),
    );
  }
}

// 각 인원의 주문 상세 정보를 나타내는 위젯
class MatchingMemberDetailBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 각 인원의 주문 상세 정보를 나타내는 UI 작성 예정
        ],
      ),
    );
  }
}