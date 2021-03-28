import 'package:baitaplon/constants/myColors.dart';
import 'package:baitaplon/models/Question.dart';
import 'package:flutter/material.dart';


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
  TextEditingController nameController;
  TextEditingController trueAnswerController;
  TextEditingController falseAnswer1Controller;
  TextEditingController falseAnswer2Controller;
  TextEditingController falseAnswer3Controller;

  @override
  Widget build(BuildContext context) {
    nameController = TextEditingController(text: this.widget.question.question);
    trueAnswerController =
        TextEditingController(text: this.widget.question.correctanswer);
    falseAnswer1Controller =
        TextEditingController(text: this.widget.question.incorrectanswer1);
    falseAnswer2Controller =
        TextEditingController(text: this.widget.question.incorrectanswer2);
    falseAnswer3Controller =
        TextEditingController(text: this.widget.question.incorrectanswer3);

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Question"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 5.0),
            child: IconButton(
              icon: Icon(Icons.delete, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: [
            nameInput(),
            SizedBox(height: 20.0),
            trueAnswerInput(),
            SizedBox(height: 20.0),
            falseAnswer1Input(),
            SizedBox(height: 20.0),
            falseAnswer2Input(),
            SizedBox(height: 20.0),
            falseAnswer3Input(),
            SizedBox(height: 40.0),
            updateButton(),
          ],
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

  Widget trueAnswerInput() {
    return TextFormField(
      controller: trueAnswerController,
      decoration: InputDecoration(labelText: "True Answer"),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty ? 'True Answer cannot be blank' : null;
      },
    );
  }

  Widget falseAnswer1Input() {
    return TextFormField(
      controller: falseAnswer1Controller,
      decoration: InputDecoration(labelText: "False Answer 1"),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty ? 'False Answer 1 cannot be blank' : null;
      },
    );
  }

  Widget falseAnswer2Input() {
    return TextFormField(
      controller: falseAnswer2Controller,
      decoration: InputDecoration(labelText: "False Answer 2"),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty ? 'False Answer 2 cannot be blank' : null;
      },
    );
  }

  Widget falseAnswer3Input() {
    return TextFormField(
      controller: falseAnswer3Controller,
      decoration: InputDecoration(labelText: "False Answer 3"),
      keyboardType: TextInputType.text,
      validator: (value) {
        return value.isEmpty ? 'False Answer 3 cannot be blank' : null;
      },
    );
  }

  Widget updateButton() {
    // ignore: deprecated_member_use
    return FlatButton(
      onPressed: () {
        final FormState form = formKey.currentState;
        if (form.validate()) {
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
