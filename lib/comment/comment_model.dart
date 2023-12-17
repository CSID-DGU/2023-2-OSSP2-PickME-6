import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ossp_pickme/comment/user_model.dart';

class CommentModel {
  final String commentId;
  final String comment;
  final UserModel writer;
  final Timestamp createdAt;

  const CommentModel({
    required this.commentId,
    required this.comment,
    required this.writer,
    required this.createdAt,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      commentId: map['commentId'],
      comment: map['comment'],
      writer: map['writer'],
      createdAt: map['createdAt'],
    );
  }

  @override
  String toString() {
    return 'CommentModel{commentId: $commentId, comment: $comment, writer: $writer, createdAt: $createdAt}';
  }
}