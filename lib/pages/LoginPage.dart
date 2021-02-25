import 'package:baitaplon/localization/LocalizationConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class  LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _key=GlobalKey<FormState>();
  void _showSuccessDialog(){
    showTimePicker(context: context, initialTime: TimeOfDay.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("login"),
      ),
      body: _mainForm(context),
    );
  }

  _mainForm(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 4,
            child: Center(
              child: Text(
                getTranslated(context, "personalInfo"),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          TextFormField(
            validator: (val) {
              if (val.isEmpty) {
                return 'requiredField';
              }
              return null;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
                hintText: 'Enter Name'
            ),
          ),
          SizedBox(height: 30,),
          TextFormField(
            validator: (val) {
              if (val.isEmpty) {
                return 'requiredField';
              }
              return null;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Enter Email'
            ),
          ),
          SizedBox(height: 30,),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Date Of Birth',
              hintText: 'Enter Date Of Birth',
            ),
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(DateTime
                      .now()
                      .year),
                  lastDate: DateTime(DateTime
                      .now()
                      .year + 20)
              );
            },
          ),
          SizedBox(height: 30,),
          MaterialButton(
            onPressed: () {
              if (_key.currentState.validate()) {
                _showSuccessDialog();
              }
            },
            height: 30,
            shape: StadiumBorder(),
            color: Theme
                .of(context)
                .primaryColor,
            child: Center(
              child: Text(
                'Submit Information',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}

