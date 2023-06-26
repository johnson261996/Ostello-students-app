import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uuid/uuid.dart';

import '../apis/chat.dart';
import '../models/chat.dart';

class ChatRoomProvider extends ChangeNotifier {
  late Socket socket;
  final uuid = const Uuid();

  Map<String, dynamic>? _quickReplies;

  int _newMessages = 0;
  String? currentResponse;
  String? _supportCategory;
  bool promptLoading = false;

  final List<Chat> _messages = [];

  Map<String, dynamic>? get quickReplies => _quickReplies;

  ChatRoomProvider() {
    socket = io('https://api.ostello.co.in', <String, dynamic>{
      'upgrade': false,
      'maxHttpBufferSize': 1e6,
      'transports': ["websocket"],
    });

    socket.connect();

    socket.on('connect', (_) {
      debugPrint('connect: ${socket.id}');
    });

    socket.on('ack_ask_gpt', receiveResponse);
    socket.on('follow_ups', handleQuickReplies);
    socket.on('disconnect', (_) => debugPrint('disconnect'));
  }

  int get newMessages => _newMessages;

  List<Chat> get messages => _messages;

  String? get supportCategory => _supportCategory;

  set setNewMessages(int msgs) {
    _newMessages = msgs;
    notifyListeners();
  }

  set setChatRoom(String roomid) {
    socket.emit("join_room", roomid);
  }

  set setChatQuickReply(String chatQuickReply) {
    if (_supportCategory != null) return;

    final chat = Chat(
      id: uuid.v4(),
      sender: "You",
      isLeft: false,
      message: chatQuickReply,
      timeStamp: DateTime.now().toUtc().toString().substring(0, 16),
    );

    _supportCategory = chatQuickReply;
    _messages.add(chat);
    notifyListeners();
  }

  Future<void> populateMessages(String roomid, String name) async {
    _messages.add(Chat(
      id: uuid.v4(),
      isLeft: true,
      sender: "Ostello",
      message:
          "Hey there Welcome to Ostello!\nI can help you with your Career Decisions. Type in your name to start the session.",
      timeStamp: "${DateTime.now().hour}:${DateTime.now().minute}",
    ));

    List<Chat> chats = await getConversation(roomid);

    if (chats.isNotEmpty) {
      _messages.addAll(chats);
    }

    notifyListeners();
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }

  // Future<void> sendMessage(String message, String sender, String roomid) async {
  //   promptLoading = true;
  //   Chat chat = Chat(
  //     id: uuid.v4(),
  //     sender: sender,
  //     isLeft: false,
  //     message: message,
  //     timeStamp: "${DateTime.now().hour}:${DateTime.now().minute}",
  //   );
  //
  //   _messages.add(chat);
  //   notifyListeners();
  //
  //   final body = {
  //     "prompt": message,
  //     "roomid": roomid,
  //   };
  //
  //   final response = await askGpt(body);
  //   promptLoading = false;
  //
  //   final respChat = Chat(
  //     id: uuid.v4(),
  //     isLeft: true,
  //     sender: "Ostello",
  //     message: response["message"],
  //     timeStamp: "${DateTime.now().hour}:${DateTime.now().minute}",
  //   );
  //
  //   _messages.add(respChat);
  //   _newMessages++;
  //   notifyListeners();
  // }

  void receiveResponse(dynamic data) {
    final decodedResponse = data;

    if (decodedResponse["status"] == "PROGRESS") {
      if (currentResponse != null) {
        currentResponse = currentResponse! + decodedResponse["message"];
      } else {
        currentResponse = decodedResponse["message"];
      }

      notifyListeners();
    } else if (decodedResponse["status"] == "DONE") {
      currentResponse = null;
      final chat = decodedResponse["message"];

      Chat newChat = Chat(
        id: uuid.v4(),
        sender: "assistant",
        isLeft: true,
        message: chat,
        timeStamp: "${DateTime.now().hour}:${DateTime.now().minute}",
      );

      _messages.add(newChat);
      notifyListeners();
    }
  }

  void handleQuickReplies(dynamic data) {
    _quickReplies = data["followups"];
    notifyListeners();
  }

  void askOstello(String message, String sender, String roomid) {
    Chat chat = Chat(
      id: uuid.v4(),
      sender: sender,
      isLeft: false,
      message: message,
      timeStamp: "${DateTime.now().hour}:${DateTime.now().minute}",
    );

    _quickReplies = null;
    _messages.add(chat);
    notifyListeners();

    socket.emit("ask_gpt", {
      "roomid": roomid,
      "prompt": message,
    });
  }
}
