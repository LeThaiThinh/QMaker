import 'package:baitaplon/classes/Questionnaire.dart';
import 'package:baitaplon/models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/PlayExamPage.dart';

// ignore: must_be_immutable
class ConfigurePage extends StatefulWidget {
  Questionnaire questionnaire;

  ConfigurePage({Key key, @required this.questionnaire}) : super(key: key);
  @override
  _ConfigurePageState createState() => _ConfigurePageState(questionnaire);
}

class _ConfigurePageState extends State<ConfigurePage> {
  Questionnaire questionnaire;
  bool _changed = false;
  bool colorDebug = false;
  num rating = 4;

  _ConfigurePageState(this.questionnaire);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget _buildName() {
    return TextFormField(
      onChanged: (String string) {
        _changed = true;
      },
      decoration: InputDecoration(labelText: 'Name'),
      // ignore: missing_return
      initialValue: questionnaire.name,
      // ignore: missing_return
      validator: (String value) {
        // ignore: missing_return
        if (value.isEmpty) return "Name is required";
      },
      onSaved: (String value) {
        setState(() {
          questionnaire.name = value;
        });
      },
    );
  }

  Widget _buildTotalQuestion() {
    return TextFormField(
        decoration: InputDecoration(labelText: 'Total Question'),
        keyboardType: TextInputType.number,
        onChanged: (String string) {
          _changed = true;
        },
        // ignore: missing_return
        validator: (String value) {
          // ignore: missing_return
          if (value.isEmpty) return "Total Question is required";
          // ignore: unrelated_type_equality_checks
          if (int.tryParse(value) <= 0) return "Input must be greater than 0";
        },
        onSaved: (String value) {
          setState(() {
            questionnaire.totalQuestionInSession = int.tryParse(value);
          });
        });
  }

  Widget _buildTotalTime() {
    return TextFormField(
      onChanged: (String string) {
        _changed = true;
      },
      decoration: InputDecoration(labelText: 'Total Time'),
      keyboardType: TextInputType.number,
      // ignore: missing_return
      validator: (String value) {
        // ignore: missing_return
        if (value.isEmpty) return "Total Time is required";
        // ignore: unrelated_type_equality_checks
        if (int.tryParse(value) <= 0) return "Input must be greater than 0";
      },
      onSaved: (String value) {
        setState(() {
          questionnaire.totalTime = int.tryParse(value);
        });
      },
    );
  }

  Widget _createQuestionnaire() {
    return RaisedButton(
        child: Text("Create"),
        onPressed: () {
          if (!_formKey.currentState.validate()) {
            return;
          }
          _formKey.currentState.save();
          //điền tên bộ câu hỏi
          TextEditingController controller = TextEditingController();
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Name Your Questionnaire"),
                  content: TextField(
                    controller: controller,
                  ),
                  actions: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop(controller.text.toString());
                      },
                      child: Text('Submit'),
                    )
                  ],
                );
              }).then((value) {
            questionnaire.name = value;
            Provider.of<UserModel>(context, listen: false)
                .addListQuestionnaire(questionnaire);
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PlayExamPage(
                      questionnaire: questionnaire,
                    )));
          });
          //Tạo bộ câu hỏi mới và đổi màn hình
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bộ câu hỏi",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
        ),
      ),
      body: CustomScrollView(slivers: <Widget>[
        // SliverAppBar(
        //   expandedHeight: 200.0,
        //   centerTitle: true,
        //   floating: true,
        //   pinned: true,
        //   stretchTriggerOffset: 100,
        //   onStretchTrigger: (){},
        //   flexibleSpace: FlexibleSpaceBar(
        //     centerTitle: true,
        //     collapseMode: CollapseMode.parallax,
        //     background: Image(
        //       image: AssetImage("assets/camera.jpg"), fit: BoxFit.cover,),
        //     ),
        //   actions: [
        //     IconButton(
        //       onPressed: (){
        //         Navigator.of(context).push(
        //             MaterialPageRoute(builder: (context)=> PlayExamPage(questionnaire: questionnaire))
        //         );
        //       },
        //       icon:Icon(Icons.play_arrow_sharp,size: 30,),
        //     ),
        //     SizedBox(width: 10,),
        //   ],
        //   actionsIconTheme: IconTheme.of(context),
        //   iconTheme: IconTheme.of(context),
        // ),

        SliverList(
            delegate: SliverChildListDelegate([
          Container(
            margin: EdgeInsets.fromLTRB(18, 36, 0, 0),
            child: Column(
              children: [
                // Material(
                //   elevation: 0,
                //   type: MaterialType.canvas,
                //   borderOnForeground: false,
                //   child: Form(
                //     key: _formKey,
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         _buildName(),
                //         _buildTotalQuestion(),
                //         _buildTotalTime(),
                //         SizedBox(height: 500,),
                //         _createQuestionnaire(),
                //      ],
                //     ),
                //   ),
                // ),
                Container(
                  child: Row(children: [
                    Text(
                      "13 câu hỏi " + questionnaire.name.toLowerCase(),
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 3 / 10,
                            0,
                            0,
                            0),
                        child: IconButton(
                          onPressed: () {
                            print("qrewq");
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
                  child: Text("Đăng bởi user dd/mm/yy",
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
                  for (int i = 1; i <= rating; i++)
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                  for (int i = 1; i <= 5 - rating; i++)
                    Icon(
                      Icons.star,
                      color: Colors.grey,
                    )
                ]),
                Container(
                  child: Text(
                    "Đây là một đoạn mô tả dài !!!! Đây là một đoạn mô tả dài !!!! Đây là một đoạn mô tả dài !!!!",
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
                          questionnaire.totalQuestionInSession.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                  color: colorDebug ? Colors.green : null,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                )
              ],
            ),
          ),
        ]))
      ]),
      persistentFooterButtons: [
        //điểm cao nhất
        Container(
          margin: EdgeInsets.fromLTRB(
              0, 13, MediaQuery.of(context).size.width * 1 / 6, 22),
          color: colorDebug ? Colors.red[300] : null,
          width: MediaQuery.of(context).size.width * 2 / 3,
          child: Text(
            "Điểm cao nhất của bạn :",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        //nút bắt đầu ngay
        RaisedButton(
          onPressed: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.red[300],
            ),
            margin: EdgeInsets.fromLTRB(
                0, 13, MediaQuery.of(context).size.width * 1 / 8, 22),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 3 / 4,
            height: 51,
            child: Text("Bắt đầu ngay",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
