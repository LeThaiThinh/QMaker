import 'package:baitaplon/constants/bottomType.dart';
import 'package:baitaplon/constants/myColors.dart';
import 'package:baitaplon/constants/sharedData.dart';
import 'package:baitaplon/constants/slideRightRoute.dart';
import 'package:baitaplon/models/Question.dart';
import 'package:baitaplon/models/Questionnaire.dart';
import 'package:baitaplon/page/MainPage.dart';
import 'package:baitaplon/page/questionnaire/question/CreateQuestionPage.dart';
import 'package:baitaplon/page/questionnaire/CreateQuestionnairePage.dart';
import 'package:baitaplon/page/questionnaire/question/EditQuestion.dart';
import 'package:baitaplon/page/questionnaire/QuestionnairePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditQuestionnairePage extends StatefulWidget {
  EditQuestionnairePage({
    Key key,
    @required this.questionnaire,
  }) : super(key: key);

  final Questionnaire questionnaire;

  @override
  _EditQuestionnairePageState createState() => _EditQuestionnairePageState();
}

class _EditQuestionnairePageState extends State<EditQuestionnairePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Questionnaire"),
        leading: backButton(),
        actions: [deleteButton()],
      ),
      floatingActionButton: addButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: questionnaireBody(),
    );
  }

  Widget deleteButton() {
    return Container(
      margin: EdgeInsets.only(right: 5.0),
      child: IconButton(
        icon: Icon(Icons.delete, size: 30),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(
                initBody: BottomType.collection,
              ),
            ),
            (route) => false,
          );
        },
      ),
    );
  }

  Widget backButton() {
    return Container(
      margin: EdgeInsets.only(left: 5.0),
      child: IconButton(
        icon: Icon(Icons.arrow_back_ios_rounded, size: 25),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => QuestionnairePage()),
            (route) => false,
          );
        },
      ),
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
    return Consumer<SharedData>(builder: (context, data, child) {
      var listQuestion = data.questionnaireIsChoosing.listQuestion;
      return ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          questionnaireInfo(),
          SizedBox(height: 20.0),
          ...listQuestion.map((e) => questionTile(question: e))
        ],
      );
    });
  }

  Widget questionnaireInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Name: " + this.widget.questionnaire.name,
          style: TextStyle(
            color: primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          "Topic: " + this.widget.questionnaire.topic,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          "Time Limit: " +
              this.widget.questionnaire.timeLimit.toString() +
              " mins",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          "Total: " +
              this.widget.questionnaire.listQuestion.length.toString() +
              " questions",
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
                question: question,
              ),
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
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
