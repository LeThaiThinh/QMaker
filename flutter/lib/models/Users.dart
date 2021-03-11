import 'package:baitaplon/api/apiManager.dart';
import 'package:baitaplon/constants/Strings.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class User {
  int id;
  String name;
  String username;
  String password;

  User({this.id, this.name, this.username, this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        password: json["password"]);
  }
}

Future<List<User>> fetchUsers(http.Client client) async {
  final response = await client.get(Strings.URL_USERS);
  if (response.statusCode == 200) {
    return compute(parseUsers, response.body);
  }
}

List<User> parseUsers(String responseBody) {
  final users = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  final listUsers = users.map<User>((json) {
    return User.fromJson(json);
  }).toList();
  return listUsers;
}

Future<User> fetchUserById() async {
  final response = await ApiManager().get(Strings.URL_USERS_BY_ID);
  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    // if (mapResponse["result"] == "ok") {
    // final users = [].cast<Map<String, dynamic>>();
    // final user = users.map<User>((json) {
    //   return User.fromJson(mapResponse);
    // });
    return User.fromJson(mapResponse);
    // } else
    //   return [];
  } else {
    throw Exception('Fail');
  }
}
