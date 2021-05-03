import 'package:flutter/material.dart';
import 'package:frontend/localization/LocalizationConstant.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/myColors.dart';
import '../../../constants/sharedData.dart';
import '../../../models/Question.dart';
import '../EditQuestionnairePage.dart';

class CreateQuestionPage extends StatefulWidget {
  CreateQuestionPage({
    Key key,
  }) : super(key: key);

  @override
  _CreateQuestionPageState createState() => _CreateQuestionPageState();
}

class _CreateQuestionPageState extends State<CreateQuestionPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final questionController = TextEditingController();
  final correctAnswerController = TextEditingController();
  final incorrectAnswer1Controller = TextEditingController();
  final incorrectAnswer2Controller = TextEditingController();
  final incorrectAnswer3Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getTranslated(context, "New Question"),
          key: Key("titleCreateQuestion"),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: [
            questionInput(),
            SizedBox(height: 20.0),
            correctAnswerInput(),
            SizedBox(height: 20.0),
            incorrectAnswer1Input(),
            SizedBox(height: 20.0),
            incorrectAnswer2Input(),
            SizedBox(height: 20.0),
            incorrectAnswer3Input(),
            SizedBox(height: 40.0),
            createButton(),
          ],
        ),
      ),
    );
  }

  Widget questionInput() {
    return TextFormField(
      key: Key("questionCreateQuestion"),
      controller: questionController,
      decoration:
          InputDecoration(labelText: getTranslated(context, "Question")),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty
            ? getTranslated(context, 'Question cannot be blank')
            : value.length >= 60
                ? getTranslated(
                    context, "Question input length must smaller than 80")
                : null;
      },
    );
  }

  Widget correctAnswerInput() {
    return TextFormField(
      key: Key("correctAnswerCreateQuestion"),
      controller: correctAnswerController,
      decoration:
          InputDecoration(labelText: getTranslated(context, "True Answer")),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty
            ? getTranslated(context, 'Correct Answer cannot be blank')
            : value.length >= 60
                ? getTranslated(
                    context, "Correct answer input length must smaller than 60")
                : null;
      },
    );
  }

  Widget incorrectAnswer1Input() {
    return TextFormField(
      key: Key("incorrectAnswerCreateQuestion1"),
      controller: incorrectAnswer1Controller,
      decoration:
          InputDecoration(labelText: getTranslated(context, "False Answer 1")),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty
            ? getTranslated(context, 'Incorrect Answer 1 cannot be blank')
            : value.length >= 60
                ? getTranslated(context,
                    "Incorrect answer 1 input length must smaller than 60")
                : null;
      },
    );
  }

  Widget incorrectAnswer2Input() {
    return TextFormField(
      key: Key("incorrectAnswerCreateQuestion2"),
      controller: incorrectAnswer2Controller,
      decoration:
          InputDecoration(labelText: getTranslated(context, "False Answer 2")),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty
            ? getTranslated(context, 'Incorrect Answer 2 cannot be blank')
            : value.length >= 10
                ? getTranslated(context,
                    "Incorrect answer 2 input length must smaller than 60")
                : null;
      },
    );
  }

  Widget incorrectAnswer3Input() {
    return TextFormField(
      key: Key("incorrectAnswerCreateQuestion3"),
      controller: incorrectAnswer3Controller,
      decoration:
          InputDecoration(labelText: getTranslated(context, "False Answer 3")),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty
            ? getTranslated(context, 'Incorrect answer 3 cannot be blank')
            : value.length >= 60
                ? getTranslated(context,
                    "Incorrect answer 3 input length must smaller than 60")
                : null;
      },
    );
  }

  Widget createButton() {
    // ignore: deprecated_member_use
    return FlatButton(
      key: Key("createQuestion"),
      onPressed: () async {
        final FormState form = formKey.currentState;
        if (form.validate()) {
          form.save();
          createQuestion(
                  http.Client(),
                  Provider.of<SharedData>(context, listen: false).user.id,
                  Provider.of<SharedData>(context, listen: false)
                      .questionnaireIsChoosing
                      .id,
                  questionController.text,
                  correctAnswerController.text,
                  incorrectAnswer1Controller.text,
                  incorrectAnswer2Controller.text,
                  incorrectAnswer3Controller.text)
              .then((value) {
            var listQuestion = Provider.of<SharedData>(context, listen: false)
                .questionnaireIsChoosing
                .listQuestion;
            listQuestion.add(value);
            Provider.of<SharedData>(context, listen: false)
                .changeListQuestionInChosenQuestionnaire(listQuestion);
          }).then((value) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditQuestionnairePage(
                  questionnaire: Provider.of<SharedData>(context, listen: false)
                      .questionnaireIsChoosing,
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
