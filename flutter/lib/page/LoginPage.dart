import 'dart:convert';
import 'dart:io';

import 'package:baitaplon/constants/Strings.dart';
import 'package:baitaplon/models/Users.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'HomePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String _username;
  String _password;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.redAccent, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Form(
            key: _key,
            child: ListView(
              children: <Widget>[
                headerSection(),
                textSection(),
                buttonSection(),
              ],
            ),
          )),
    );
  }

  signIn() async {
    Map<dynamic, String> data = {'username': _username, 'password': _password};
    var jsonResponse;
    var response = await http.post('http://10.0.2.2:${Strings.PORT}/signin',
        body: json.encode(data),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => HomePage(
              user: User(
                  id: jsonResponse['id'],
                  username: jsonResponse['username'],
                  name: jsonResponse['username'],
                  password: jsonResponse['password']))));
    } else {}
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: () {
          if (!_key.currentState.validate()) {
            return;
          }

          _key.currentState.save();
          signIn();
        },
        elevation: 0.0,
        color: Colors.red[300],
        child: Text("Sign In", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: usernameController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Colors.white70),
              hintText: "Username",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
            // ignore: missing_return
            validator: (String value) {
              // ignore: missing_return
              if (value.isEmpty) return "username is required";
            },
            onSaved: (String value) {
              setState(() {
                _username = value;
              });
            },
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            obscureText: true,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.white70),
              hintText: "Password",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
            // ignore: missing_return
            validator: (String value) {
              // ignore: missing_return
              if (value.isEmpty) return "password is required";
            },
            onSaved: (String value) {
              setState(() {
                _password = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Container headerSection() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text("Sign in",
          style: TextStyle(
              color: Colors.white70,
              fontSize: 40.0,
              fontWeight: FontWeight.bold)),
    );
  }
}
