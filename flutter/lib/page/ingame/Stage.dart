import 'package:flutter/material.dart';

import '../../models/Question.dart';

class Stage extends StatefulWidget {
  const Stage({
    Key key,
    @required this.stageNumber,
    @required this.question,
    @required this.nextStage,
  }) : super(key: key);

  final int stageNumber;
  final Question question;
  final Function nextStage;

  @override
  _StageState createState() => _StageState();
}

class _StageState extends State<Stage> {
  List<String> answerList;

  @override
  void initState() {
    super.initState();
    answerList = [
      this.widget.question.correctAnswer,
      this.widget.question.incorrectAnswer1,
      this.widget.question.incorrectAnswer2,
      this.widget.question.incorrectAnswer3,
    ];
    answerList.shuffle();
  }

  @override
  void didUpdateWidget(covariant Stage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (this.widget.question != oldWidget.question) {
      answerList = [
        this.widget.question.correctAnswer,
        this.widget.question.incorrectAnswer1,
        this.widget.question.incorrectAnswer2,
        this.widget.question.incorrectAnswer3,
      ];
      answerList.shuffle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      height: MediaQuery.of(context).size.height - 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          questionInfo(),
          answerTileList(),
        ],
      ),
    );
  }

  Widget questionInfo() {
    return Column(
      children: [
        Text(
          this.widget.stageNumber.toString(),
          style: TextStyle(
            color: Color(0xfff2c94c),
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: Text(
            this.widget.question.question,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget answerTileList() {
    List<Widget> list = [];
    int index = 1;

    answerList.forEach((answer) {
      list.add(SizedBox(height: 20));
      list.add(answerTile(answer: answer, index: index));
      index++;
    });

    return Column(children: list);
  }

  Widget answerTile({
    String answer,
    int index,
  }) {
    Color color;

    switch (index) {
      case 1:
        color = Colors.greenAccent;
        break;
      case 2:
        color = Colors.amberAccent;
        break;
      case 3:
        color = Colors.lightBlueAccent;
        break;
      case 4:
        color = Colors.white;
        break;
      default:
        color = Colors.white;
    }

    // ignore: deprecated_member_use
    return FlatButton(
      onPressed: () {
        this.widget.nextStage(answer);
      },
      child: Text(
        answer,
        style: TextStyle(fontSize: 18),
      ),
      color: color,
      padding: EdgeInsets.all(20.0),
      minWidth: MediaQuery.of(context).size.width - 40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
