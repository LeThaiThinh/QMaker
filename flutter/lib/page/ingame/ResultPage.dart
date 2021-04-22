import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../models/Questionnaire.dart';
import '../MainPage.dart';
import 'GameScreen.dart';
import '../../constants/sharedData.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ResultPage extends StatefulWidget {
  ResultPage({
    Key key,
    @required this.questionnaire,
    @required this.timeFinish,
    @required this.score,
  }) : super(key: key);

  final Questionnaire questionnaire;
  final int timeFinish;
  final int score;

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int _rating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2994a),
      body: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: MediaQuery.of(context).size.height / 6,
        ),
        child: Column(
          children: [
            title(),
            SizedBox(height: 10),
            score(),
            SizedBox(height: 20),
            totalTime(),
            SizedBox(height: MediaQuery.of(context).size.height / 6),
            button(),
            SizedBox(height: MediaQuery.of(context).size.height / 12),
            ratingTitle(),
            SizedBox(height: 20),
            rating(),
          ],
        ),
      ),
    );
  }

  Widget title() {
    return Center(
      child: Text(
        "Your Score:",
        style: TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget score() {
    return Center(
      child: Text(
        this.widget.score.toString(),
        key: Key("score"),
        style: TextStyle(
          color: Colors.white,
          fontSize: 80,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget totalTime() {
    return Center(
      child: Text(
        "Time Finish: ${this.widget.timeFinish} seconds",
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget button() {
    return Consumer<SharedData>(
      builder: (context, data, child) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            key: Key("playAgain"),
            onTap: () {
              updateHistory(
                  http.Client(),
                  context,
                  this.widget.score,
                  this.widget.timeFinish,
                  _rating,
                  data.questionnaireIsChoosing.id,
                  data.user.id);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      GameScreen(questionnaire: this.widget.questionnaire),
                ),
              );
            },
            child: Icon(
              Icons.replay,
              size: 50,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 50),
          InkWell(
            key: Key("backToHomeFromResultPage"),
            onTap: () {
              updateHistory(
                  http.Client(),
                  context,
                  this.widget.score,
                  this.widget.timeFinish,
                  _rating,
                  data.questionnaireIsChoosing.id,
                  data.user.id);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage(
                        initBody:
                            Provider.of<SharedData>(context, listen: false)
                                .currentMainPage),
                  ),
                  (route) => false);
            },
            child: Icon(
              Icons.home,
              size: 50,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget ratingTitle() {
    return Text(
      "Rate now:",
      style: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget rating() {
    return RatingBar.builder(
      initialRating: 0,
      minRating: 1,
      itemCount: 5,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Color(0xfff2c946),
      ),
      onRatingUpdate: (value) {
        setState(() {
          if (value != 0)
            _rating = value.toInt();
          else
            _rating = 0;
        });
      },
      itemSize: 50.0,
    );
  }
}
