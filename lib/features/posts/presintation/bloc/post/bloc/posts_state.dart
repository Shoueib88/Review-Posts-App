part of 'posts_bloc.dart';

sealed class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

final class PostsInitial extends PostsState {}

class PostsStateLoading extends PostsState {}

final class PostsStateLoaded extends PostsState {
  final List<Post> posts;

  const PostsStateLoaded({required this.posts});

  @override
  List<Object> get props => [posts];
}

final class PostsStateError extends PostsState {
  final String message;

  const PostsStateError({required this.message});

  @override
  List<Object> get props => [message];
}
