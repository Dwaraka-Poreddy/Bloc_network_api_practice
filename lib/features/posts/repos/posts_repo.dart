import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/posts_data_ui_model.dart';

class PostsRepo {
  static Future<List<PostDataUiModel>> fetchPosts() async {
    var client = http.Client();
    List<PostDataUiModel> posts = [];
    try {
      var response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      List result = jsonDecode(response.body);
      for (var i = 0; i < result.length; i++) {
        PostDataUiModel post = PostDataUiModel.fromMap(result[i]);
        posts.add(post);
      }
      return posts;
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to fetch posts');
    }
  }

  static Future<bool> addPost() async {
    var client = http.Client();
    try {
      var response = await client
          .post(Uri.parse('https://jsonplaceholder.typicode.com/posts'), body: {
        "title": "Dwaraks is doing great",
        "body":
            "he is going to rock the EvaluAItor, flutter development and job shifting",
        "userId": "1"
      });
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to fetch posts');
    }
  }
}
