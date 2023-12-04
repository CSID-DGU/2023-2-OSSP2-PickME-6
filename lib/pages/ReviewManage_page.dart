import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewManagementPage extends StatefulWidget {
  @override
  _ReviewManagementPageState createState() => _ReviewManagementPageState();
}

class _ReviewManagementPageState extends State<ReviewManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('리뷰 관리'),
      ),
      body: _buildReviewList(),
    );
  }

  Widget _buildReviewList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('review').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        var reviews = snapshot.data?.docs;

        return ListView.builder(
          itemCount: reviews?.length ?? 0,
          itemBuilder: (context, index) {
            var review = reviews![index].data() as Map<String, dynamic>;
            return ListTile(
              title: Text('음식점: ${review['restaurantName']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('메뉴: ${review['menuName']}'),
                  //Text('날짜: ${review['date'].toDate()}'),
                  Text('리뷰 내용: ${review['reviewContent']}'),
                ],
              ),
            );
          },
        );
      },
    );
  }
}