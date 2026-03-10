import 'dart:convert';

import 'package:clean_architecture_app/core/error/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../model/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPost();
  Future<Unit> deletePost(int id);
  Future<Unit> updatePost(PostModel post);
  Future<Unit> addPost(PostModel post);
}

const String baseUrl = 'https://jsonplaceholder.typicode.com';

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPost() async {
    // Make a GET request to the API endpoint to retrieve all posts
    final response = await http.get(Uri.parse('$baseUrl/posts/'),
        headers: {'Content-Type': 'application/json'});
    // Check if the response status code is 200 (OK), then decode the JSON and convert it to a list of PostModel objects
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      print(
          '//////////////////////////// Done ////////////////////////////////');
      final List decodedJson = json.decode(response.body) as List;
      // Map each JSON object to a PostModel and return the list of PostModel objects wrapped in a Future
      final List<PostModel> postModels = decodedJson
          .map<PostModel>((json) => PostModel.fromJson(json))
          .toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel post) async {
    // Create a body for the POST request using the title and body of the PostModel
    final body = {
      'title': post.title,
      'body': post.body,
    };
    // Make a POST request to the API endpoint to add a new post with the specified body
    final response = await client.post(Uri.parse('$baseUrl/posts/'),
        headers: {'Content-Type': 'application/json'}, body: body);
    // Check if the response status code is 201 (Created), then return unit wrapped in a Future, otherwise throw an exception
    if (response.statusCode == 201) {
      print(
          '//////////////////////////// Add ////////////////////////////////');
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int id) async {
    // Make a DELETE request to the API endpoint to delete a post with the specified id
    final response = await client.delete(
        Uri.parse('$baseUrl/posts/${id.toString()}'),
        headers: {'Content-Type': 'application/json'});
// Check if the response status code is 200 (OK), then return unit wrapped in a Future, otherwise throw an exception
    if (response.statusCode == 200) {
      print(
          '//////////////////////////// Delete ////////////////////////////////');
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel post) async {
    // Create a body for the PATCH request using the title and body of the PostModel
    final postId = post.id.toString();
    final body = {
      'title': post.title,
      'body': post.body,
    };
    // Make a PATCH request to the API endpoint to update a post with the specified id and body
    final response = await client.patch(Uri.parse('$baseUrl/posts/$postId'),
        headers: {'Content-Type': 'application/json'}, body: body);
    // Check if the response status code is 200 (OK), then return unit wrapped in a Future, otherwise throw an exception
    if (response.statusCode == 200) {
      print(
          '//////////////////////////// Update ////////////////////////////////');
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
