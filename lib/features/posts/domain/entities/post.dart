import 'package:equatable/equatable.dart';

// This is the entity of the post, which will be used by the use cases and the data layer
class Post extends Equatable {
  final int? id;
  final String title;
  final String body;

  const Post({
    this.id,
    required this.title,
    required this.body,
  });

  @override
  List<Object?> get props => [id, title, body];
}
