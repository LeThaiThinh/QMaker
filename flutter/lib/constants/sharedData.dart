import 'package:baitaplon/models/Questionnaire.dart';
import 'package:baitaplon/models/Users.dart';
import 'package:flutter/cupertino.dart';

class SharedData extends ChangeNotifier {
  List<Questionnaire> currentlyUsed = [];
  List<Questionnaire> byTopic = [];
  List<Map> topic = [];
  Questionnaire questionnaireIsChoosing;
  int numberOfQuestion;
  User user = new User();
  changeQuestionnaireCurrentlyUsed(List<Questionnaire> currentlyUsed) {
    this.currentlyUsed = currentlyUsed;
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

  changeQuestionnaireIsChoosing(Questionnaire questionnaireIsPlaying) {
    this.questionnaireIsChoosing = questionnaireIsPlaying;
    notifyListeners();
  }

  changeNumberOfQuestion(int num) {
    this.numberOfQuestion = num;
    notifyListeners();
  }

  increaseNumberOfQuestion() {
    this.numberOfQuestion++;
    notifyListeners();
  }
}
