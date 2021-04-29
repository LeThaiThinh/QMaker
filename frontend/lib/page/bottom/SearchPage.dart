import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/constants/sharedData.dart';
import 'package:frontend/models/History.dart';
import 'package:frontend/models/Questionnaire.dart';
import 'package:frontend/models/Users.dart';
import 'package:frontend/routes/RouteName.dart';
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
          initialRating: questionnaire.avgRating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          ignoreGestures: true,
          itemSize: 20,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {},
        );
      }

      return Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.all(10),
            onTap: () {
              createHistory(http.Client(), user.id, questionnaire.id)
                  .then((value) {
                fetchQuestionnaireById(
                        http.Client(), questionnaire.userId, questionnaire.id)
                    .then((value) {
                  Provider.of<SharedData>(context, listen: false)
                      .changeQuestionnaireIsChoosing(value);
                }).then((value) {
                  Navigator.of(context).pushNamed(configureRoute);
                });
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
      List<Questionnaire> list = data.search;
      return Column(
        key: Key("searchQuestionnaire"),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 70,
          ),
          if (list.isNotEmpty)
            ...list.map((e) => questionnaireTile(questionnaire: e))
        ],
      );
    });
  }

  Widget buildFloatingSearchBar(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    List<Widget> children = [];

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      clearQueryOnClose: false,
      onQueryChanged: (query) {
        if (query != "")
          fetchQuestionnaire(
                  http.Client(),
                  Provider.of<SharedData>(context, listen: false).user.id,
                  {'name':query})
              .then((value) {
            Provider.of<SharedData>(context, listen: false)
                .changeQuestionnaireSearch(value);
          });
        else
          Provider.of<SharedData>(context, listen: false)
              .changeQuestionnaireSearch([]);
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          key: Key('search'),
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
          key: Key("space"),
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
