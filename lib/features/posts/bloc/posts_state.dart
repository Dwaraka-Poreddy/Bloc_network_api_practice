part of 'posts_bloc.dart';

@immutable
abstract class PostsState {}

abstract class PostsActionState extends PostsState {}

final class PostsInitial extends PostsState {}

final class PostsLoadingState extends PostsState {}

final class PostsFetchErrorState extends PostsState {}

class PostsFetchSuccessState extends PostsState {
  final List<PostDataUiModel> posts;
  PostsFetchSuccessState({required this.posts});
}

class PostsAddSuccessState extends PostsActionState {}

class PostsAddFailureState extends PostsActionState {}
