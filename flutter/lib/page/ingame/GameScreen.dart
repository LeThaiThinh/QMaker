import 'dart:async';
import 'package:flutter/material.dart';

import '../../constants/myColors.dart';
import '../../models/Question.dart';
import '../../models/Questionnaire.dart';
import '../questionnaire/QuestionnairePage.dart';
import 'ResultPage.dart';
import 'Stage.dart';

class GameScreen extends StatefulWidget {
  GameScreen({
    Key key,
    @required this.questionnaire,
  }) : super(key: key);

  final Questionnaire questionnaire;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Timer timer;
  int start;
  int questionIndex;
  int totalCorrectAnswers;

  List<Question> questionList;

  @override
  void initState() {
    super.initState();
    questionList = this.widget.questionnaire.listQuestion;
    totalCorrectAnswers = 0;
    questionIndex = 0;
    questionList.shuffle();
    start = this.widget.questionnaire.timeLimit * 60; // minutes to seconds

    const duration = Duration(seconds: 1);
    timer = Timer.periodic(duration, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(
                questionnaire: this.widget.questionnaire,
                score: totalCorrectAnswers *
                    100 ~/
                    this.widget.questionnaire.listQuestion.length,
                timeFinish: this.widget.questionnaire.timeLimit * 60,
              ),
            ),
            (route) => false);
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: appBar(),
      // body: body(),
      body: Stage(
        stageNumber: questionIndex + 1,
        question: questionList.elementAt(questionIndex),
        nextStage: (String answer) {
          if (answer == questionList.elementAt(questionIndex).correctAnswer)
            totalCorrectAnswers++;

          if (questionIndex + 1 == questionList.length) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultPage(
                    questionnaire: this.widget.questionnaire,
                    score: totalCorrectAnswers *
                        100 ~/
                        this.widget.questionnaire.listQuestion.length,
                    timeFinish:
                        this.widget.questionnaire.timeLimit * 60 - start,
                  ),
                ),
                (route) => false);
          } else {
            setState(() {
              questionIndex++;
            });
          }
        },
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      elevation: 0,
      leading: InkWell(
        child: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: RotatedBox(
            quarterTurns: 2,
            child: Icon(
              Icons.exit_to_app_rounded,
              size: 40,
            ),
          ),
        ),
        onTap: () {
          showDialog(context: context, builder: (context) => exitDialog());
        },
      ),
      actions: [countdown()],
    );
  }

  Widget exitDialog() {
    return AlertDialog(
      title: Text("Are you sure?"),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => QuestionnairePage(),
                ),
                (route) => false,
              );
            },
            child: Text("YES"),
            textColor: Colors.white,
            color: Colors.green,
          ),
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("NO"),
            textColor: Colors.white,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget countdown() {
    return Row(
      children: [
        InkWell(
          child: Icon(Icons.timer, size: 35),
          onTap: () {},
        ),
        SizedBox(width: 10),
        Text(
          "${start.toString()} s",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 20),
      ],
    );
  }
}
