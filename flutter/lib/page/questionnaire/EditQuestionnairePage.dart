import 'package:baitaplon/constants/myColors.dart';
import 'package:baitaplon/models/Question.dart';
import 'package:baitaplon/models/Questionnaire.dart';
import 'package:baitaplon/page/MainPage.dart';
import 'package:baitaplon/page/questionnaire/CreateQuestionPage.dart';
import 'package:baitaplon/page/questionnaire/EditQuestion.dart';
import 'package:flutter/material.dart';

class EditQuestionnaire extends StatefulWidget {
  EditQuestionnaire({
    Key key,
    @required this.questionaire,
  }) : super(key: key);

  final Questionnaire questionaire;
  @override
  _EditQuestionnaireState createState() => _EditQuestionnaireState();
}

class _EditQuestionnaireState extends State<EditQuestionnaire> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Questionnaire"),
        leading: Container(
          margin: EdgeInsets.only(left: 5.0),
          child: IconButton(
            icon: Icon(Icons.book_outlined, size: 30),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
                (route) => false,
              );
            },
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 5.0),
            child: IconButton(
              icon: Icon(Icons.delete, size: 30),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                  (route) => false,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: addButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: questionnaireBody(),
    );
  }

  Widget addButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateQuestionPage(),
            ),
          );
        },
        child: Text(
          "Add",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget questionnaireBody() {
    return ListView(
      padding: EdgeInsets.all(20.0),
      children: [
        questionnaireInfo(),
        SizedBox(height: 20.0),
        questionTile(
          question: Question(
              id: 1,
              questionnaireId: 1,
              question: "1",
              correctanswer: "1",
              incorrectanswer1: "1",
              incorrectanswer2: "1",
              incorrectanswer3: "1"),
        ),
      ],
    );
  }

  Widget questionnaireInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Name: " + this.widget.questionaire.name,
          style: TextStyle(
            color: primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          "Topic: " + this.widget.questionaire.topic,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          "Time Limit: " +
              this.widget.questionaire.timeLimit.toString() +
              " mins",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          "Total: 3 questions",
          style: TextStyle(
            color: Colors.black45,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget questionTile({Question question}) {
    return Card(
      margin: EdgeInsets.only(bottom: 20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditQuestion(
                      )));
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        )),
        title: Text(
          question.question,
          style: TextStyle(
            color: Color(0xff4f4f4f),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
