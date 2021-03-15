import 'dart:convert';
import 'dart:ui';

import 'package:baitaplon/classes/Questionnaire.dart';
import 'package:baitaplon/classes/QuestionnaireTemplate.dart';
import 'package:baitaplon/models/Users.dart';
import 'package:baitaplon/page/LoginPage.dart';
import 'package:baitaplon/page/ConfigurePage.dart';
import 'package:baitaplon/routes/RouteName.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserWidget extends StatelessWidget {
  final User user;
  UserWidget({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Text("Hi " + user.name),
    );
  }
}

class HomePage extends StatefulWidget {
  final User user;
  HomePage({this.user});
  @override
  _HomePageState createState() => _HomePageState(user);
}

class _HomePageState extends State<HomePage> {
  List<String> questionnairesByTopics = [
    "Toán",
    "Âm nhạc",
    "Khoa học",
    "Ứng dụng điện toán đám mây",
    "Phim ảnh"
  ];
  List<String> questionnairesCurrentlyPlay = [
    "Phân tích thiết kế",
    "Tích Phân",
    "Khoa học"
  ];
  bool colorDebug = true;
  SharedPreferences sharedPreferences;
  List<dynamic> data;
  User user;
  _HomePageState(User user0) {
    user = user0;
  }

  num rating = 4;
  @override
  void initState() {
    super.initState();
    // checkLoginStatus();
  }

  checkLoginStatus() async {
    // ignore: unnecessary_statements
    user == null ? Navigator.of(context).pop() : () {};
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
    return Column(children: [
      Container(
          margin: EdgeInsets.fromLTRB(10, 15, 0, 20),
          alignment: Alignment.topLeft,
          child: Text(
            "Recent Quiz",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 27),
          )),
      for (var questionnaire in questionnairesCurrentlyPlay)
        Container(
          margin: EdgeInsets.fromLTRB(22, 8, 20, 15),
          width: MediaQuery.of(context).size.width - 42,
          height: MediaQuery.of(context).size.height * 1 / 8,
          color: colorDebug ? Colors.red : null,
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
                margin: EdgeInsets.fromLTRB(12, 11, 0, 0),
                child: Column(children: [
                  Container(
                    child: Text(
                      questionnaire,
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
                      "Người dùng : dd/mm/yy",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
                      textAlign: TextAlign.left,
                    ),
                    color: colorDebug ? Colors.white : null,
                    width: 150,
                  ),
                  Container(
                    child: Text(
                      "Đây là một đoạn mô tả dài !!!!",
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
                margin: EdgeInsets.fromLTRB(35, 12, 10, 12),
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
                  Text(
                    "số điểm của bạn là: 50",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 9,
                    ),
                    textAlign: TextAlign.center,
                  )
                ]),
              ),
            ],
          ),
        )
    ]);
  }

  Widget questionnairesByTopic() {
    double fraction = 0.9;
    return Container(
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
              for (var questionnaire in questionnairesByTopics)
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ConfigurePage(
                                questionnaire: Questionnaire(
                                    QuestionnaireTemplate(10, [], true),
                                    questionnaire,
                                    0,
                                    150))));
                  },
                  child: Card(
                    color: colorDebug ? Colors.green : null,
                    elevation: 10,
                    margin: EdgeInsets.all(15),
                    child: Container(
                        height: MediaQuery.of(context).size.height * fraction,
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Center(
                            child: Text(
                          questionnaire,
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
    );
  }
}
