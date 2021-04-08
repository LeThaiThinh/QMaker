import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../constants/sharedData.dart';
import '../../models/Questionnaire.dart';
import '../../models/Users.dart';
import '../../routes/RouteName.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedData sharedData;
  User user;

  @override
  Widget build(BuildContext context) {
    setState(() {
      user = Provider.of<SharedData>(context, listen: false).user;
    });
    fetchQuestionnaireTopic(http.Client(), user.id).then((value) async {
      await Provider.of<SharedData>(context, listen: false)
          .changeQuestionnaireTopic(value);
    });
    fetchQuestionnaire(http.Client(), user.id, "?recentlyUsed=DESC")
        .then((value) async {
      await Provider.of<SharedData>(context, listen: false)
          .changeQuestionnaireCurrentlyUsed(value);
    });

    return Scaffold(
      body: ListView(
        children: [
          topicOfQuestionnairesSection(),
          recentlyPlayedQuestionnaireSection(),
        ],
      ),
    );
  }

  Widget recentlyPlayedQuestionnaireSection() {
    Widget title() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // margin: EdgeInsets.only(top: 20, left: 20, bottom: 20),
            child: Text(
              "Recent Quiz",
              style: TextStyle(
                fontSize: 28,
                color: Color(0xffeb5757),
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      );
    }

    Widget questionnaireBody(Questionnaire questionnaire) {
      TextSpan name() {
        final double _fontsize = 20;
        return TextSpan(
          style: TextStyle(
            color: Color(0xffEB5757),
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
          children: [
            TextSpan(text: questionnaire.name),
          ],
        );
      }

      TextSpan belowName() {
        final double _fontsize = 20;
        return TextSpan(
          style: TextStyle(
            fontSize: 12,
            color: Color(0xffC1C1C1),
            fontWeight: FontWeight.w400,
          ),
          children: [
            TextSpan(
              text: questionnaire.createdAt.substring(0, 10) + " ",
            ),
            TextSpan(
              text: "created by " + questionnaire.user.username,
            ),
            TextSpan(
              text: "\n\n" + questionnaire.description,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xffA1A1A1),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        );
      }

      Widget topic() {
        return Container(
          width: 80,
          margin: EdgeInsets.only(top: 0, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.red,
          ),
          child: Text(
            questionnaire.topic,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xffFFFFFF),
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        );
      }

      Widget rating() {
        return RatingBar.builder(
          initialRating: double.parse(questionnaire.history.rating.toString()),
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          ignoreGestures: true,
          itemSize: 20,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        );
      }

      return Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.all(10),
            onTap: () {
              fetchQuestionnaireById(http.Client(), user.id, questionnaire.id)
                  .then((value) {
                Provider.of<SharedData>(context, listen: false)
                    .changeQuestionnaireIsChoosing(value);
              }).then((value) {
                Navigator.of(context).pushNamed(configureRoute);
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            title: Text.rich(name()),
            subtitle: Text.rich(belowName()),
            trailing: Column(
              children: [
                topic(),
                rating(),
              ],
            ),
          ),
        ],
      );
    }

    Widget recentlyPlayedQuestionnaire({Questionnaire questionnaire}) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: -20,
                blurRadius: 4,
                offset: Offset(
                  2,
                  2,
                ))
          ],
        ),
        child: Card(
            margin: EdgeInsets.fromLTRB(20, 5, 20, 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: questionnaireBody(questionnaire)), //noi dung recent post
      );
    }

    return Consumer<SharedData>(builder: (context, data, child) {
      List<Questionnaire> list = data.recentlyUsed;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: title(),
            margin: EdgeInsets.only(top: 20, left: 20, bottom: 20),
          ),
          ...list.map((e) => recentlyPlayedQuestionnaire(questionnaire: e))
        ],
      );
    });
  }

  Widget topicOfQuestionnairesSection() {
    Widget topicOfQuestionnaires({String topic}) {
      return Container(
        margin: EdgeInsets.only(top: 20, left: 20, bottom: 20),
        width: 100,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            topic,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
            ),
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  // spreadRadius: 3,
                  blurRadius: 4,
                  // offset: Offset(0, 2),
                  offset: Offset(
                    2,
                    2,
                  ))
            ],
            color: Colors.white),
      );
    }

    return Consumer<SharedData>(builder: (context, data, child) {
      List<Map<dynamic, dynamic>> list = data.topic;
      return Container(
        height: 150,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ...list.map((e) => topicOfQuestionnaires(topic: e['topic']))
          ],
        ),
      );
    });
  }
}

class MyPage1widget {}
