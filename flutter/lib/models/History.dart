import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/Strings.dart';
import 'Users.dart';

class History {
  int userId;
  int questionnaireId;
  int rating;
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
    debugPrint(json["score"].toString() + " " + json["totalTime"].toString());
    return History(
        userId: json["userId"],
        questionnaireId: json['questionnaireId'],
        rating: json["rating"],
        score: json["score"],
        recentlyUsed: json["recentlyUsed"],
        totalTime: json["totalTime"],
        updatedAt: json["updatedAt"],
        createdAt: json["createdAt"]);
  }
}

Future<History> fetchHistoryById(
    http.Client client, int userId, int questionnaireId) async {
  final response = await client.get(
      "${Strings.BASE_URL}:${Strings.PORT}/users/$userId/questionnaire/$questionnaireId/history");
  if (response.statusCode == 200) {
    var history = jsonDecode(response.body);
    return History.fromJson(history);
  } else {
    throw Exception('Fail');
  }
}
