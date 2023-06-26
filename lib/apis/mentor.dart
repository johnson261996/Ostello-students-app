import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/mentor.dart';
import '../models/mentor_review.dart';
import '../models/token.dart';
import '../utils/constants.dart';

Future<bool> mentorExistsAPI(String phonenumber) async {
  http.Response response = await http.get(
    Uri.parse("$host/mentor?phonenumber=$phonenumber"),
  );

  if (response.statusCode == 202) {
    return true;
  } else {
    return false;
  }
}

Future<String> getMentorIDAPI(String phonenumber) async {
  http.Response response = await http.get(
    Uri.parse("$host/mentor?phonenumber=$phonenumber"),
  );

  if (response.statusCode == 202) {
    return (jsonDecode(response.body)["mentor"]["id"]);
  } else {
    throw const HttpException("Mentor not found!");
  }
}

Future<Mentor> getMentorAPI(String phonenumber) async {
  http.Response response = await http.get(
    Uri.parse("$host/mentor?phonenumber=$phonenumber"),
  );

  if (response.statusCode == 202) {
    return Mentor.fromJson(jsonDecode(response.body)["mentor"]);
  } else {
    throw const HttpException("Mentor not found!");
  }
}

Future<List<Mentor>> getAllMentorsAPI(String token, int limit,
    [int skip = 0]) async {
  http.Response response = await http.get(
    Uri.parse("$host/mentor/filtered?limit=$limit&skip=$skip"),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 202 || response.statusCode == 200) {
    final mentors = jsonDecode(response.body)["mentors"];

    List<Mentor> parsedMentors = [];

    for (int i = 0; i < mentors.length; i++) {
      if (mentors[i]["specialization"] != null) {
        parsedMentors.add(Mentor.fromJson(mentors[i]));
      }
    }

    return parsedMentors;
  } else {
    throw const HttpException("Failed loading Mentors!");
  }
}

Future<Tokens> registerMentorAPI(String data) async {
  http.Response response = await http.post(
    Uri.parse("$host/mentor"),
    headers: {
      'Content-Type': 'application/json',
    },
    body: data,
  );

  if (response.statusCode == 202) {
    return Tokens.fromJson(jsonDecode(response.body)["tokens"]);
  } else {
    throw Exception("Error Registering Mentor!");
  }
}

Future updateMentorAPI(String token, String id, dynamic updates) async {
  http.Response response = await http.patch(
    Uri.parse("$host/mentor"),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      "id": id,
      "updates": updates,
    }),
  );

  if (response.statusCode == 202) {
    return true;
  } else {
    return false;
  }
}

Future<bool> followMentorAPI(String token, String id) async {
  http.Response response = await http.post(
    Uri.parse("$host/mentor/follow"),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({"id": id}),
  );

  if (response.statusCode == 202) return true;
  return false;
}

Future getMentorReviewsAPI(String id, int limit, [int skip = 0]) async {
  http.Response response = await http.get(
    Uri.parse("$host/mentor/reviews?id=$id&limit=$limit&skip=$skip"),
  );

  final reviews = jsonDecode(response.body)["reviews"];
  List<MentorReview> parsedReviews = [];

  for (int i = 0; i < reviews.length; i++) {
    parsedReviews.add(MentorReview.fromJson(reviews[i]));
  }

  if (response.statusCode == 202 || response.statusCode == 200) {
    return parsedReviews;
  } else {
    throw const HttpException("Failed loading Reviews!");
  }
}

Future postMentorReviewAPI(String token, dynamic body) async {
  http.Response response = await http.post(
    Uri.parse("$host/mentor/review"),
    body: jsonEncode(body),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 202) {
    return true;
  } else {
    return false;
  }
}
