import 'package:bloc/bloc.dart';
import 'package:clean_architecture_app/core/strings/messages.dart';
import 'package:clean_architecture_app/features/posts/domain/uses_case/delete_post.dart';
import 'package:clean_architecture_app/features/posts/domain/uses_case/update_post.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/strings/failures.dart';
import '../../../../domain/entities/post.dart';
import '../../../../domain/uses_case/add_post.dart';

part 'add_update_delete_post_event.dart';
part 'add_update_delete_post_state.dart';

class AddUpdateDeletePostBloc
    extends Bloc<AddUpdateDeletePostEvent, AddUpdateDeletePostState> {
  final AddPostUseCase addPost;
  final UpDatePostUseCase updatePost;
  final DeletePostUseCase deletePost;
  AddUpdateDeletePostBloc(
      {required this.addPost,
      required this.updatePost,
      required this.deletePost})
      : super(AddUpdateDeletePostInitial()) {
    on<AddUpdateDeletePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(AddUpdateDeletePostLoading());
        final failureOrDone = await addPost(event.post);
        // ignore: use_build_context_synchronously
        emit(mapFailureToState(failureOrDone, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdatePostEvent) {
        emit(AddUpdateDeletePostLoading());
        final failureOrDone = await updatePost(event.post);
        // ignore: use_build_context_synchronously
        emit(mapFailureToState(failureOrDone, UPDATE_SUCCESS_MESSAGE));
      } else if (event is DeletePostEvent) {
        emit(AddUpdateDeletePostLoading());
        final failureOrDone = await deletePost(event.postId);
        // ignore: use_build_context_synchronously
        emit(mapFailureToState(failureOrDone, DELETE_SUCCESS_MESSAGE));
      }
    });
  }
  // ignore: missing_return
  AddUpdateDeletePostState mapFailureToState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) =>
          AddUpdateDeletePostError(message: mapFailureToMessage(failure)),
      (_) => AddUpdateDeletePostSuccess(message: message),
    );
  }

// ignore: missing_return
  String mapFailureToMessage(failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVERFAILUREMESSAGE;

      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error , Please try again later .';
    }
  }
}
