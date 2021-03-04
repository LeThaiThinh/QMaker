import 'package:baitaplon/classes/Account.dart';
import 'package:baitaplon/classes/Questionnaire.dart';
import 'package:baitaplon/classes/QuestionnaireTemplate.dart';
import 'package:flutter/cupertino.dart';

class UserModel extends ChangeNotifier{
  Account account;
  List<Questionnaire> listQuestionnaire=[];
  List<QuestionnaireTemplate> listQuestionnaireTemplate=[];

  UserModel(this.account);
  changeAccount(Account account0){
    account=account0;
    notifyListeners();
  }
  changeListQuestionnaire(List<Questionnaire> questionnaire){
    listQuestionnaire=questionnaire;
    notifyListeners();

  }
  changeListQuestionnaireTemplate(List<QuestionnaireTemplate> questionnairesTemplate){
    listQuestionnaireTemplate=questionnairesTemplate;
    notifyListeners();

  }
  addListQuestionnaire(Questionnaire questionnaire){
    listQuestionnaire.add(questionnaire);
    notifyListeners();
  }
  addListQuestionnaireTemplate(QuestionnaireTemplate questionnaireTemplate){
    listQuestionnaireTemplate.add(questionnaireTemplate);
    notifyListeners();
  }
}
class Lo{
  final int x;
  int y;
  Lo(this.x, this.y);
}