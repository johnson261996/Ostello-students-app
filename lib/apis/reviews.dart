import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/review.dart';
import '../utils/constants.dart';

Future<List<Review>> getInstituteReviews(String instituteid, int limit,
    [int skip = 0]) async {
  http.Response response = await http.get(
    Uri.parse("$host/review?instituteId=$instituteid&limit=$limit&skip=$skip"),
  );

  List reviews = jsonDecode(response.body)["message"];
  List<Review> parsedReviews = [];

  for (int i = 0; i < reviews.length; i++) {
    parsedReviews.add(Review.fromJson(reviews[i]));
  }

  if (response.statusCode == 202) {
    return parsedReviews;
  } else {
    throw const HttpException("Failed finding Institute!");
  }
}

Future<bool> addReview(String token, dynamic body) async {
  http.Response response = await http.post(
    Uri.parse("$host/review"),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    },
    body: jsonEncode(body),
  );

  if (response.statusCode == 202) {
    return true;
  } else {
    return false;
  }
}
