part of 'add_update_delete_post_bloc.dart';

sealed class AddUpdateDeletePostState extends Equatable {
  const AddUpdateDeletePostState();

  @override
  List<Object> get props => [];
}

final class AddUpdateDeletePostInitial extends AddUpdateDeletePostState {}

class AddUpdateDeletePostLoading extends AddUpdateDeletePostState {}

class AddUpdateDeletePostError extends AddUpdateDeletePostState {
  final String message;

  const AddUpdateDeletePostError({required this.message});

  @override
  List<Object> get props => [message];
}

class AddUpdateDeletePostSuccess extends AddUpdateDeletePostState {
  final String message;

  const AddUpdateDeletePostSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
