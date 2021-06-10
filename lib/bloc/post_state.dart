import 'package:flutter/foundation.dart';
import 'package:reddit_clone/models/post_model.dart';

abstract class PostState {
  const PostState();
}

class PostInitial extends PostState {
  const PostInitial();
}

class PostLoading extends PostState {
  const PostLoading();
}

class PostCompleted extends PostState {
  final List<Post> response;

  const PostCompleted(this.response);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PostCompleted && listEquals(o.response, response);
  }

  @override
  int get hashCode => response.hashCode;
}

class PostError extends PostState {
  final String message;

  const PostError(this.message);
}
