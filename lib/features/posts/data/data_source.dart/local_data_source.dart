import 'dart:convert';

import 'package:clean_architecture_app/features/posts/data/model/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCashedPost();
  Future<Unit> cashPost(List<PostModel> postmodels);
}

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const cashedPosts = 'CACHED_POSTS';

  PostLocalDataSourceImpl({required this.sharedPreferences});
  // The cashPost method takes a list of PostModel objects, converts each one to JSON,
  // and saves the list of JSON objects as a string in SharedPreferences under the key 'CACHED_POSTS'.
  // It returns a Future that completes with unit when the operation is done.
  @override
  Future<Unit> cashPost(List<PostModel> postmodels) async {
    // Convert each PostModel to JSON and create a list of JSON objects
    List postmodelToJson = postmodels
        .map<Map<String, dynamic>>((postmodel) => postmodel.toJson())
        .toList();
    // Save the list of JSON objects as a string in SharedPreferences
    await sharedPreferences.setString(
        cashedPosts, json.encode(postmodelToJson));
    print(
        '//////////////////////////// $postmodelToJson ////////////////////////////////');
    return Future.value(unit);
  }

// The getCashedPost method retrieves the JSON string from SharedPreferences, decodes it,
// and converts it back to a list of PostModel objects. If the JSON string is null, it
// throws an EmptyCacheException.
  @override
  Future<List<PostModel>> getCashedPost() {
    // Retrieve the JSON string from SharedPreferences
    final jsonString = sharedPreferences.getString(cashedPosts);
    // Check if the JSON string is not null, then decode it and convert it back to a list of PostModel objects
    if (jsonString != null) {
      List postmodelFromJson = json.decode(jsonString);
      List<PostModel> postmodels = postmodelFromJson
          .map<PostModel>((postmodel) => PostModel.fromJson(postmodel))
          .toList();
      // Return the list of PostModel objects wrapped in a Future
      return Future.value(postmodels);
    } else {
      throw EmptyCacheException();
    }
  }
}
