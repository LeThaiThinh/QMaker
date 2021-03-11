import 'package:baitaplon/classes/QuestionnaireTemplate.dart';

class Questionnaire {
  QuestionnaireTemplate questionnaireTemplate;
  String name;
  int totalQuestionInSession;
  int totalTime;

  Questionnaire(this.questionnaireTemplate, this.name,
      this.totalQuestionInSession, this.totalTime);
  Questionnaire.cop(Questionnaire questionnaire) {
    this.totalQuestionInSession = questionnaire.totalQuestionInSession;
    this.questionnaireTemplate = questionnaire.questionnaireTemplate;
    this.name = questionnaire.name;
    this.questionnaireTemplate = questionnaire.questionnaireTemplate;
  }
}
