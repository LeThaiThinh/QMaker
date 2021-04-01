// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:quiz_app/layouts/MainPage.dart';
// import 'package:quiz_app/layouts/ingame/GameScreen.dart';
// import 'package:quiz_app/models/Questionnaire.dart';
// import 'package:quiz_app/utils/bottomType.dart';

// class ResultPage extends StatefulWidget {
//   ResultPage({
//     Key key,
//     @required this.questionnaire,
//     @required this.timeFinish,
//     @required this.score,
//   }) : super(key: key);

//   final Questionnaire questionnaire;
//   final int timeFinish;
//   final int score;

//   @override
//   _ResultPageState createState() => _ResultPageState();
// }

// class _ResultPageState extends State<ResultPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xfff2994a),
//       body: Container(
//         padding: EdgeInsets.only(
//           left: 20,
//           right: 20,
//           top: MediaQuery.of(context).size.height / 6,
//         ),
//         child: Column(
//           children: [
//             Center(
//               child: Text(
//                 "Your Score:",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Center(
//               child: Text(
//                 this.widget.score.toString(),
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 80,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Center(
//               child: Text(
//                 "Time Finish: ${this.widget.timeFinish} seconds",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 22,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 6),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => GameScreen(questionnaire: this.widget.questionnaire),
//                       ),
//                     );
//                   },
//                   child: Icon(
//                     Icons.replay,
//                     size: 50,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(width: 50),
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => MainPage(initBody: BottomType.home),
//                       ),
//                     );
//                   },
//                   child: Icon(
//                     Icons.home,
//                     size: 50,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 12),
//             Text(
//               "Rate now:",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 20),
//             RatingBar.builder(
//               initialRating: 0,
//               minRating: 1,
//               itemCount: 5,
//               itemBuilder: (context, _) => Icon(
//                 Icons.star,
//                 color: Color(0xfff2c946),
//               ),
//               onRatingUpdate: (value) {},
//               itemSize: 50.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
