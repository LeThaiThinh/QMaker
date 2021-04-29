import 'package:flutter/cupertino.dart';
import 'package:frontend/classes/language.dart';
import 'package:frontend/constants/bottomType.dart';
import 'package:frontend/models/Question.dart';
import 'package:frontend/models/Questionnaire.dart';
import 'package:frontend/models/Users.dart';

class SharedData extends ChangeNotifier {
  List<Questionnaire> collection = [];
  List<Questionnaire> recentlyUsed = [];
  List<Questionnaire> byTopic = [];
  List<Questionnaire> search = [];
  List<Map> topic = [];
  Questionnaire questionnaireIsChoosing;
  User user = new User();
  BottomType currentMainPage;
  Language language = Language(1, '🇺🇸', 'English', 'en');

  changeLanguage(Language language) {
    this.language = language;
    notifyListeners();
  }

  changeCollectionQuestionnaire(List<Questionnaire> collection) {
    this.collection = collection;
    notifyListeners();
  }

  changeQuestionnaireCurrentlyUsed(List<Questionnaire> currentlyUsed) {
    this.recentlyUsed = currentlyUsed;
    notifyListeners();
  }

  changeQuestionnaireByTopic(List<Questionnaire> byTopic) {
    this.byTopic = byTopic;
    notifyListeners();
  }

  changeQuestionnaireSearch(List<Questionnaire> search) {
    this.search = search;
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