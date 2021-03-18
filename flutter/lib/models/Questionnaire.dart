import 'package:baitaplon/constants/Strings.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Questionnaire {
  int id;
  int userId;
  String name;
  String topic;
  bool public;
  String description;
  int timeLimit;
  String updatedAt;
  String createAt;

  Questionnaire(
      {this.id,
      this.name,
      this.userId,
      this.topic,
      this.public,
      this.description,
      this.timeLimit,
      this.updatedAt,
      this.createAt});

  factory Questionnaire.fromJson(Map<String, dynamic> json) {
    return Questionnaire(
        id: json["id"],
        name: json['name'],
        userId: json["userId"],
        topic: json["topic"],
        public: json["public"],
        description: json["description"],
        timeLimit: json["time_limit"],
        updatedAt: json["updatedAt"],
        createAt: json["createdAt"]);
  }
}

Future<List<Questionnaire>> fetchQuestionnaireByTopic(
    http.Client client, int userId) async {
  final response = await client
      .get("http://10.0.2.2:${Strings.PORT}/users/$userId/questionnaire");
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

Future<List<Map>> fetchQuestionnaireTopic(
    http.Client client, int userId) async {
  final response = await client
      .get("http://10.0.2.2:${Strings.PORT}/users/$userId/questionnaireTopic");
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
      "http://10.0.2.2:${Strings.PORT}/users/$userId/questionnaire/$query");
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

Future<int> numberOfQuestion(
    http.Client client, int questionnaireId, int userId) async {
  final response = await client.get(
      "http://10.0.2.2:${Strings.PORT}/users/$userId/questionnaire/$questionnaireId/count");
  if (response.statusCode == 200) {
    final number = jsonDecode(response.body);
    return number;
  } else {
    throw Exception('Fail');
  }
}
