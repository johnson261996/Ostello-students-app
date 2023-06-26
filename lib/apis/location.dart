import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/constants.dart';

Future<List> reverseGeocoding(String lat, String long) async {
  http.Response reverseGeocodingResponse = await http.patch(
    Uri.parse("$host/utils/geolocation"),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "latitude": lat,
      "longitude": long,
    }),
  );

  return jsonDecode(reverseGeocodingResponse.body);
}
