import 'package:http/http.dart' as http;

import '../utils/constants.dart';

Future<bool> generateOtp(String phoneNumber, [String? email]) async {
  String url = "$host/auth/otp/generate?phonenumber=$phoneNumber";

  if (email != null) url += "&email=$email";

  http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == 202) {
    return true;
  } else {
    return false;
  }
}

Future<bool> resendOtp(String phoneNumber) async {
  http.Response response = await http.get(
    Uri.parse("$host/auth/otp/resend?phonenumber=$phoneNumber&retrytype=text"),
  );

  if (response.statusCode == 202) {
    return true;
  } else {
    return false;
  }
}

Future<bool> verifyOtp(String? phoneNumber, String otp, [String? email]) async {
  http.Response response;

  if (phoneNumber != null) {
    response = await http.get(
      Uri.parse("$host/auth/otp/verify?phonenumber=$phoneNumber&otp=$otp"),
    );
  } else {
    response = await http.get(
      Uri.parse("$host/auth/otp/verify?email=$email&otp=$otp"),
    );
  }

  if (response.statusCode == 202) {
    return true;
  } else {
    return false;
  }
}
