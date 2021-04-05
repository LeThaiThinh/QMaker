import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:baitaplon/constants/sharedData.dart';
import 'package:baitaplon/models/Questionnaire.dart';
import 'package:baitaplon/models/Users.dart';
import 'package:baitaplon/page/auth/LoginPage.dart';
import 'package:baitaplon/page/ConfigurePage.dart';
import 'package:baitaplon/routes/RouteName.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool colorDebug = false;
  User user;
  num rating = 4;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      user = Provider.of<SharedData>(context, listen: false).user;
    });
    fetchQuestionnaireTopic(http.Client(), user.id).then((value) async {
      // print(value[0]['topic']);
      await Provider.of<SharedData>(context, listen: false)
          .changeQuestionnaireTopic(value);
    });
    fetchQuestionnaire(http.Client(), user.id, "?recentlyUsed=DESC")
        .then((value) async {
      // print(value[0].topic);
      await Provider.of<SharedData>(context, listen: false)
          .changeQuestionnaireCurrentlyUsed(value);
    });
    return Scaffold(
      body: Column(
        children: [
          questionnairesByTopic(),
          questionnaireRecentlyPlay(),
        ],
      ),
    );
  }

  Widget questionnaireRecentlyPlay() {
    return Consumer<SharedData>(
        builder: (context, data, child) => Column(children: [
              Container(
                  margin: EdgeInsets.fromLTRB(10, 15, 0, 20),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Recent Quiz",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 27),
                  )),
              for (var questionnaire in data.currentlyUsed)
                Container(
                    margin: EdgeInsets.fromLTRB(26, 8, 15, 5),
                    width: MediaQuery.of(context).size.width - 42,
                    height: MediaQuery.of(context).size.height * 1 / 8,
                    color: colorDebug ? Colors.red : Colors.white,
                    child: RaisedButton(
                      color: Colors.white70,
                      onPressed: () async {
                        fetchNumberOfQuestion(
                                http.Client(),
                                questionnaire.id,
                                Provider.of<SharedData>(context, listen: false)
                                    .user
                                    .id)
                            .then((value) => setState(() {
                                  Provider.of<SharedData>(context,
                                          listen: false)
                                      .changeNumberOfQuestion(value);
                                }))
                            .then((value) => (fetchQuestionnaireById(
                                        http.Client(),
                                        user.id,
                                        questionnaire.id)
                                    .then((value) {
                                  // print(value[0].topic);
                                  Provider.of<SharedData>(context,
                                          listen: false)
                                      .changeQuestionnaireIsChoosing(value);
                                  debugPrint(value.id.toString());
                                }).then((value) {
                                  Navigator.of(context)
                                      .pushNamed(configureRoute);
                                  // MaterialPageRoute(
                                  //   builder: (_) => ConfigurePage()));
                                })));
                      },
                      child: Row(
                        children: [
                          // icon
                          Container(
                            child: Icon(
                              Icons.lightbulb_outline_rounded,
                              size: 25,
                              color: colorDebug ? Colors.white : null,
                            ),
                            padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                            color: colorDebug ? Colors.grey : Colors.grey,
                          ),
                          // //description
                          Container(
                            margin: EdgeInsets.fromLTRB(12, 12, 0, 0),
                            child: Column(children: [
                              Container(
                                child: Text(
                                  questionnaire.topic,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                color: colorDebug ? Colors.white : null,
                                width: 150,
                              ),
                              Container(
                                child: Text(
                                  "Đăng bởi " +
                                      user.username +
                                      ": " +
                                      questionnaire.createdAt.substring(0, 10),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11),
                                  textAlign: TextAlign.left,
                                ),
                                color: colorDebug ? Colors.white : null,
                                width: 150,
                              ),
                              Container(
                                child: Text(
                                  questionnaire.description,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 2),
                                color: colorDebug ? Colors.white : null,
                                width: 150,
                              ),
                            ]),
                          ),
                          //rating
                          Container(
                            margin: EdgeInsets.fromLTRB(18, 12, 2, 5),
                            color: colorDebug ? Colors.white : null,
                            child: Column(children: [
                              Row(children: [
                                for (int i = 1;
                                    i <= questionnaire.history.rating;
                                    i++)
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 13,
                                  ),
                                for (int i = 1;
                                    i <= 5 - questionnaire.history.rating;
                                    i++)
                                  Icon(
                                    Icons.star,
                                    color: Colors.grey,
                                    size: 13,
                                  )
                              ]),
                              Container(
                                  margin: EdgeInsets.fromLTRB(5, 5, 2, 2),
                                  color: colorDebug ? Colors.white : null,
                                  width: 90,
                                  child: Text(
                                    "Điểm cao nhất của bạn là: 50",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 9,
                                    ),
                                    textAlign: TextAlign.center,
                                  ))
                            ]),
                          ),
                        ],
                      ),
                    ))
            ]));
  }

  Widget questionnairesByTopic() {
    double fraction = 0.9;
    return Consumer<SharedData>(
        builder: (context, data, child) => Container(
              color: colorDebug ? Colors.red[100] : null,
              alignment: Alignment.topLeft,
              height: MediaQuery.of(context).size.height * 4 / 15,
              width: MediaQuery.of(context).size.width,
              child: DraggableScrollableSheet(
                initialChildSize: fraction,
                minChildSize: fraction,
                maxChildSize: fraction,
                expand: false,
                builder: (BuildContext context, ScrollController controller) {
                  return SingleChildScrollView(
                    controller: controller,
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      for (var questionnaire in data.topic)
                        RaisedButton(
                          color: Colors.white,
                          onPressed: () {
                            var topic = questionnaire["topic"];
                            fetchQuestionnaire(
                                    http.Client(), user.id, "?topic=$topic")
                                .then((value) async {
                              // print(value[0]['topic']);
                              await Provider.of<SharedData>(context,
                                      listen: false)
                                  .changeQuestionnaireByTopic(value);
                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            color: colorDebug ? Colors.green : null,
                            elevation: 20,
                            margin: EdgeInsets.all(15),
                            child: Container(
                                height: MediaQuery.of(context).size.height *
                                    fraction,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Center(
                                    child: Text(
                                  questionnaire['topic'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.red[600]),
                                ))),
                          ),
                        ),
                    ]),
                  );
                },
              ),
            ));
  }
}
