import 'package:ossp_pickme/comment/comment_repository.dart';
import 'package:ossp_pickme/comment/user_model.dart';
import 'package:ossp_pickme/comment/custom_exception.dart';
import 'package:ossp_pickme/comment/comment_provider.dart';
import 'package:ossp_pickme/comment/comment_state.dart';
import 'package:ossp_pickme/comment/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:ossp_pickme/comment/comment_card_widget.dart';


class comment_screen extends StatefulWidget {
  final String name;

 const comment_screen({
  super.key,
  required this.name,
 });
  
  @override
  State<comment_screen> createState() => _comment_screen();

}

class _comment_screen extends State<comment_screen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _textEditingController = TextEditingController();
  late final CommentProvider commentProvider;

  @override
  void initState() {
    super.initState();
    commentProvider = context.read<CommentProvider>();
    _getCommentList();

  }

  void _getCommentList() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await commentProvider.getCommentList(name: widget.name);
      } on CustomException catch (e) {
        showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        // 에러 코드
        title: Text(e.code),
        // 에러 내용
        content: Text(e.message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('확인'),
          ),
        ],
      );
    },
  );
      }
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     UserModel currentUserModel = context.read<UserState>().userModel;
    CommentState commentState = context.watch<CommentState>();
    bool isEnabled = commentState.commentStatus != CommentStatus.submitting;

    if (commentState.commentStatus == CommentStatus.fetching) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      
      body: SafeArea(
        child: ListView.builder(
          itemCount: commentState.commentList.length,
          itemBuilder: (context, index) {
            return CommentCardWidget(
                commentModel: commentState.commentList[index]);
          },
        ),
      ),
      bottomNavigationBar: Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: Colors.white70,
        child: Form(
          key: _formKey,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: TextFormField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: '댓글을 입력해주세요',
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return '댓글을 입력해주세요';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              IconButton(
                onPressed: isEnabled ? () async {
                  FocusScope.of(context).unfocus();

                  FormState? form = _formKey.currentState;

                  if (form == null || !form.validate()) {
                    return;
                  }

                  try {
                    // 댓글 등록 로직
                    await context.read<CommentProvider>().uploadComment(
                          name: widget.name,
                          uid: currentUserModel.uid,
                          comment: _textEditingController.text,
                        );
                  } on CustomException catch (e) {
                   showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        // 에러 코드
        title: Text(e.code),
        // 에러 내용
        content: Text(e.message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('확인'),
          ),
        ],
      );
    },
  );
                  }

                  _textEditingController.clear();
                } : null,
                icon: Icon(Icons.comment),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


