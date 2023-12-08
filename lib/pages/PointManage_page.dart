import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PointManagementPage extends StatefulWidget {
  const PointManagementPage({Key? key}) : super(key: key);

  @override
  _PointManagementPageState createState() => _PointManagementPageState();
}

class _PointManagementPageState extends State<PointManagementPage> {
  num _totalPoints = 0;

  @override
  void initState() {
    super.initState();
    // 총 포인트를 가져오는 함수 호출
    _fetchTotalPoints();
  }

  Future<void> _fetchTotalPoints() async {
    try {
      // Firestore에서 포인트 변동 내역을 가져오기
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('point').get();

      // 포인트 합산
      num totalPoints = 0;
      snapshot.docs.forEach((doc) {
        totalPoints += doc['pt'];
      });

      // 상태 업데이트
      setState(() {
        _totalPoints = totalPoints;
      });
    } catch (e) {
      // 오류 처리
      print('포인트 정보를 가져오는 동안 오류 발생: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('포인트 관리'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 총 포인트 표시
          SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                '총 포인트: $_totalPoints p',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          // 포인트 사용 및 차감 내역 표시
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              // Firestore에서 포인트 변동 내역 가져오기
              future: FirebaseFirestore.instance.collection('point').get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                final data = snapshot.data!.docs;

                return ListView(
                  children: [
                    for (var document in data)
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ' ${document['reason']}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              ' ${document['pt'] > 0 ? '+' : ''}${document['pt']}p',
                              style: TextStyle(
                                color: document['pt'] < 0 ? Colors.red : Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          ' ${DateTime.fromMillisecondsSinceEpoch(document['timestamp'].millisecondsSinceEpoch).toString().split('.')[0]}',
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}