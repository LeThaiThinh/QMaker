import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/localization/LocalizationConstant.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../constants/sharedData.dart';
import '../../models/Questionnaire.dart';
import '../../models/Users.dart';
import '../../routes/RouteName.dart';

class CollectionPage extends StatefulWidget {
  CollectionPage({Key key}) : super(key: key);

  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  SharedData sharedData;
  User user;

  @override
  Widget build(BuildContext context) {
    setState(() {
      user = Provider.of<SharedData>(context, listen: false).user;
    });
    fetchQuestionnaire(http.Client(), user.id, {"": ""}).then((value) async {
      await Provider.of<SharedData>(context, listen: false)
          .changeCollectionQuestionnaire(value);
    });
    return Scaffold(
      body: ListView(
        children: [
          collectionOfQuestionnaireSection(),
        ],
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
              text: questionnaire.createdAt.substring(0, 10) + " ",
            ),
            TextSpan(
              text: getTranslated(context, "created by") +
                  " " +
                  questionnaire.user.username,
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
          initialRating: double.parse(questionnaire.avgRating.toString()),
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
            key: Key("questionnaireTileCollection"),
            contentPadding: EdgeInsets.all(10),
            onTap: () {
              fetchQuestionnaireById(
                      http.Client(), questionnaire.userId, questionnaire.id)
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
            subtitle: Text.rich(
              belowName(),
              overflow: TextOverflow.ellipsis,
            ),
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
      List<Questionnaire> list = data.collection;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          ...list.map((e) => questionnaireTile(questionnaire: e))
        ],
      );
    });
  }
}
