import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../constants/Strings.dart';
import '../constants/sharedData.dart';
import '../routes/RouteName.dart';

class User {
  int id;
  String name;
  String username;
  String password;
  String updatedAt;
  String createdAt;
  User(
      {this.id,
      this.name,
      this.username,
      this.password,
      this.updatedAt,
      this.createdAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        password: json["password"],
        updatedAt: json["updatedAt"],
        createdAt: json["createdAt"]);
  }
}

Future<List<User>> fetchUsers(http.Client client) async {
  final response =
      await client.get("${Strings.BASE_URL}:${Strings.PORT}/users");
  if (response.statusCode == 200) {
    final map = jsonDecode(response.body).cast<Map<String, dynamic>>();
    final listUsers = map.map<User>((json) {
      return User.fromJson(json);
    }).toList();
    return listUsers;
  } else {
    throw Exception('Fail');
  }
}

Future<User> fetchUsersById(http.Client client, int id) async {
  final response =
      await client.get("${Strings.BASE_URL}:${Strings.PORT}/users/$id");
  if (response.statusCode == 200) {
    var user = jsonDecode(response.body);
    return User.fromJson(user);
  } else {
    throw Exception('Fail');
  }
}

Future signin(http.Client client, String _username, String _password,
    BuildContext context) async {
  Map<dynamic, String> data = {'username': _username, 'password': _password};
  var jsonResponse;
  var response = await client.post('${Strings.BASE_URL}:${Strings.PORT}/signin',
      body: json.encode(data),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
  jsonResponse = json.decode(response.body);
  if (response.statusCode == 200) {
    Provider.of<SharedData>(context, listen: false).changeUser(User(
        id: jsonResponse['id'],
        username: jsonResponse['username'],
        name: jsonResponse['name'],
        password: jsonResponse['password'],
        createdAt: jsonResponse['createdAt'],
        updatedAt: jsonResponse['updatedAt']));
    Navigator.of(context).popAndPushNamed(mainRoute);
  } else {}
}

Future signup(http.Client client, String _name, String _username,
    String _password, BuildContext context) async {
  Map<dynamic, String> data = {
    'name': _name,
    'username': _username,
    'password': _password,
  };
  try {
    var jsonResponse;
    var response = await http.post(
      '${Strings.BASE_URL}:${Strings.PORT}/signup',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      Provider.of<SharedData>(context, listen: false).changeUser(User(
          id: jsonResponse['id'],
          username: jsonResponse['username'],
          name: jsonResponse['name'],
          password: jsonResponse['password'],
          createdAt: jsonResponse['createdAt'],
          updatedAt: jsonResponse['updatedAt']));
      Navigator.of(context).popAndPushNamed(mainRoute);
    } else {}
  } catch (err) {
    print(err);
    return;
  }
}

Future changePass(http.Client client, String newPassword,int userId,BuildContext context) async {
  Map<dynamic, String> data = {
    'password': newPassword,
  };
  try {
    var jsonResponse;
    var response = await http.post(
      '${Strings.BASE_URL}:${Strings.PORT}/users/$userId/changePass',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: json.encode(data),
    );
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      Provider.of<SharedData>(context, listen: false).changeUser(User(
          id: jsonResponse['id'],
          username: jsonResponse['username'],
          name: jsonResponse['name'],
          password: jsonResponse['password'],
          createdAt: jsonResponse['createdAt'],
          updatedAt: jsonResponse['updatedAt']));
      Navigator.of(context).pop();
    } else {}
  } catch (err) {
    print(err);
    return;
  }
}
