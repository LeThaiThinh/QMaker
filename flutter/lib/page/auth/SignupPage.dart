import 'package:baitaplon/localization/LocalizationConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import '../../constants/myColors.dart';
import '../../models/Users.dart';
import 'LoginPage.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key key}) : super(key: key);
  @override
  // TODO: implement key
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
      key: Key('nameSignup'),
      controller: fullnameController,
      decoration:
          InputDecoration(labelText: getTranslated(context, "Fullname")),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty
            ? getTranslated(context, 'Fullname cannot be blank')
            : null;
      },
    );
  }

  Widget usernameInput() {
    return TextFormField(
      key: Key('usernameSignup'),
      controller: usernameController,
      decoration:
          InputDecoration(labelText: getTranslated(context, "Username")),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty
            ? getTranslated(context, 'Username cannot be blank')
            : null;
      },
    );
  }

  Widget passwordInput() {
    return TextFormField(
      key: Key('passwordSignup'),
      controller: passwordController,
      decoration:
          InputDecoration(labelText: getTranslated(context, "Password")),
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: (value) {
        return value.isEmpty
            ? getTranslated(context, 'Password cannot be blank')
            : null;
      },
    );
  }

  Widget signupButton() {
    // ignore: deprecated_member_use
    return FlatButton(
      key: Key('signup'),
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
        getTranslated(context, "Sign up"),
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
        getTranslated(context, "Login"),
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
        Text(getTranslated(context, "Or"),
            style: TextStyle(color: Colors.grey)),
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width * 2 / 5,
          color: Colors.grey,
        ),
      ],
    );
  }
}
