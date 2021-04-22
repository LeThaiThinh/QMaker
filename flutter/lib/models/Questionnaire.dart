import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/Strings.dart';
import 'History.dart';
import 'Question.dart';
import 'Users.dart';

class Questionnaire {
  int id;
  int userId;
  User user;
  String name;
  String topic;
  bool public;
  String description;
  int timeLimit;
  String updatedAt;
  String createdAt;
  History history;
  double avgRating;
  List<Question> listQuestion;

  Questionnaire(
      {this.id,
      this.userId,
      this.name,
      this.user,
      this.topic,
      this.public,
      this.description,
      this.timeLimit,
      this.history,
      this.avgRating,
      this.listQuestion,
      this.updatedAt,
      this.createdAt});

  factory Questionnaire.fromJson(Map<String, dynamic> json, double avgRating) {
    return Questionnaire(
        id: json["id"],
        name: json['name'],
        user: json["users"] != null ? User.fromJson(json["users"][0]) : null,
        topic: json["topic"],
        public: json["public"],
        description: json["description"],
        timeLimit: json["timeLimit"],
        history: json["users"] != null
            ? History.fromJson(json["users"][0]["histories"])
            : null,
        avgRating: avgRating,
        listQuestion: json["questions"] != null ? setListQuestion(json) : null,
        updatedAt: json["updatedAt"],
        createdAt: json["createdAt"]);
  }
  factory Questionnaire.fromJson2(Map<String, dynamic> json, double avgRating) {
    return Questionnaire(
        id: json["id"],
        userId: json['userId'],
        name: json['name'],
        user: json["users"] != null ? User.fromJson(json["users"][0]) : null,
        topic: json["topic"],
        public: json["public"],
        description: json["description"],
        timeLimit: json["timeLimit"],
        history: json["users"] != null
            ? History.fromJson(json["users"][0]["histories"])
            : null,
        avgRating: avgRating,
        listQuestion: json["questions"] != null ? setListQuestion(json) : null,
        updatedAt: json["updatedAt"],
        createdAt: json["createdAt"]);
  }
}

List<Question> setListQuestion(Map<String, dynamic> json) {
  List<Question> list = new List<Question>();
  for (var question in json["questions"]) {
    list.add(Question.fromJson(question));
  }
  return list;
}

// ignore: missing_return
Future<Questionnaire> fetchQuestionnaireById(
    http.Client client, int userId, int questionnaireId) async {
  final response = await client.get(Uri.http(
      "${Strings.BASE_URL}:${Strings.PORT}",
      "/questionnaire/$questionnaireId",
      {"userId": "$userId"}));
  if (response.statusCode == 200) {
    var questionnaire = jsonDecode(response.body);
    double avgRating = await getAvgRating(client, userId, questionnaire['id']);
    return Questionnaire.fromJson2(questionnaire, avgRating);
  } else {
    throw Exception('Fail');
  }
}

Future<List<Map>> fetchQuestionnaireTopic(
    http.Client client, int userId) async {
  final response = await client.get(Uri.http(
    "${Strings.BASE_URL}:${Strings.PORT}",
    "/users/$userId/questionnaireTopic",
  ));
  if (response.statusCode == 200) {
    final list = jsonDecode(response.body);
    List<Map> listTopic = [];
    for (var map in list) listTopic.add(map);
    return listTopic;
  } else {
    throw Exception('Fail');
  }
}

Future<List<Questionnaire>> fetchQuestionnaire(
    http.Client client, int userId, Map<String, dynamic> query) async {
  final response = await client
      .get(Uri.http("${Strings.BASE_URL}:${Strings.PORT}", "/questionnaire", {
    "userId": "$userId",
    "name": query['name'],
    "topic": query['topic'],
    "recentlyUsed": query['recentlyUsed'],
  }));
  if (response.statusCode == 200) {
    final map = jsonDecode(response.body).cast<Map<String, dynamic>>();
    List<Questionnaire> listQuestionnaire = [];
    for (var questionnaire in map) {
      double avgRating =
          await getAvgRating(client, userId, questionnaire['id']);
      listQuestionnaire.add(Questionnaire.fromJson2(questionnaire, avgRating));
    }

    return listQuestionnaire;
  } else {
    throw Exception('Fail');
  }
}

Future updateHistory(http.Client client, BuildContext context, int score,
    int totalTime, int rating, int questionnaireId, int userId) async {
  Map<String, dynamic> data = {
    'score': score,
    'totalTime': totalTime,
    'rating': rating,
  };
  var response = await client.post(
      Uri.http(
          "${Strings.BASE_URL}:${Strings.PORT}",
          "/questionnaire/$questionnaireId/updateHistory",
          {"userId": "$userId"}),
      body: json.encode(data),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
  if (response.statusCode == 200) {
  } else {}
}

// ignore: missing_return
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
      Uri.http("${Strings.BASE_URL}:${Strings.PORT}", "/questionnaire/create",
          {"userId": "$userId"}),
      body: json.encode(data),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
  if (response.statusCode == 200) {
    var questionnaire = jsonDecode(response.body);
    double avgRating = await getAvgRating(client, userId, questionnaire['id']);
    return Questionnaire.fromJson2(questionnaire, avgRating);
  } else {
    throw Exception('Fail');
  }
}

Future deleteQuestionnaire(http.Client client, BuildContext context,
    int questionnaireId, int userId) async {
  var response = await client.post(
      Uri.http("${Strings.BASE_URL}:${Strings.PORT}",
          "/questionnaire/$questionnaireId/delete", {"userId": "$userId"}),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
  if (response.statusCode == 200) {
  } else {}
}
