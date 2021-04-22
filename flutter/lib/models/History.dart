import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../constants/Strings.dart';

class History {
  int userId;
  int questionnaireId;
  double rating;
  int score;
  int totalTime;
  int recentlyUsed;
  String updatedAt;
  String createdAt;

  History(
      {this.userId,
      this.questionnaireId,
      this.rating,
      this.score,
      this.recentlyUsed,
      this.totalTime,
      this.updatedAt,
      this.createdAt});

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
        userId: json["userId"],
        questionnaireId: json['questionnaireId'],
        rating: json["avgRating"],
        score: json["score"],
        recentlyUsed: json["recentlyUsed"],
        totalTime: json["totalTime"],
        updatedAt: json["updatedAt"],
        createdAt: json["createdAt"]);
  }
}

Future<History> fetchHistoryById(
    http.Client client, int userId, int questionnaireId) async {
  final response = await client.get(Uri.http(
      "${Strings.BASE_URL}:${Strings.PORT}",
      "/questionnaire/$questionnaireId/history",
      {"userId": "$userId"}));
  if (response.statusCode == 200) {
    var history = jsonDecode(response.body);
    return History.fromJson(history);
  } else {
    throw Exception('Fail');
  }
}

Future<History> createHistory(
    http.Client client, int userId, int questionnaireId) async {
  Map<String, dynamic> data = {
    'userId': "$userId",
    'score': 0,
    'totalTime': 0,
    'rating': 0,
    'recentlyUsed': 0,
    'questionnaireId': "$questionnaireId"
  };
  var response = await client.post(
      Uri.http("${Strings.BASE_URL}:${Strings.PORT}",
          "/questionnaire/$questionnaireId/createHistory", {"userId": "$userId"}),
      body: json.encode(data),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
  if (response.statusCode == 200) {
    var history = jsonDecode(response.body);
    return History.fromJson(history);
  } else {
    throw Exception('Fail');
  }
}

Future<double> getAvgRating(
    http.Client client, int userId, int questionnaireId) async {
  final response = await client.get(Uri.http(
      "${Strings.BASE_URL}:${Strings.PORT}",
      "/questionnaire/$questionnaireId/rating",
      {"userId": "$userId"}));
  if (response.statusCode == 200) {
    var rating = jsonDecode(response.body);
    return double.parse(rating['avgRating']);
  } else {
    throw Exception('Fail');
  }
}
