import 'package:baitaplon/constants/myColors.dart';
import 'package:baitaplon/models/Users.dart';
import 'package:baitaplon/page/SignupPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username;
  String _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 4,
              left: 30,
              right: 30,
            ),
            children: [
              headerSection(),
              usernameLabel(),
              usernameSection(),
              passwordLabel(),
              passwordSection(),
              buttonSection(),
              goToCreateNewAccount(),
            ],
          ),
        ));
  }

  Center headerSection() {
    return Center(
      child: Text(
        "Quiz App",
        style: TextStyle(
          color: Colors.white,
          fontSize: 50,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Padding usernameLabel() {
    return Padding(
      padding: EdgeInsets.only(top: 60.0, bottom: 10.0),
      child: Text(
        "Username",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Material usernameSection() {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      child: TextFormField(
        controller: usernameController,
        // ignore: missing_return
        validator: (String value) {
          if (value.isEmpty) return "Username is required";
        },
        onChanged: (val) {},
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
        ),
        onSaved: (String value) {
          setState(() {
            _username = value;
          });
        },
      ),
    );
  }

  Padding passwordLabel() {
    return Padding(
      padding: EdgeInsets.only(top: 60.0, bottom: 10.0),
      child: Text(
        "Password",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Material passwordSection() {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      child: TextFormField(
        controller: passwordController,
        // ignore: missing_return
        validator: (String value) {
          if (value.isEmpty) return "Password is required";
        },
        onChanged: (val) {},
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
        ),
        onSaved: (String value) {
          setState(() {
            _password = value;
          });
        },
        obscureText: true,
      ),
    );
  }

  Padding buttonSection() {
    return Padding(
      padding: EdgeInsets.only(top: 40.0, bottom: 20.0),
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: Colors.red),
            ),
          ),
          backgroundColor:
              MaterialStateProperty.all<Color>(Color.fromRGBO(0, 0, 0, 0.25)),
          padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(vertical: 15.0)),
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            // debugPrint(_name + _username);
            signin(http.Client(), _username, _password, context);
          }
        },
        child: Text(
          "Log In",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Center goToCreateNewAccount() {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => SignupPage()));
        },
        child: Text(
          "Create a new account",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
