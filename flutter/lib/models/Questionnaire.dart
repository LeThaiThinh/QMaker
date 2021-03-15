import 'package:baitaplon/constants/Strings.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Questionnaire {
  int id;
  int userId;
  String toppic;
  String public;
  String description;
  int timeLimit;

  Questionnaire(
      {this.id,
      this.userId,
      this.toppic,
      this.public,
      this.description,
      this.timeLimit});

  factory Questionnaire.fromJson(Map<String, dynamic> json) {
    return Questionnaire(
        id: json["id"],
        userId: json["user_id"],
        toppic: json["name"],
        public: json["username"],
        description: json["password"],
        timeLimit: json["time_limit"]);
  }
}

Future<List<Questionnaire>> fetchQuestionnaireByTopic(
    http.Client client, int id) async {
  final response = await client.get("http://10.0.2.2:4000/users/questionnaire");
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

Future<List<Questionnaire>> fetchQuestionnaireTopic(
    http.Client client, int id) async {
  final response = await client.get("http://10.0.2.2:4000/users/questionnaire");
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

Future<Questionnaire> fetchQuestionnaire(http.Client client, int id) async {
  final response =
      await client.get("http://10.0.2.2:4000/users/$id/questionnaire");
  if (response.statusCode == 200) {
    var user = jsonDecode(response.body);
    return Questionnaire.fromJson(user);
  } else {
    throw Exception('Fail');
  }
}
