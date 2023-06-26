import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/wallet.dart';
import '../utils/constants.dart';

Future getWallet(String token, [String? code]) async {
  if (code != null) {
    http.Response response = await http.get(
      Uri.parse("$host/wallet?referralCode=$code"),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 202) {
      return Wallet.fromJson(jsonDecode(response.body)["message"]);
    } else {
      return null;
    }
  }

  http.Response response = await http.get(
    Uri.parse("$host/wallet"),
    headers: {'Authorization': 'Bearer $token'},
  );

  Wallet wallet = Wallet.fromJson(jsonDecode(response.body)["message"]);

  if (response.statusCode == 202) {
    return wallet;
  } else {
    throw const HttpException("Failed to retrieve Wallet!");
  }
}

Future<Wallet> redeemReferral(String token) async {
  http.Response response = await http.get(
    Uri.parse("$host/wallet"),
    headers: {'Authorization': 'Bearer $token'},
  );

  Wallet wallet = Wallet.fromJson(jsonDecode(response.body)["message"]);

  if (response.statusCode == 202) {
    return wallet;
  } else {
    throw const HttpException("Failed to retrieve Wallet!");
  }
}
