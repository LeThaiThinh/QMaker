// import 'dart:async';

// import 'package:baitaplon/models/Question.dart';
// import 'package:baitaplon/models/Questionnaire.dart';
// import 'package:flutter/material.dart';

// class GameScreen extends StatefulWidget {
//   GameScreen({
//     Key key,
//     @required this.questionnaire,
//   }) : super(key: key);

//   final Questionnaire questionnaire;

//   @override
//   _GameScreenState createState() => _GameScreenState();
// }

// class _GameScreenState extends State<GameScreen> {
//   Timer timer;
//   int start;
//   int questionIndex;
//   int score;

//   List<Question> questionList = [
//     Question(name: "1 + 1 = ?", trueAns: "2", falseAns1: "0", falseAns2: "1", falseAns3: "3"),
//     Question(name: "2 + 2 = ?", trueAns: "4", falseAns1: "2", falseAns2: "8", falseAns3: "10"),
//     Question(name: "4 + 1 = ?", trueAns: "5", falseAns1: "3", falseAns2: "7", falseAns3: "11"),
//   ];

//   @override
//   void initState() {
//     super.initState();

//     score = 0;
//     questionIndex = 0;
//     questionList.shuffle();

//     start = this.widget.questionnaire.timeLimit * 60; // minutes to seconds

//     const duration = Duration(seconds: 1);
//     timer = Timer.periodic(duration, (timer) {
//       if (start == 0) {
//         setState(() {
//           timer.cancel();
//         });
//         Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ResultPage(
//                 questionnaire: this.widget.questionnaire,
//                 score: score,
//                 timeFinish: this.widget.questionnaire.timeLimit * 60,
//               ),
//             ),
//             (route) => false);
//       } else {
//         setState(() {
//           start--;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     timer.cancel();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryColor,
//       appBar: appBar(),
//       // body: body(),
//       body: Stage(
//         stageNumber: questionIndex + 1,
//         question: questionList.elementAt(questionIndex),
//         nextStage: (String answer) {
//           if (answer == questionList.elementAt(questionIndex).trueAns) score++;

//           if (questionIndex + 1 == questionList.length) {
//             Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ResultPage(
//                     questionnaire: this.widget.questionnaire,
//                     score: score,
//                     timeFinish: this.widget.questionnaire.timeLimit * 60 - start,
//                   ),
//                 ),
//                 (route) => false);
//           } else {
//             setState(() {
//               questionIndex++;
//             });
//           }
//         },
//       ),
//     );
//   }

//   Widget appBar() {
//     return AppBar(
//       elevation: 0,
//       leading: InkWell(
//         child: Padding(
//           padding: EdgeInsets.only(left: 20.0),
//           child: RotatedBox(
//             quarterTurns: 2,
//             child: Icon(
//               Icons.exit_to_app_rounded,
//               size: 40,
//             ),
//           ),
//         ),
//         onTap: () {
//           showDialog(context: context, builder: (context) => exitDialog());
//         },
//       ),
//       actions: [countdown()],
//     );
//   }

//   Widget exitDialog() {
//     return AlertDialog(
//       title: Text("Are you sure?"),
//       content: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // ignore: deprecated_member_use
//           FlatButton(
//             onPressed: () {
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => SingleQuestionnaire(questionnaire: this.widget.questionnaire),
//                 ),
//                 (route) => false,
//               );
//             },
//             child: Text("YES"),
//             textColor: Colors.white,
//             color: Colors.green,
//           ),
//           // ignore: deprecated_member_use
//           FlatButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text("NO"),
//             textColor: Colors.white,
//             color: Colors.red,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget countdown() {
//     return Row(
//       children: [
//         InkWell(
//           child: Icon(Icons.timer, size: 35),
//           onTap: () {},
//         ),
//         SizedBox(width: 10),
//         Text(
//           "${start.toString()} s",
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         SizedBox(width: 20),
//       ],
//     );
//   }
// }
