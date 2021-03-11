import 'QuestionnaireTemplate.dart';

class Account{
  String name;
  String email;
  List<QuestionnaireTemplate> listQuestionnaires=[];
  List<QuestionnaireTemplate> listQuestionnairesTemplate;
  List<QuestionnaireTemplate> get getListQuestionnaires => listQuestionnaires;
  List<QuestionnaireTemplate> get getListQuestionnairesTemplate => listQuestionnairesTemplate;
  String get getName => name;
  String get getEmail => name;

  Account(this.name, this.email, this.listQuestionnaires, this.listQuestionnairesTemplate);
}