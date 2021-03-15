import 'package:baitaplon/constants/Strings.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  final response = await client.get("http://10.0.2.2:4000/users");
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
  final response = await client.get("http://10.0.2.2:4000/users/$id");
  if (response.statusCode == 200) {
    var user = jsonDecode(response.body);
    return User.fromJson(user);
  } else {
    throw Exception('Fail');
  }
}
