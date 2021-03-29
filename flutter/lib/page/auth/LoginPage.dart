import 'package:baitaplon/constants/myColors.dart';
import 'package:baitaplon/models/Users.dart';
import 'package:baitaplon/page/auth/SignupPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool remember;
  Widget logo;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    remember = false;
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
            top: MediaQuery.of(context).size.height / 6,
            left: 20,
            right: 20,
          ),
          children: [
            logo,
            SizedBox(height: 20.0),
            loginForm(),
            SizedBox(height: 20.0),
            orDivider(),
            SizedBox(height: 20.0),
            signupButton(),
          ],
        ),
      ),
    );
  }

  Widget loginForm() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          usernameInput(),
          SizedBox(height: 20.0),
          passwordInput(),
          SizedBox(height: 20.0),
          rememberCheckbox(),
          SizedBox(height: 20.0),
          loginButton(),
        ],
      ),
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

  Widget rememberCheckbox() {
    return CheckboxListTile(
      value: remember,
      onChanged: (val) {
        setState(() {
          remember = val;
        });
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      title: Text(
        "Remember Me",
        style: TextStyle(color: Colors.black54),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.all(0),
    );
  }

  Widget loginButton() {
    // ignore: deprecated_member_use
    return FlatButton(
      onPressed: () {
        final FormState form = formKey.currentState;
        if (form.validate()) {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            // debugPrint(_name + _username);
            signin(http.Client(), usernameController.text,
                passwordController.text, context);
          }
        }
      },
      child: Text(
        "Log in",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      color: primaryColor,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 20.0),
    );
  }

  Widget signupButton() {
    // ignore: deprecated_member_use
    return FlatButton(
      onPressed: () {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => SignupPage()));
      },
      child: Text(
        "Sign up",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      textColor: Colors.grey,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.grey)),
      padding: EdgeInsets.symmetric(vertical: 20.0),
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
