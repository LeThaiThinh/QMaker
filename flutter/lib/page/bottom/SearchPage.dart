import 'package:baitaplon/constants/sharedData.dart';
import 'package:baitaplon/models/Questionnaire.dart';
import 'package:baitaplon/models/Users.dart';
import 'package:baitaplon/routes/RouteName.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  User user;

  @override
  Widget build(BuildContext context) {
    setState(() {
      user = Provider.of<SharedData>(context, listen: false).user;
    });
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: Stack(fit: StackFit.loose, children: [
          SizedBox(height: 10),
          collectionOfQuestionnaireSection(),
          SizedBox(height: 10),
          buildFloatingSearchBar(context),
        ]),
      ),
    );
  }

  Widget collectionOfQuestionnaireSection() {
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
              text: "Create by " + questionnaire.user.username + " ",
            ),
            TextSpan(
              text: questionnaire.createdAt.substring(0, 10),
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
          margin: EdgeInsets.only(top: 0, bottom: 10),
          width: 80,
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

    Widget questionnaireTile({Questionnaire questionnaire}) {
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
          SizedBox(
            height: 70,
          ),
          ...list.map((e) => questionnaireTile(questionnaire: e))
        ],
      );
    });
  }

  Widget buildFloatingSearchBar(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    List<Widget> children = [];

    // for (var i = 0; i < 10; i++) {
    //   if (i % 2 == 0) {
    //     children.add(Container(
    //       height: 100,
    //       color: Colors.white,
    //     ));
    //   } else {
    //     children.add(Container(
    //       height: 100,
    //       color: Colors.red[400],
    //     ));
    //   }
    // }

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      maxWidth: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),

      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // children: Colors.accents.map((color) {
              //   return Container(height: 100, color: color);
              // }).toList(),
              children: children,
            ),
          ),
        );
      },
    );
  }
}

// Widget article() {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Container(
//         // child: articleName(),
//         margin: EdgeInsets.only(top: 20, left: 20, bottom: 20),
//       ),
//       SizedBox(height: 10),
//       articleCard(),
//       SizedBox(height: 10),
//       articleCard(),
//       SizedBox(height: 10),
//       articleCard(),
//       SizedBox(height: 10),
//     ],
//   );
// }

// Widget articleCard() {
//   return Container(
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(10),
//       boxShadow: [
//         BoxShadow(
//             color: Colors.black.withOpacity(0.25),
//             spreadRadius: -20,
//             blurRadius: 4,
//             offset: Offset(
//               2,
//               2,
//             ))
//       ],
//     ),
//     child: Card(
//         margin: EdgeInsets.all(20),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//         ),
//         child: articleContent()), //noi dung recent post
//   );
// }

// Widget articleContent() {
//   return Column(
//     children: <Widget>[
//       ListTile(
//         contentPadding: EdgeInsets.all(10),
//         onTap: () {},
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(10.0),
//           ),
//         ),
//         title: Text.rich(buildTextSpanBox()),
//         subtitle: Text.rich(buildTextSubtitle()),
//         trailing: Column(
//           children: [
//             Container(
//               width: 50,
//               margin: EdgeInsets.only(top: 5, bottom: 10),
//               // height: 20,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.red,
//               ),
//               child: Text(
//                 "Math",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Color(0xffFFFFFF),
//                   fontWeight: FontWeight.w500,
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//             RatingBar.builder(
//               initialRating: 3,
//               minRating: 1,
//               direction: Axis.horizontal,
//               allowHalfRating: false,
//               itemSize: 20,
//               itemCount: 5,
//               itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
//               itemBuilder: (context, _) => Icon(
//                 Icons.star,
//                 color: Colors.amber,
//               ),
//               onRatingUpdate: (rating) {
//                 print(rating);
//               },
//             )
//           ],
//         ),
//       ),
//     ],
//   );
// }

// // Widget articleName() {
// //   return Column(
// //     crossAxisAlignment: CrossAxisAlignment.start,
// //     children: [
// //       Container(
// //         // margin: EdgeInsets.only(top: 20, left: 20, bottom: 20),
// //         child: Text(
// //           "Recent Quiz",
// //           style: TextStyle(
// //             fontSize: 28,
// //             color: Color(0xffeb5757),
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //       )
// //     ],
// //   );
// // }

// Widget card({Color color}) {
//   return Container(
//     margin: EdgeInsets.only(top: 20, left: 20, bottom: 20),
//     width: 100,
//     child: Align(
//       alignment: Alignment.center,
//       child: Text(
//         "Ung dung di dong",
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           color: Colors.red,
//           fontSize: 20,
//         ),
//       ),
//     ),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(10),
//       boxShadow: [
//         BoxShadow(
//             color: Colors.black.withOpacity(0.25),
//             // spreadRadius: 3,
//             blurRadius: 4,
//             // offset: Offset(0, 2),
//             offset: Offset(
//               2,
//               2,
//             ))
//       ],
//       color: color,
//     ),
//   );
// }

// TextSpan buildTextSpanBox() {
//   final double _fontsize = 20;
//   return TextSpan(
//     style: TextStyle(
//       color: Color(0xffEB5757),
//       fontWeight: FontWeight.w700,
//       fontSize: 20,
//     ),
//     children: [
//       TextSpan(text: "Ung dung di dong"),
//     ],
//   );
// }

// TextSpan buildTextSubtitle() {
//   final double _fontsize = 20;
//   return TextSpan(
//     style: TextStyle(
//       fontSize: 12,
//       color: Color(0xffC1C1C1),
//       fontWeight: FontWeight.w400,
//     ),
//     children: [
//       TextSpan(
//         text: "by unknown",
//       ),
//       TextSpan(
//         text: "     " + "24/1/2000",
//       ),
//       TextSpan(
//         text: "\nQuiz nay rat hay cac ban hay...",
//         style: TextStyle(
//           fontSize: 14,
//           color: Color(0xffA1A1A1),
//           fontWeight: FontWeight.w400,
//         ),
//       ),
//     ],
//   );
// }

class MyPage1widget {}
