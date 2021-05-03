import 'package:flutter/material.dart';
import 'package:frontend/localization/LocalizationConstant.dart';
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
        title: Text(getTranslated(context, "New Questionaire"), key: Key("titleCreateQuestionnaire")),
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
      key: Key("nameCreateQuestionnaire"),
      controller: nameController,
      decoration: InputDecoration(labelText: getTranslated(context, "Name")),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty
            ? getTranslated(context, 'Name cannot be blank')
            : value.length >= 31
                ? getTranslated(
                    context, "Name input length must smaller than 30")
                : null;
      },
    );
  }

  Widget topicInput() {
    return TextFormField(
      key: Key("topicCreateQuestionnaire"),
      controller: topicController,
      decoration: InputDecoration(labelText: getTranslated(context, "Topic")),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty
            ? getTranslated(context, 'Topic cannot be blank')
            : value.length >= 12
                ? getTranslated(context, "Topic input length must smaller than 10")
                : null;
      },
    );
  }

  Widget timeLimitInput() {
    return TextFormField(
      key: Key("timeLimitCreateQuestionnaire"),
      controller: timeLimitController,
      decoration: InputDecoration(
          labelText: getTranslated(context, "Time Limit") +
              "(" +
              getTranslated(context, "mins") +
              ")"),
      keyboardType: TextInputType.number,
      validator: (value) {
        return value.isEmpty
            ? getTranslated(context, 'Time limit cannot be blank')
            : double.tryParse(value) == null
                ? getTranslated(context, "Time input must be number")
                : double.tryParse(value) > 10000
                    ? getTranslated(context, "Time input must smaller 10000")
                    : null;
      },
    );
  }

  Widget descInput() {
    return TextFormField(
      key: Key("desCreateQuestionnaire"),
      controller: descController,
      decoration: InputDecoration(labelText: getTranslated(context, "Description")),
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      validator: (value) {
        return value.isEmpty
            ? getTranslated(context, 'Description cannot be blank')
            : value.length >= 200
                ? getTranslated(context, "Description input length must smaller than 200")
                : null;
      },
    );
  }

  Widget privateCheckbox() {
    return CheckboxListTile(
      key: Key("privateCreateQuestionnaire"),
      value: private,
      onChanged: (val) {
        setState(() {
          private = val;
        });
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      title: Text(
        getTranslated(context, "Private"),
        style: TextStyle(color: Colors.black54),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.all(0),
    );
  }

  Widget createButton() {
    // ignore: deprecated_member_use
    return FlatButton(
      key: Key("createQuestionnaire"),
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
        getTranslated(context, "Create"),
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
