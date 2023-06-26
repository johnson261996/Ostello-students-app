import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/post.dart';
import '../utils/constants.dart';

Future<List<Post>> getPostsAPI(String token, int limit, [int skip = 0]) async {
  http.Response response = await http.get(
    Uri.parse("$host/posts/filtered?limit=$limit&skip=$skip"),
    headers: {'Authorization': 'Bearer $token'},
  );

  List<Post> posts = [];
  List data = jsonDecode(response.body)["message"];

  for (int i = 0; i < data.length; i++) {
    posts.add(Post.fromJson(data[i]));
  }

  if (response.statusCode == 202) {
    return posts;
  } else {
    throw const HttpException("Failed to retrieve Posts!");
  }
}

Future<bool> addPostAPI(String token, String title, String description) async {
  http.Response response = await http.post(
    Uri.parse("$host/posts"),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    },
    body: jsonEncode({
      "title": title,
      "description": description,
    }),
  );

  if (response.statusCode == 202) {
    return true;
  } else {
    return false;
  }
}

Future<bool> boostPostAPI(String token, String id) async {
  http.Response response = await http.patch(
    Uri.parse("$host/posts/boost"),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    },
    body: jsonEncode({
      "id": id,
    }),
  );

  if (response.statusCode == 202) {
    return true;
  } else {
    return false;
  }
}
