import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_network_api_practice/features/posts/models/posts_data_ui_model.dart';
import 'package:bloc_network_api_practice/features/posts/repos/posts_repo.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
    on<PostsAddEvent>(postsAddEvent);
  }

  FutureOr<void> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostsLoadingState());
    try {
      List<PostDataUiModel> posts = await PostsRepo.fetchPosts();
      emit(PostsFetchSuccessState(posts: posts));
    } catch (e) {
      log(e.toString());
      emit(PostsFetchErrorState());
    }
  }

  FutureOr<void> postsAddEvent(
      PostsAddEvent event, Emitter<PostsState> emit) async {
    bool success = await PostsRepo.addPost();
    if (success) {
      emit(PostsAddSuccessState());
    } else {
      emit(PostsAddFailureState());
    }
  }
}
