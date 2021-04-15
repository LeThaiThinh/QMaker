import 'package:baitaplon/constants/sharedData.dart';
import 'package:baitaplon/models/Questionnaire.dart';
import 'package:baitaplon/routes/RouteName.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class QuestionnaireByTopicPage extends StatefulWidget {
  QuestionnaireByTopicPage({Key key, @required this.topic}) : super(key: key);
  final String topic;
  @override
  _QuestionnaireByTopicPageState createState() =>
      _QuestionnaireByTopicPageState();
}

class _QuestionnaireByTopicPageState extends State<QuestionnaireByTopicPage> {
  String topic;
  @override
  void initState() {
    topic = this.widget.topic;
    fetchQuestionnaire(
            http.Client(),
            Provider.of<SharedData>(context, listen: false).user.id,
            '?topic=$topic')
        .then((value) {
      Provider.of<SharedData>(context, listen: false)
          .changeQuestionnaireByTopic(value);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Topic Archive'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [title(), questionnaireByTopicSection()],
      ),
    );
  }

  Widget title() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text.rich(TextSpan(
              children: [
                TextSpan(
                  text: "Topic: " + this.widget.topic + "\n\n",
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xffeb5757),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: Provider.of<SharedData>(context)
                          .byTopic
                          .length
                          .toString() +
                      " results",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xff000000).withOpacity(0.6),
                    fontSize: 16,
                  ),
                )
              ],
            )),
          )
        ],
      ),
      margin: EdgeInsets.only(top: 20, left: 20, bottom: 0),
    );
  }

  Widget questionnaireByTopicSection() {
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
              text: "created by " + questionnaire.user.username,
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
            contentPadding: EdgeInsets.all(10),
            onTap: () {
              fetchQuestionnaireById(
                      http.Client(),
                      Provider.of<SharedData>(context, listen: false).user.id,
                      questionnaire.id)
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
            height: 20,
          ),
          ...list.map((e) => questionnaireTile(questionnaire: e))
        ],
      );
    });
  }
}
