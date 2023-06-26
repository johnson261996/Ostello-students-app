import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/institute.dart';
import '../utils/constants.dart';

Future<List<Institute>> getQueriedInstitutes(String query) async {
  http.Response response;

  if (query.startsWith("https") == true) {
    response = await http.get(
      Uri.parse("$host/institute?slug=${query.split("/").last}"),
    );
  } else {
    response = await http.get(
      Uri.parse("$host/institute/search?name=$query"),
    );
  }

  final institutes = jsonDecode(response.body)["message"];
  List<Institute> parsedInstitutes = [];

  if (institutes.runtimeType == List) {
    for (int i = 0; i < institutes.length; i++) {
      parsedInstitutes.add(Institute.fromJson(institutes[i]));
    }
  } else {
    parsedInstitutes
        .add(Institute.fromJson(jsonDecode(response.body)["message"]));
  }

  if (response.statusCode == 202 || response.statusCode == 200) {
    return parsedInstitutes;
  } else {
    throw const HttpException("Failed finding Institute!");
  }
}
