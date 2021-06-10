import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit_clone/repositories/post_repository.dart';

import 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository _postRepository;

  PostCubit(this._postRepository) : super(PostInitial());

  Future<void> getPost() async {
    try {
      emit(PostLoading());
      await Future.delayed(Duration(milliseconds: 1000));
      final response = await _postRepository.getPost();
      emit(PostCompleted(response));
    } on NetworkError catch (e) {
      emit(PostError(e.message));
    }
  }
}
