import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../utils/constants.dart';

Future getSignedUploadURL(String extension) async {
  http.Response response = await http.get(
    Uri.parse("$host/utils/url?extension=$extension&parts=1"),
  );

  return jsonDecode(response.body);
}

Future<String?> uploadFile(String url, String filepath) async {
  final data = await File(filepath).readAsBytes();

  http.Response response = await http.put(
    Uri.parse(url),
    body: data,
  );

  if (response.statusCode == 200) {
    return response.headers["etag"];
  } else {
    return null;
  }
}

Future<bool> completeFileUpload(String uploadId, String key, List parts) async {
  http.Response response = await http.post(
    Uri.parse("$host/utils/complete"),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "key": key,
      "uploadId": uploadId,
      "parts": parts,
    }),
  );

  if (response.statusCode == 202) {
    return true;
  } else {
    return false;
  }
}
