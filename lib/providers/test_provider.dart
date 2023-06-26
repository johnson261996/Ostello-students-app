import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

import '../models/test.dart';

class TestProvider extends ChangeNotifier {
  final List<Option> _answers = List<Option>.filled(8, Option(questionId: '-1', option: '-1', weightage: 0));

  List<Option> get answers => _answers;

  void SendResult(List<Option> result,BuildContext context)async{
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Post request initiated")));
    final uri = Uri.parse('http://your api url ');
    final headers = {'Content-Type': 'application/json'};
    var body = _answers;
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );



    int statusCode = response.statusCode;
    String responseBody = response.body;
  }

  void updateAnswer(int index, Option answer) {
    answers[index] = answer;
    // final existingAnswerIndex = _answers
    //     .indexWhere((answer) => answer.questionId == _option.questionId);
    // if (existingAnswerIndex != -1) {
    //   _answers[existingAnswerIndex] = _option;
    // } else {
    //   _answers.add(_option);
    // }
    notifyListeners();
  }

  void skipQuestion(String questionId) {
    final skippedOption = Option(
      questionId: questionId,
      option: -1,
      weightage: 0,
    );
    // updateAnswer(skippedOption);
  }
}
