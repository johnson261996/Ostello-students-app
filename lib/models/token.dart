import 'dart:convert';

class Tokens {
  String accessToken;
  String refreshToken;

  Tokens({
    required this.accessToken,
    required this.refreshToken,
  });

  static fromJson(Map<String, dynamic> json) {
    return Tokens(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  toJson() {
    Map<String, String> data = {};

    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;

    return json.encode(data);
  }
}
