import 'package:baitaplon/constants/myColors.dart';
import 'package:baitaplon/constants/sharedData.dart';
import 'package:baitaplon/models/Question.dart';
import 'package:baitaplon/models/Questionnaire.dart';
import 'package:baitaplon/page/MainPage.dart';
import 'package:baitaplon/page/bottom/HomePage.dart';
import 'package:baitaplon/page/questionnaire/EditQuestionnairePage.dart';
import 'package:baitaplon/routes/RouteName.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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
        title: Text("New Question"),
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
      controller: questionController,
      decoration: InputDecoration(labelText: "Question"),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty ? 'Question cannot be blank' : null;
      },
    );
  }

  Widget correctAnswerInput() {
    return TextFormField(
      controller: correctAnswerController,
      decoration: InputDecoration(labelText: "True Answer"),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty ? 'True Answer cannot be blank' : null;
      },
    );
  }

  Widget incorrectAnswer1Input() {
    return TextFormField(
      controller: incorrectAnswer1Controller,
      decoration: InputDecoration(labelText: "False Answer 1"),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty ? 'False Answer 1 cannot be blank' : null;
      },
    );
  }

  Widget incorrectAnswer2Input() {
    return TextFormField(
      controller: incorrectAnswer2Controller,
      decoration: InputDecoration(labelText: "False Answer 2"),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty ? 'False Answer 2 cannot be blank' : null;
      },
    );
  }

  Widget incorrectAnswer3Input() {
    return TextFormField(
      controller: incorrectAnswer3Controller,
      decoration: InputDecoration(labelText: "False Answer 3"),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty ? 'False Answer 3 cannot be blank' : null;
      },
    );
  }

  Widget createButton() {
    // ignore: deprecated_member_use
    return FlatButton(
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
