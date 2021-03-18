import 'dart:convert';
import 'dart:ui';
import 'package:baitaplon/models/Questionnaire.dart';
import 'package:baitaplon/models/Users.dart';
import 'package:baitaplon/page/LoginPage.dart';
import 'package:baitaplon/page/ConfigurePage.dart';
import 'package:baitaplon/routes/RouteName.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage({this.user});
  @override
  _HomePageState createState() => _HomePageState(user);
}

class _HomePageState extends State<HomePage> {
  bool colorDebug = false;
  List<dynamic> data;
  User user;
  _HomePageState(User user0) {
    user = user0;
  }
  num rating = 4;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<User>(
          initialData:
              User(id: 0, name: "User", username: "Username", password: "0"),
          future: fetchUsersById(http.Client(), user.id),
          builder: (context, snapshot) => snapshot.hasError
              ? Center(
                  child: Text(
                  snapshot.error.toString(),
                  style: TextStyle(
                    fontSize: 6.5,
                  ),
                ))
              : snapshot.hasData != null
                  ? Text(
                      "Hello " + snapshot.data.name.toString(),
                      style: TextStyle(
                          backgroundColor: colorDebug ? Colors.green : null),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
            child: Text("Log Out", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Column(
        children: [
          questionnairesByTopic(),
          questionnaireCurrentlyPlay(),
        ],
      ),
    );
  }

  Widget questionnaireCurrentlyPlay() {
    return FutureBuilder<List<Questionnaire>>(
        initialData: [
          Questionnaire(
              topic: "topic",
              timeLimit: 100,
              description: "description",
              public: true,
              createAt: "0000000000000")
        ],
        future: fetchQuestionnaire(http.Client(), user.id, "?updatedAt=DESC"),
        builder: (context, snapshot) => Column(children: [
              Container(
                  margin: EdgeInsets.fromLTRB(10, 15, 0, 20),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Recent Quiz",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 27),
                  )),
              for (var questionnaire in snapshot.data)
                Container(
                    margin: EdgeInsets.fromLTRB(26, 8, 15, 5),
                    width: MediaQuery.of(context).size.width - 42,
                    height: MediaQuery.of(context).size.height * 1 / 8,
                    color: colorDebug ? Colors.red : null,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) =>
                                ConfigurePage(questionnaire: questionnaire)));
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
                                      questionnaire.createAt.substring(0, 10),
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
                                for (int i = 1; i <= rating; i++)
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 13,
                                  ),
                                for (int i = 1; i <= 5 - rating; i++)
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
    return FutureBuilder<List<Map>>(
      initialData: [
        {"topic": ""}
      ],
      future: fetchQuestionnaireTopic(http.Client(), user.id),
      builder: (context, snapshot) => snapshot.hasError
          ? Center(
              child: Text(
              snapshot.error.toString(),
              style: TextStyle(
                fontSize: 6.5,
              ),
            ))
          : snapshot.hasData != null
              ? Container(
                  color: colorDebug ? Colors.red[100] : null,
                  alignment: Alignment.topLeft,
                  height: MediaQuery.of(context).size.height * 4 / 15,
                  width: MediaQuery.of(context).size.width,
                  child: DraggableScrollableSheet(
                    initialChildSize: fraction,
                    minChildSize: fraction,
                    maxChildSize: fraction,
                    expand: false,
                    builder:
                        (BuildContext context, ScrollController controller) {
                      return SingleChildScrollView(
                        controller: controller,
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          for (var questionnaire in snapshot.data)
                            RaisedButton(
                              onPressed: () {},
                              child: Card(
                                color: colorDebug ? Colors.green : null,
                                elevation: 10,
                                margin: EdgeInsets.all(15),
                                child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        fraction,
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: Center(
                                        child: Text(
                                      questionnaire["topic"],
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
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
    );
  }
}
