import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/mentor.dart';
import '../models/student.dart';
import '../models/token.dart';
import '../utils/constants.dart';

Future<bool> userExistsAPI(String? phoneNumber, [String? email]) async {
  http.Response response;

  if (phoneNumber != null) {
    response = await http.get(
      Uri.parse("$host/users?phonenumber=$phoneNumber"),
    );
  } else {
    response = await http.get(
      Uri.parse("$host/users?email=$email"),
    );
  }

  final jsonUser = jsonDecode(response.body)["message"];

  if (response.statusCode == 202 && jsonUser["usertype"] == 3) {
    return true;
  } else {
    return false;
  }
}

Future verifyAndRefreshTokensAPI(
  String accessToken,
  String refreshToken,
) async {
  http.Response response = await http.post(
    Uri.parse("$host/auth/verify"),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "accessToken": accessToken,
      "refreshToken": refreshToken,
    }),
  );

  if (response.statusCode == 202) {
    return Tokens(
      accessToken: jsonDecode(response.body)["message"]["access_token"],
      refreshToken: jsonDecode(response.body)["message"]["refresh_token"],
    );
  } else {
    return false;
  }
}

Future<Tokens> loginAPI(String phoneNumber, String otp) async {
  http.Response response;

  response = await http.post(
    Uri.parse("$host/users/login/phone"),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "phonenumber": phoneNumber,
      "otp": otp,
    }),
  );

  final tokens = Tokens.fromJson(jsonDecode(response.body)["message"]);

  if (response.statusCode == 202) {
    return tokens;
  } else {
    throw const HttpException("Error Logging In!");
  }
}

Future<Map<String, dynamic>> signUpAPI(String signUpData) async {
  http.Response response = await http.post(
    Uri.parse("$host/users/register"),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: signUpData,
  );

  if (response.statusCode == 202) {
    return jsonDecode(response.body)["message"];
  } else {
    throw const HttpException("Error Signing Up!");
  }
}

Future getStudentAPI(String? phoneNumber, [String? email]) async {
  http.Response response;

  if (phoneNumber != null) {
    response = await http.get(
      Uri.parse("$host/users?phonenumber=$phoneNumber"),
    );
  } else {
    response = await http.get(
      Uri.parse("$host/users?email=$email"),
    );
  }

  final userData = jsonDecode(response.body)["message"];

  if (response.statusCode == 202 && userData["id"] != null) {
    if (userData["usertype"] == 3) {
      return Student.fromJson(userData);
    } else {
      return Mentor.fromJson(userData);
    }
  } else {
    throw const HttpException("User not Found!");
  }
}

Future<String> updateUserAPI(String id, String token, String updates) async {
  http.Response response = await http.patch(
    Uri.parse("$host/users"),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    },
    body: jsonEncode({
      "id": id,
      "updates": updates,
    }),
  );

  if (response.statusCode == 202) {
    return jsonDecode(response.body)["message"];
  } else {
    throw const HttpException("User not updated!");
  }
}
