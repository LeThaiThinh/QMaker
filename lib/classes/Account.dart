import 'Questionnaire.dart';
import 'QuestionnaireTemplate.dart';

class Account{
  String name;
  String email;
  List<Questionnaire> listQuestionnaires=[];
  List<QuestionnaireTemplate> listQuestionnairesTemplate;
  List<Questionnaire> get getListQuestionnaires => listQuestionnaires;
  List<QuestionnaireTemplate> get getListQuestionnairesTemplate => listQuestionnairesTemplate;
  String get getName => name;
  String get getEmail => name;

  Account(this.name, this.email, this.listQuestionnaires, this.listQuestionnairesTemplate);
}