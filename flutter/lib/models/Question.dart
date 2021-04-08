import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/Strings.dart';
import 'Users.dart';

class Question {
  int id;
  int questionnaireId;
  String question;
  String correctAnswer;
  String incorrectAnswer1;
  String incorrectAnswer2;
  String incorrectAnswer3;
  String updatedAt;
  String createdAt;

  Question(
      {this.id,
      this.questionnaireId,
      this.question,
      this.correctAnswer,
      this.incorrectAnswer1,
      this.incorrectAnswer2,
      this.incorrectAnswer3,
      this.updatedAt,
      this.createdAt});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        id: json["id"],
        questionnaireId: json["questionnaireId"],
        question: json["question"],
        correctAnswer: json["correctAnswer"],
        incorrectAnswer1: json["incorrectAnswer1"],
        incorrectAnswer2: json["incorrectAnswer2"],
        incorrectAnswer3: json["incorrectAnswer3"],
        updatedAt: json["updatedAt"],
        createdAt: json["createdAt"]);
  }
}

Future<Question> updateQuestion(
    http.Client client,
    int userId,
    int questionnaireId,
    int questionId,
    String question,
    String correctAnswer,
    String incorrectAnswer1,
    String incorrectAnswer2,
    String incorrectAnswer3) async {
  Map<String, dynamic> data = {
    'question': question,
    'correctAnswer': correctAnswer,
    'incorrectAnswer1': incorrectAnswer1,
    'incorrectAnswer2': incorrectAnswer2,
    'incorrectAnswer3': incorrectAnswer3
  };
  var response = await client.post(
      "${Strings.BASE_URL}:${Strings.PORT}/users/$userId/questionnaire/$questionnaireId/question/$questionId/update",
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

Future deleteQuestion(
    http.Client client, int userId, int questionnaireId, int questionId) async {
  var response = await client.post(
      "${Strings.BASE_URL}:${Strings.PORT}/users/$userId/questionnaire/$questionnaireId/question/$questionId/delete",
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
  if (response.statusCode == 200) {
  } else {
    throw Exception('Fail');
  }
}
