import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../constants/myColors.dart';
import '../../constants/sharedData.dart';
import '../../models/Questionnaire.dart';
import 'EditQuestionnairePage.dart';

class CreateQuestionnairePage extends StatefulWidget {
  CreateQuestionnairePage({Key key}) : super(key: key);

  @override
  _CreateQuestionnairePageState createState() =>
      _CreateQuestionnairePageState();
}

class _CreateQuestionnairePageState extends State<CreateQuestionnairePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final topicController = TextEditingController();
  final timeLimitController = TextEditingController();
  final descController = TextEditingController();
  bool private;
  Questionnaire questionnaire;
  @override
  void initState() {
    super.initState();
    private = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Questionaire"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.all(20.0),
            children: [
              nameInput(),
              SizedBox(height: 20.0),
              topicInput(),
              SizedBox(height: 20.0),
              timeLimitInput(),
              SizedBox(height: 20.0),
              descInput(),
              SizedBox(height: 20.0),
              privateCheckbox(),
              SizedBox(height: 20.0),
              createButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget nameInput() {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(labelText: "Name"),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty ? 'Name cannot be blank' : null;
      },
    );
  }

  Widget topicInput() {
    return TextFormField(
      controller: topicController,
      decoration: InputDecoration(labelText: "Topic"),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty ? 'Topic cannot be blank' : null;
      },
    );
  }

  Widget timeLimitInput() {
    return TextFormField(
      controller: timeLimitController,
      decoration: InputDecoration(labelText: "Time Limit (mins)"),
      keyboardType: TextInputType.number,
      validator: (value) {
        return value.isEmpty ? 'Time limit cannot be blank' : null;
      },
    );
  }

  Widget descInput() {
    return TextFormField(
      controller: descController,
      decoration: InputDecoration(labelText: "Description"),
      keyboardType: TextInputType.multiline,
      maxLines: 3,
    );
  }

  Widget privateCheckbox() {
    return CheckboxListTile(
      value: private,
      onChanged: (val) {
        setState(() {
          private = val;
        });
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      title: Text(
        "Private",
        style: TextStyle(color: Colors.black54),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.all(0),
    );
  }

  Widget createButton() {
    // ignore: deprecated_member_use
    return FlatButton(
      onPressed: () {
        final FormState form = formKey.currentState;
        if (form.validate()) {
          form.save();
          createQuestionnaire(
              http.Client(),
              Provider.of<SharedData>(context, listen: false).user.id,
              nameController.text,
              topicController.text,
              descController.text,
              !private,
              int.parse(
                timeLimitController.text,
              )).then((value) {
            Provider.of<SharedData>(context, listen: false)
                .changeQuestionnaireIsChoosing(value);
            setState(() {
              questionnaire = value;
            });
          }).then((value) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditQuestionnairePage(
                  questionnaire: questionnaire,
                ),
              ),
            );
          });
        }
      },
      child: Text(
        "Create",
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
