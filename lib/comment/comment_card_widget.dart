import 'package:flutter/material.dart';
import 'comment_model.dart';
import 'user_model.dart';

class CommentCardWidget extends StatefulWidget {
  final CommentModel commentModel;

  const CommentCardWidget({
    super.key,
    required this.commentModel,
  });

  @override
  State<CommentCardWidget> createState() => _CommentCardWidgetState();
}

class _CommentCardWidgetState extends State<CommentCardWidget> {
  @override
  Widget build(BuildContext context) {
    CommentModel commentModel = widget.commentModel;
    UserModel writer = commentModel.writer;

    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        left: 13,
        right: 13,
      ),
      child: Row(
        children: [
          //AvatarWidget(userModel: writer),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: writer.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                WidgetSpan(child: SizedBox(width: 10)),
                TextSpan(text: commentModel.comment),
              ])),
              SizedBox(height: 4),
              Text(
                commentModel.createdAt.toDate().toString().split(' ')[0],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}