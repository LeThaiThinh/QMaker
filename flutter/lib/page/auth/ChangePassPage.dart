import 'package:baitaplon/constants/myColors.dart';
import 'package:baitaplon/constants/sharedData.dart';
import 'package:baitaplon/models/Users.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ChangePassPage extends StatefulWidget {
  ChangePassPage({Key key}) : super(key: key);

  @override
  _ChangePassPageState createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final currentPassController = TextEditingController();
  final newPassController = TextEditingController();
  final retypeNewPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: [
            currentPassInput(),
            SizedBox(height: 20),
            newPassInput(),
            SizedBox(height: 20),
            retypeNewPassInput(),
            SizedBox(height: 40),
            updateButton(),
          ],
        ),
      ),
    );
  }

  Widget currentPassInput() {
    return TextFormField(
      controller: currentPassController,
      decoration: InputDecoration(labelText: "Current Password"),
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: (value) {
        return value.isEmpty
            ? 'Current Password cannot be blank'
            : value !=
                    Provider.of<SharedData>(context, listen: false)
                        .user
                        .password
                ? 'Wrong password'
                : null;
      },
    );
  }

  Widget newPassInput() {
    return TextFormField(
      controller: newPassController,
      decoration: InputDecoration(labelText: "New Password"),
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: (value) {
        return value.isEmpty ? 'New Password cannot be blank' : null;
      },
    );
  }

  Widget retypeNewPassInput() {
    return TextFormField(
      controller: retypeNewPassController,
      decoration: InputDecoration(labelText: "Retype New Password"),
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: (value) {
        return value.isEmpty
            ? 'Retype New Password cannot be blank'
            : value != newPassController.text
                ? 'RetypePassword doesnt match'
                : null;
      },
    );
  }

  Widget updateButton() {
    // ignore: deprecated_member_use
    return FlatButton(
      onPressed: () {
        final FormState form = formKey.currentState;
        if (form.validate()) {
          form.save();
          changePass(http.Client(), newPassController.text,
              Provider.of<SharedData>(context, listen: false).user.id, context);
          Navigator.pop(context);
        }
      },
      child: Text(
        "Update",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      color: primaryColor,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 15.0),
    );
  }
}
