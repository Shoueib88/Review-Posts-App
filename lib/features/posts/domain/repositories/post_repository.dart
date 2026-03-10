import 'package:clean_architecture_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/post.dart';

// This is the contract of the repository, which will be implemented by the data layer
// The repository will be used by the use cases to get the data from the data layer

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getAllPost();
  Future<Either<Failure, Unit>> deletePost(int id);
  Future<Either<Failure, Unit>> updatePost(Post post);
  Future<Either<Failure, Unit>> addPost(Post post);
}
