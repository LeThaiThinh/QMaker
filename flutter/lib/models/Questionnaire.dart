import 'dart:async';
import 'dart:io';

import 'package:baitaplon/constants/Strings.dart';
import 'package:baitaplon/models/History.dart';
import 'package:baitaplon/models/Question.dart';
import 'package:baitaplon/page/bottom/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Users.dart';

class Questionnaire {
  int id;
  User user;
  String name;
  String topic;
  bool public;
  String description;
  int timeLimit;
  String updatedAt;
  String createdAt;
  History history;
  List<Question> listQuestion;

  Questionnaire(
      {this.id,
      this.name,
      this.user,
      this.topic,
      this.public,
      this.description,
      this.timeLimit,
      this.history,
      this.listQuestion,
      this.updatedAt,
      this.createdAt});

  factory Questionnaire.fromJson(Map<String, dynamic> json) {
    return Questionnaire(
        id: json["id"],
        name: json['name'],
        user: json["users"][0] != null ? User.fromJson(json["users"][0]) : null,
        topic: json["topic"],
        public: json["public"],
        description: json["description"],
        timeLimit: json["time_limit"],
        history: json["users"][0]["histories"] != null
            ? History.fromJson(json["users"][0]["histories"])
            : null,
        listQuestion: json["questions"] != null ? setListQuestion(json) : null,
        updatedAt: json["updatedAt"],
        createdAt: json["createdAt"]);
  }
}

List<Question> setListQuestion(Map<String, dynamic> json) {
  List<Question> list;
  for (var question in json["questions"]) list.add(Question.fromJson(question));
  return list;
}

Future<Questionnaire> fetchQuestionnaireById(
    http.Client client, int userId, int questionnaireId) async {
  final response = await client.get(
      "${Strings.BASE_URL}:${Strings.PORT}/users/$userId/questionnaire/$questionnaireId");
  if (response.statusCode == 200) {
    var questionnaire = jsonDecode(response.body);
    return Questionnaire.fromJson(questionnaire);
  } else {
    throw Exception('Fail');
  }
}

Future<List<Map>> fetchQuestionnaireTopic(
    http.Client client, int userId) async {
  final response = await client
      .get("${Strings.BASE_URL}:${Strings.PORT}/users/$userId/questionnaireTopic");
  if (response.statusCode == 200) {
    final list = jsonDecode(response.body);
    List<Map> listTopic = new List<Map>();
    for (var map in list) listTopic.add(map);
    return listTopic;
  } else {
    throw Exception('Fail');
  }
}

Future<List<Questionnaire>> fetchQuestionnaire(
    http.Client client, int userId, String query) async {
  final response = await client.get(
      "${Strings.BASE_URL}:${Strings.PORT}/users/$userId/questionnaire/$query");
  if (response.statusCode == 200) {
    final map = jsonDecode(response.body).cast<Map<String, dynamic>>();
    final listUsers = map.map<Questionnaire>((json) {
      return Questionnaire.fromJson(json);
    }).toList();
    return listUsers;
  } else {
    throw Exception('Fail');
  }
}

//
Future<int> fetchNumberOfQuestion(
    http.Client client, int questionnaireId, int userId) async {
  final response = await client.get(
      "${Strings.BASE_URL}:${Strings.PORT}/users/$userId/questionnaire/$questionnaireId/count");
  if (response.statusCode == 200) {
    final number = jsonDecode(response.body);
    return number;
  } else {
    throw Exception('Fail');
  }
}

Future setRecentlyUsed(http.Client client, BuildContext context,
    int questionnaireId, int userId) async {
  Map<dynamic, String> data = {'recentlyUsed': Timestamp.now().toString()};
  var response = await client.post(
      '${Strings.BASE_URL}:${Strings.PORT}/users/$userId/questionnaire/$questionnaireId/setRecentlyUsed',
      body: json.encode(data),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
  var jsonResponse = json.decode(response.body);
  if (response.statusCode == 200) {
    print(jsonResponse);
  } else {}
}

Future<Questionnaire> createQuestionnaire(
    http.Client client,
    int userId,
    String name,
    String topic,
    String description,
    bool public,
    int timeLimit) async {
  Map<String, dynamic> data = {
    'name': name,
    'topic': topic,
    'description': description,
    'public': public,
    'timeLimit': timeLimit
  };
  var response = await client.post(
      "${Strings.BASE_URL}:${Strings.PORT}/users/$userId/questionnaire/create",
      body: json.encode(data),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
  if (response.statusCode == 200) {
    var questionnaire = jsonDecode(response.body);
    return Questionnaire.fromJson(questionnaire);
  } else {
    throw Exception('Fail');
  }
}
