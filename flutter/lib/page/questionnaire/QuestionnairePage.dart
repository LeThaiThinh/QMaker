import 'package:baitaplon/constants/bottomType.dart';
import 'package:baitaplon/constants/myColors.dart';
import 'package:baitaplon/constants/sharedData.dart';
import 'package:baitaplon/constants/slideRightRoute.dart';
import 'package:baitaplon/models/Questionnaire.dart';
import 'package:baitaplon/page/MainPage.dart';
import 'package:baitaplon/page/questionnaire/EditQuestionnairePage.dart';
import 'package:baitaplon/routes/RouteName.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class QuestionnairePage extends StatefulWidget {
  QuestionnairePage({
    Key key,
  }) : super(key: key);

  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  SharedData data;

  @override
  Widget build(BuildContext context) {
    setState(() {
      data = Provider.of<SharedData>(context);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Questionnaire"),
        leading: backButton(),
        actions: [editQuestionnaire()],
      ),
      floatingActionButton: startButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: body(),
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
            MaterialPageRoute(
                builder: (_) => MainPage(initBody: data.currentMainPage)),
            (route) => false,
          );
        },
      ),
    );
  }

  Widget editQuestionnaire() {
    return Container(
      margin: EdgeInsets.only(right: 5.0),
      child: IconButton(
        icon: Icon(Icons.settings, size: 30),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditQuestionnairePage(
                    questionnaire: data.questionnaireIsChoosing)),
          );
        },
      ),
    );
  }

  Widget body() {
    return ListView(
      padding: EdgeInsets.all(20.0),
      children: [
        Text(
          "Name: " + data.questionnaireIsChoosing.name,
          style: TextStyle(
            color: primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10),
        Text(
          data.questionnaireIsChoosing.createdAt.substring(0, 10) +
              " by " +
              data.questionnaireIsChoosing.user.username,
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 20),
        RatingBar.builder(
          initialRating: double.parse(
              data.questionnaireIsChoosing.history.rating.toString()),
          minRating: 0,
          itemCount: 5,
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          tapOnlyMode: false,
          onRatingUpdate: (value) {},
          itemSize: 20.0,
          ignoreGestures: true,
        ),
        SizedBox(height: 20),
        Text(
          "Topic: " + data.questionnaireIsChoosing.topic,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Total: " +
              data.questionnaireIsChoosing.listQuestion.length.toString() +
              " questions",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Time Limit: " +
              data.questionnaireIsChoosing.timeLimit.toString() +
              " mins",
          style: TextStyle(
            color: primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Description: " + data.questionnaireIsChoosing.description,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget startButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        onPressed: () async {
          await setRecentlyUsed(
              http.Client(),
              context,
              data.questionnaireIsChoosing.id,
              data.questionnaireIsChoosing.user.id);
          Navigator.pushNamed(context, playModeRoute);
        },
        child: Text(
          "Start",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
