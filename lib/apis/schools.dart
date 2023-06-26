import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/school.dart';
import '../utils/constants.dart';

Future<List<School>> getAllSchoolsAPI(
  int limit, [
  String? keyword = '',
  int skip = 0,
]) async {
  http.Response response = await http.get(
    Uri.parse("$host/utils/schools?name=$keyword&limit=$limit&skip=$skip"),
  );

  if (response.statusCode == 202 || response.statusCode == 200) {
    final schools = jsonDecode(response.body)["schools"];

    List<School> parsedSchools = [];

    for (int i = 0; i < schools.length; i++) {
      parsedSchools.add(School.fromJson(schools[i]));
    }

    return parsedSchools;
  } else {
    throw const HttpException("Failed loading Schools!");
  }
}

Future<bool> listSchoolAPI(String token, dynamic body) async {
  http.Response response = await http.post(
    Uri.parse("$host/utils/school"),
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
