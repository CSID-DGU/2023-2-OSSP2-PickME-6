import 'comment_model.dart';

enum CommentStatus {
  init,
  fetching,
  submitting,
  success,
  error,
}

class CommentState {
  final CommentStatus commentStatus;
  final List<CommentModel> commentList;

  const CommentState({
    required this.commentStatus,
    required this.commentList,
  });

  factory CommentState.init() {
    return CommentState(
      commentStatus: CommentStatus.init,
      commentList: [],
    );
  }

  CommentState copyWith({
    CommentStatus? commentStatus,
    List<CommentModel>? commentList,
  }) {
    return CommentState(
      commentStatus: commentStatus ?? this.commentStatus,
      commentList: commentList ?? this.commentList,
    );
  }

  @override
  String toString() {
    return 'CommentState{commentStatus: $commentStatus, commentList: $commentList}';
  }
}