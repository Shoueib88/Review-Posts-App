import 'package:bloc/bloc.dart';
import 'package:clean_architecture_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_app/features/posts/domain/uses_case/get_all_post.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/strings/failures.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  // ignore: prefer_typing_uninitialized_variables
  final GetAllPostUseCase getAllPost;
  PostsBloc({required this.getAllPost}) : super(PostsInitial()) {
    // ignore: no_leading_underscores_for_local_identifiers
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(PostsStateLoading());

        final failureOrPosts = await getAllPost();
        print(
            '--------------------------$getAllPost  ------------------------------ $failureOrPosts');
        // ignore: use_build_context_synchronously
        emit(mapFailureToState(failureOrPosts));
      } else if (event is RefreshPostsEvent) {
        emit(PostsStateLoading());
        final failureOrPosts = await getAllPost();
        emit(mapFailureToState(failureOrPosts));
      }
    });
  }
  // ignore: missing_return
  PostsState mapFailureToState(Either<Failure, List<Post>> either) {
    return either.fold(
      (failure) {
        print("----------------------- -    ---------- Failure Type: $failure");
        return PostsStateError(message: mapFailureToMessage(failure));
      },
      (posts) => PostsStateLoaded(posts: posts),
    );
  }

// ignore: missing_return
  String mapFailureToMessage(failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVERFAILUREMESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error , Please try again later .';
    }
  }
}
