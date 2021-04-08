import 'package:baitaplon/constants/bottomType.dart';
import 'package:baitaplon/models/Question.dart';
import 'package:baitaplon/models/Questionnaire.dart';
import 'package:baitaplon/models/Users.dart';
import 'package:flutter/cupertino.dart';

class SharedData extends ChangeNotifier {
  List<Questionnaire> recentlyUsed = [];
  List<Questionnaire> byTopic = [];
  List<Map> topic = [];
  Questionnaire questionnaireIsChoosing;
  User user = new User();
  BottomType currentMainPage;
  changeQuestionnaireCurrentlyUsed(List<Questionnaire> currentlyUsed) {
    this.recentlyUsed = currentlyUsed;
    notifyListeners();
  }

  changeQuestionnaireByTopic(List<Questionnaire> byTopic) {
    this.byTopic = byTopic;
    notifyListeners();
  }

  changeQuestionnaireTopic(List<Map> topic) {
    this.topic = topic;
    notifyListeners();
  }

  changeUser(User user) {
    this.user = user;
    notifyListeners();
  }

  changeQuestionnaireIsChoosing(Questionnaire questionnaireIsChoosing) {
    this.questionnaireIsChoosing = questionnaireIsChoosing;
    notifyListeners();
  }

  changeListQuestionInChosenQuestionnaire(List<Question> list) {
    this.questionnaireIsChoosing.listQuestion = list;
    notifyListeners();
  }

  changeCurrentMainPage(BottomType bottomType) {
    currentMainPage = bottomType;
  }
}
