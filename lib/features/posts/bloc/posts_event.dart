part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}

class PostsInitialFetchEvent extends PostsEvent {}

class PostsFetchSuccessEvent extends PostsEvent {}

class PostsAddEvent extends PostsEvent {}
