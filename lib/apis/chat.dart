import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/chat.dart';
import '../utils/constants.dart';

Future getConversation(String roomid) async {
  http.Response response = await http.get(
    Uri.parse("$host/chat?roomid=$roomid"),
  );

  final responseBody = jsonDecode(response.body);

  List<Chat> chats = [];
  if (responseBody["statusCode"] != 202) {
    return chats;
  }

  final convos = responseBody["message"]["history"];

  for (final chat in convos) {
    if (chat["role"] != "system") {
      chats.add(Chat.fromJson(chat));
    }
  }

  return chats;
}

Future askGpt(dynamic body) async {
  http.Response response = await http.post(
    Uri.parse("$host/chat"),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(body),
  );

  if (response.statusCode != 202) return askGpt(body);
  return jsonDecode(response.body);
}
