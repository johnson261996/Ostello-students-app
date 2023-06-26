import 'dart:convert';

import 'package:uuid/uuid.dart';

class Chat {
  static const uuid = Uuid();

  String id;
  String sender;
  String message;
  bool isLeft;
  String timeStamp;

  Chat({
    required this.id,
    required this.sender,
    required this.message,
    required this.isLeft,
    required this.timeStamp,
  });

  static fromJson(Map<String, dynamic> json) {
    return Chat(
      id: uuid.v4(),
      sender: json["role"],
      message: json["content"],
      timeStamp: json["timestamp"],
      isLeft: json["role"] != "user",
    );
  }

  String toJson() {
    Map<String, dynamic> data = {
      "id": id,
      "sender": sender,
      "message": message,
      "isLeft": isLeft,
      "timeStamp": timeStamp,
    };

    return json.encode(data);
  }
}
