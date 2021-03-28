import 'package:baitaplon/constants/myColors.dart';
import 'package:baitaplon/models/Users.dart';
import 'package:baitaplon/page/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  SignupPage({Key key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _password;
  String _username;
  String _name;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
        backgroundColor: primaryColor,
        body: Container(
            child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 5,
              left: 30,
              right: 30,
            ),
            children: <Widget>[
              headerSection(),
              labelNameSection(),
              nameSection(),
              labelUsernameSection(),
              usernameSection(),
              labelPasswordSection(),
              passwordSection(),
              signupSection(),
              goToLoginSection(),
            ],
          ),
        )));
  }

  Center headerSection() {
    return Center(
      child: Text(
        "Create a new account",
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Padding labelNameSection() {
    return Padding(
      padding: EdgeInsets.only(top: 40.0, bottom: 10.0),
      child: Text(
        "Your name",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Material nameSection() {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      child: TextFormField(
        controller: nameController,
        // ignore: missing_return
        validator: (String value) {
          if (value.isEmpty) return "Name is required";
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        ),
        onSaved: (String value) {
          setState(() {
            _name = value;
          });
        },
      ),
    );
  }

  Padding labelUsernameSection() {
    return Padding(
      padding: EdgeInsets.only(top: 30.0, bottom: 10.0),
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
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        ),
        onSaved: (String value) {
          setState(() {
            _username = value;
          });
        },
      ),
    );
  }

  Padding labelPasswordSection() {
    return Padding(
      padding: EdgeInsets.only(top: 30.0, bottom: 10.0),
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
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
          hintStyle: TextStyle(textBaseline: TextBaseline.ideographic),
          border: InputBorder.none,
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

  Padding signupSection() {
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
            debugPrint(_name + _username);
            signup(http.Client(), _name, _username, _password, context);
          }
        },
        child: Text(
          "Sign Up",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Center goToLoginSection() {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
        },
        child: Text(
          "Already a member? Login now",
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
