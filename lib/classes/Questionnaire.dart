import 'package:baitaplon/classes/Question.dart';
import 'package:baitaplon/classes/QuestionnaireTemplate.dart';
import 'package:flutter/cupertino.dart';

class Questionnaire extends QuestionnaireTemplate {
  QuestionnaireTemplate questionnaireTemplate;

  Questionnaire(int totalQuestion, int totalTime, String name, List<Question> listQuestion) : super(totalQuestion, totalTime, name, listQuestion);
}
