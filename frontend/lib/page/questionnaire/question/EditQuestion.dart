import 'package:flutter/material.dart';
import 'package:frontend/localization/LocalizationConstant.dart';
import 'package:frontend/page/questionnaire/EditQuestionnairePage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/myColors.dart';
import '../../../constants/sharedData.dart';
import '../../../models/Question.dart';
import '../../../models/Questionnaire.dart';

class EditQuestion extends StatefulWidget {
  EditQuestion({
    Key key,
    @required this.question,
  }) : super(key: key);

  final Question question;

  @override
  _EditQuestionState createState() => _EditQuestionState();
}

class _EditQuestionState extends State<EditQuestion> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController questionController;
  TextEditingController correctAnswerController;
  TextEditingController incorrectAnswer1Controller;
  TextEditingController incorrectAnswer2Controller;
  TextEditingController incorrectAnswer3Controller;

  @override
  Widget build(BuildContext context) {
    questionController =
        TextEditingController(text: this.widget.question.question);
    correctAnswerController =
        TextEditingController(text: this.widget.question.correctAnswer);
    incorrectAnswer1Controller =
        TextEditingController(text: this.widget.question.incorrectAnswer1);
    incorrectAnswer2Controller =
        TextEditingController(text: this.widget.question.incorrectAnswer2);
    incorrectAnswer3Controller =
        TextEditingController(text: this.widget.question.incorrectAnswer3);

    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, "Edit Question")),
        actions: [deleteButton()],
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
            updateButton(),
          ],
        ),
      ),
    );
  }

  Widget deleteButton() {
    return Consumer<SharedData>(
        builder: (context, data, child) => Container(
              margin: EdgeInsets.only(right: 5.0),
              child: IconButton(
                key: Key("deleteQuestion"),
                icon: Icon(Icons.delete, size: 30),
                onPressed: () {
                  deleteQuestion(
                          http.Client(),
                          data.questionnaireIsChoosing.id,
                          data.questionnaireIsChoosing.id,
                          this.widget.question.id)
                      .then((value) {
                    var listQuestion =
                        Provider.of<SharedData>(context, listen: false)
                            .questionnaireIsChoosing
                            .listQuestion;
                    listQuestion.remove(this.widget.question);
                    Provider.of<SharedData>(context, listen: false)
                        .changeListQuestionInChosenQuestionnaire(listQuestion);
                  }).then((value) {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => EditQuestionnairePage(
                                questionnaire: data.questionnaireIsChoosing)));
                  });
                },
              ),
            ));
  }

  Widget questionInput() {
    return TextFormField(
      key: Key("questionEditQuestion"),
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
      controller: correctAnswerController,
      decoration:
          InputDecoration(labelText: getTranslated(context, "True Answer")),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty
            ? getTranslated(context, 'True Answer cannot be blank')
            : value.length >= 60
                ? getTranslated(
                    context, "Correct answer input length must smaller than 60")
                : null;
      },
    );
  }

  Widget incorrectAnswer1Input() {
    return TextFormField(
      controller: incorrectAnswer1Controller,
      decoration:
          InputDecoration(labelText: getTranslated(context, "False Answer 1")),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty
            ? getTranslated(context, 'False Answer 1 cannot be blank')
            : null;
      },
    );
  }

  Widget incorrectAnswer2Input() {
    return TextFormField(
      controller: incorrectAnswer2Controller,
      decoration:
          InputDecoration(labelText: getTranslated(context, "False Answer 2")),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty
            ? getTranslated(context, 'False Answer 2 cannot be blank')
            : null;
      },
    );
  }

  Widget incorrectAnswer3Input() {
    return TextFormField(
      controller: incorrectAnswer3Controller,
      decoration:
          InputDecoration(labelText: getTranslated(context, "False Answer 3")),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty
            ? getTranslated(context, 'False Answer 3 cannot be blank')
            : null;
      },
    );
  }

  Widget updateButton() {
    // ignore: deprecated_member_use
    return Consumer<SharedData>(
        builder: (context, data, child) => FlatButton(
              key: Key("updateQuestion"),
              onPressed: () {
                final FormState form = formKey.currentState;
                if (form.validate()) {
                  form.save();
                  updateQuestion(
                          http.Client(),
                          data.user.id,
                          data.questionnaireIsChoosing.id,
                          this.widget.question.id,
                          questionController.text,
                          correctAnswerController.text,
                          incorrectAnswer1Controller.text,
                          incorrectAnswer2Controller.text,
                          incorrectAnswer3Controller.text)
                      .then((value) {
                    fetchQuestionnaireById(http.Client(), data.user.id,
                            data.questionnaireIsChoosing.id)
                        .then((value) {
                      Provider.of<SharedData>(context, listen: false)
                          .changeQuestionnaireIsChoosing(value);
                    }).then((value) {
                      Navigator.pop(context);
                    });
                  });
                }
              },
              child: Text(
                getTranslated(context, "Update"),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              color: primaryColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 15.0),
            ));
  }
}
