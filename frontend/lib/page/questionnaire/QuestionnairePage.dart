import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/localization/LocalizationConstant.dart';
import 'package:provider/provider.dart';
import '../ingame/GameScreen.dart';
import '../../constants/myColors.dart';
import '../../constants/sharedData.dart';
import '../MainPage.dart';
import 'EditQuestionnairePage.dart';

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
        title: Text(getTranslated(context, "Questionnaire")),
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
    return data.user.id == data.questionnaireIsChoosing.userId
        ? Container(
            margin: EdgeInsets.only(right: 5.0),
            child: IconButton(
              key: Key("goToEditQuestionnaire"),
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
          )
        : Text("");
  }

  Widget body() {
    return ListView(
      padding: EdgeInsets.all(20.0),
      children: [
        Text(
          getTranslated(context, "Name") +
              ": " +
              data.questionnaireIsChoosing.name,
          style: TextStyle(
            color: primaryColor,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10),
        Text(
          data.questionnaireIsChoosing.createdAt.substring(0, 10) +
              " " +
              getTranslated(context, "created by") +
              " " +
              data.questionnaireIsChoosing.user.username,
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 20),
        RatingBar.builder(
          initialRating:
              double.parse(data.questionnaireIsChoosing.avgRating.toString()),
          minRating: 0,
          itemCount: 5,
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          allowHalfRating: true,
          tapOnlyMode: false,
          onRatingUpdate: (value) {},
          itemSize: 20.0,
          ignoreGestures: true,
        ),
        SizedBox(height: 20),
        Text(
          getTranslated(context, "Topic") +
              ": " +
              data.questionnaireIsChoosing.topic,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 20),
        Text(
          getTranslated(context, "Total") +
              ": " +
              data.questionnaireIsChoosing.listQuestion.length.toString() +
              " " +
              getTranslated(context, "questions"),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20),
        Text(
          getTranslated(context, "Time Limit") +
              ": " +
              data.questionnaireIsChoosing.timeLimit.toString() +
              " " +
              getTranslated(context, "mins"),
          style: TextStyle(
            color: primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Text(
          getTranslated(context, "Description") +
              ": " +
              data.questionnaireIsChoosing.description,
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
      key: Key("startQuestionnaire"),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        onPressed: () async {
          data.questionnaireIsChoosing.listQuestion.isNotEmpty
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => GameScreen(
                          questionnaire: data.questionnaireIsChoosing)))
              // ignore: unnecessary_statements
              : {};
        },
        child: Text(
          getTranslated(context, "Start"),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
