import 'dart:convert';
import 'dart:io';
import 'package:baitaplon/page/questionnaire/EditQuestionnairePage.dart';

import '../models/Questionnaire.dart';
import 'package:baitaplon/constants/Strings.dart';
import 'package:baitaplon/constants/sharedData.dart';
import 'package:baitaplon/models/History.dart';
import 'package:baitaplon/models/Questionnaire.dart';
import 'package:baitaplon/models/Users.dart';
import 'package:baitaplon/page/MainPage.dart';
import 'package:baitaplon/page/questionnaire/CreateQuestionPage.dart';
import 'package:baitaplon/routes/RouteName.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ConfigurePage extends StatefulWidget {
  // Questionnaire questionnaire;

  ConfigurePage({Key key}) : super(key: key);
  @override
  _ConfigurePageState createState() => _ConfigurePageState();
}

class _ConfigurePageState extends State<ConfigurePage> {
  bool colorDebug = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<SharedData>(
        builder: (context, data, child) => Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).popAndPushNamed(mainRoute).then(
                        (value) =>
                            Provider.of<SharedData>(context, listen: false)
                                .changeNumberOfQuestion(null));
                  },
                ),
                title: Text(
                  "Bộ câu hỏi",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
                ),
              ),
              body: CustomScrollView(slivers: <Widget>[
                SliverList(
                    delegate: SliverChildListDelegate([
                  Container(
                      margin: EdgeInsets.fromLTRB(18, 36, 10, 0),
                      child: Column(
                        children: [
                          Container(
                            child: Row(children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 2 / 3,
                                child: Text(
                                  data.questionnaireIsChoosing.topic
                                          .toUpperCase() +
                                      " : " +
                                      data.questionnaireIsChoosing.name
                                          .toLowerCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 23),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width *
                                          1 /
                                          10,
                                      0,
                                      0,
                                      0),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (_) => EditQuestionnairePage(
                                              questionnaire: data
                                                  .questionnaireIsChoosing)));
                                    },
                                    icon: Icon(
                                      Icons.settings,
                                      size: 30,
                                    ),
                                  ))
                            ]),
                            color: colorDebug ? Colors.green : null,
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.centerLeft,
                          ),
                          Container(
                            child: Text(
                                "Đăng bởi " +
                                    data.user.name +
                                    " " +
                                    data.questionnaireIsChoosing.createdAt
                                        .substring(0, 10),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                )),
                            color: colorDebug ? Colors.green : null,
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(0, 3, 0, 13),
                          ),
                          Row(children: [
                            for (int i = 1;
                                i <=
                                    data.questionnaireIsChoosing.history.rating;
                                i++)
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                            for (int i = 1;
                                i <=
                                    5 -
                                        data.questionnaireIsChoosing.history
                                            .rating;
                                i++)
                              Icon(
                                Icons.star,
                                color: Colors.grey,
                              )
                          ]),
                          Container(
                            child: Text(
                              data.questionnaireIsChoosing.description,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 18,
                              ),
                            ),
                            color: colorDebug ? Colors.green : null,
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(0, 12, 0, 22),
                          ),
                          Container(
                            child: Text(
                                "Tổng số câu hỏi :" +
                                    data.numberOfQuestion.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 14)),
                            color: colorDebug ? Colors.green : null,
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.centerLeft,
                          ),
                        ],
                      )),
                ]))
              ]),
              persistentFooterButtons: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0, 13, MediaQuery.of(context).size.width * 1 / 6, 22),
                  color: colorDebug ? Colors.red[300] : null,
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  child: Text(
                    "Điểm cao nhất của bạn :" +
                        data.questionnaireIsChoosing.history.rating.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                //nút bắt đầu ngay
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.red[300],
                  ),
                  margin: EdgeInsets.fromLTRB(
                      0, 13, MediaQuery.of(context).size.width * 1 / 8, 22),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 3 / 4,
                  height: 51,
                  child: RaisedButton(
                    elevation: 0,
                    onPressed: () async {
                      await setRecentlyUsed(
                          http.Client(),
                          context,
                          data.questionnaireIsChoosing.id,
                          data.questionnaireIsChoosing.user.id);
                    },
                    color: Colors.red[300],
                    child: Text("Bắt đầu ngay",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: colorDebug ? Colors.green : null)),
                  ),
                ),
              ],
            ));
  }
}
