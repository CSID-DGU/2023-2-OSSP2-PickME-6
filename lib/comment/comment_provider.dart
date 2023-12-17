import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'custom_exception.dart';
import 'comment_state.dart';
import 'comment_model.dart';
import 'comment_repository.dart';


class CommentProvider extends StateNotifier<CommentState> with LocatorMixin {
  CommentProvider() : super(CommentState.init());

  Future<void> getCommentList({
    required String name,
  }) async {
    state = state.copyWith(commentStatus: CommentStatus.fetching);

    try {
      List<CommentModel> commentList =
          await read<CommentRepository>().getCommentList(name: name);

      state = state.copyWith(
        commentStatus: CommentStatus.success,
        commentList: commentList,
      );
    } on CustomException catch (_) {
      state = state.copyWith(commentStatus: CommentStatus.error);
      rethrow;
    }
  }

  Future<void> uploadComment({
    required String name,
    required String uid,
    required String comment,
  }) async {
    state = state.copyWith(commentStatus: CommentStatus.submitting);

    try {
      CommentModel commentModel = await read<CommentRepository>().uploadComment(
        name: name,
        nickName: uid,
        comment: comment,
      );

      state = state.copyWith(
        commentStatus: CommentStatus.success,
        commentList: [commentModel, ...state.commentList],
      );
    } on CustomException catch (_) {
      state = state.copyWith(commentStatus: CommentStatus.error);
      rethrow;
    }
  }
}