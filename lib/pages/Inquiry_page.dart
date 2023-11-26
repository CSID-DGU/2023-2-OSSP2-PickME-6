import 'package:flutter/material.dart';

class InquiryPage extends StatefulWidget {
  const InquiryPage({Key? key}) : super(key: key);

  @override
  _InquiryPageState createState() => _InquiryPageState();
}

class _InquiryPageState extends State<InquiryPage> {
  bool isReport = false; // 신고 여부 체크 상태

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // 뒤로가기
          },
        ),
        title: Text('문의하기'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Checkbox(
                  value: isReport,
                  onChanged: (value) {
                    setState(() {
                      isReport = value!;
                    });
                  },
                ),
                Text('신고'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              '문의 내용을 입력해주세요.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '문의 내용을 입력하세요.',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // 문의 내용 전송 미구현 / 뒤로가기 처리
                Navigator.pop(context);
              },
              child: Text('문의 내용 전송'),
            ),
          ],
        ),
      ),
    );
  }
}
