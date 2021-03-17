import 'package:baitaplon/models/Questionnaire.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

// // ignore: must_be_immutable
// class PlayExamPage extends StatefulWidget {
//   Questionnaire questionnaire;
//   PlayExamPage({Key key, @required this.questionnaire}) : super(key: key);

//   @override
//   _PlayExamPageState createState() => _PlayExamPageState(questionnaire);
// }

// class _PlayExamPageState extends State<PlayExamPage> {
//   Questionnaire questionnaire;

//   _PlayExamPageState(this.questionnaire);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(),
//         body: ScrollSnapList(
//           onItemFocus: (int i) {},
//           scrollDirection: Axis.horizontal,
//           itemCount: 0,
//           itemSize: MediaQuery.of(context).size.width * 3 / 4,
//           itemBuilder: (context, index) {
//             return Column(
//               children: [],
//             );
//           },
//         ));
//   }
// }
