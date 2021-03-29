import 'package:baitaplon/constants/myColors.dart';
import 'package:baitaplon/models/Users.dart';
import 'package:baitaplon/page/auth/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/svg.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final fullnameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  Widget logo;

  @override
  void dispose() {
    fullnameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    logo = SvgPicture.asset("assets/logo.svg", width: 200);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: ListView(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 7,
            left: 20,
            right: 20,
          ),
          children: [
            logo,
            SizedBox(height: 20.0),
            signupForm(),
            SizedBox(height: 20.0),
            orDivider(),
            SizedBox(height: 20.0),
            loginButton(),
          ],
        ),
      ),
    );
  }

  Widget signupForm() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          fullnameInput(),
          SizedBox(height: 20.0),
          usernameInput(),
          SizedBox(height: 20.0),
          passwordInput(),
          SizedBox(height: 40.0),
          signupButton(),
        ],
      ),
    );
  }

  Widget fullnameInput() {
    return TextFormField(
      controller: fullnameController,
      decoration: InputDecoration(labelText: "Fullname"),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty ? 'Fullname cannot be blank' : null;
      },
    );
  }

  Widget usernameInput() {
    return TextFormField(
      controller: usernameController,
      decoration: InputDecoration(labelText: "Username"),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty ? 'Username cannot be blank' : null;
      },
    );
  }

  Widget passwordInput() {
    return TextFormField(
      controller: passwordController,
      decoration: InputDecoration(labelText: "Password"),
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: (value) {
        return value.isEmpty ? 'Password cannot be blank' : null;
      },
    );
  }

  Widget signupButton() {
    // ignore: deprecated_member_use
    return FlatButton(
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          signup(http.Client(), fullnameController.text,
              usernameController.text, passwordController.text, context);
        }
      },
      color: primaryColor,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
        "Sign up",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget loginButton() {
    // ignore: deprecated_member_use
    return FlatButton(
      onPressed: () {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
      },
      textColor: Colors.grey,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.grey)),
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
        "Log in",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget orDivider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width * 2 / 5,
          color: Colors.grey,
        ),
        Text("or", style: TextStyle(color: Colors.grey)),
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width * 2 / 5,
          color: Colors.grey,
        ),
      ],
    );
  }
}
