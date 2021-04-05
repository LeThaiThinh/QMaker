import 'dart:async';
import 'dart:io';

import 'package:baitaplon/constants/Strings.dart';
import 'package:baitaplon/page/bottom/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Users.dart';

class Question {
  int id;
  int questionnaireId;
  String question;
  String correctanswer;
  String incorrectanswer1;
  String incorrectanswer2;
  String incorrectanswer3;
  String updatedAt;
  String createdAt;

  Question(
      {this.id,
      this.questionnaireId,
      this.question,
      this.correctanswer,
      this.incorrectanswer1,
      this.incorrectanswer2,
      this.incorrectanswer3,
      this.updatedAt,
      this.createdAt});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        id: json["id"],
        questionnaireId: int.parse(json["questionnaireId"]),
        question: json["question"],
        correctanswer: json["correctanswer"],
        incorrectanswer1: json["incorrectanswer1"],
        incorrectanswer2: json["incorrectanswer2"],
        incorrectanswer3: json["incorrectanswer3"],
        updatedAt: json["updatedAt"],
        createdAt: json["createdAt"]);
  }
}

Future<List<Question>> fetchQuestionnaire(
    http.Client client, int userId, int questionnaireId, String query) async {
  final response = await client.get(
      "${Strings.BASE_URL}:${Strings.PORT}/users/$userId/questionnaire/$questionnaireId/question/$query");
  if (response.statusCode == 200) {
    final map = jsonDecode(response.body).cast<Map<String, dynamic>>();
    final listUsers = map.map<Question>((json) {
      return Question.fromJson(json);
    }).toList();
    return listUsers;
  } else {
    throw Exception('Fail');
  }
}

Future<Question> createQuestion(
    http.Client client,
    int userId,
    int questionnaireId,
    String question,
    String correctAnswer,
    String incorrectAnswer1,
    String incorrectAnswer2,
    String incorrectAnswer3) async {
  Map<String, dynamic> data = {
    'questionnaireId': questionnaireId,
    'question': question,
    'correctAnswer': correctAnswer,
    'incorrectAnswer1': incorrectAnswer1,
    'incorrectAnswer2': incorrectAnswer2,
    'incorrectAnswer3': incorrectAnswer3
  };
  var response = await client.post(
      "${Strings.BASE_URL}:${Strings.PORT}/users/$userId/questionnaire/$questionnaireId/question/create",
      body: json.encode(data),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
  if (response.statusCode == 200) {
    var question = jsonDecode(response.body);
    return Question.fromJson(question);
  } else {
    throw Exception('Fail');
  }
}
