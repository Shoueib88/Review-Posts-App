import 'package:equatable/equatable.dart';

// This is the base class for all failures, which will be used to handle errors in the application
abstract class Failure extends Equatable {}

// This is the failure for the server error, which will be used to handle errors from the server
class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

// This is the failure for the empty cache error, which will be used to handle errors from the cache
class EmptyCacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

// This is the failure for the offline error, which will be used to handle errors from the offline
class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}
