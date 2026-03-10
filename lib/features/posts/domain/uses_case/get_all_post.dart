import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/post.dart';
import '../repositories/post_repository.dart';

// This is the use case, which will be used by the presentation layer to get the data from the repository
class GetAllPostUseCase {
  final PostRepository repository;
  GetAllPostUseCase(this.repository);
  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPost();
  }
}
