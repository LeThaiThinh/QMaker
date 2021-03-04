import 'Question.dart';

class QuestionnaireTemplate{
  int totalQuestion;
  int totalTime;
  String name;
  List<Question> listQuestion=[];

  QuestionnaireTemplate(
      this.totalQuestion, this.totalTime, this.name, this.listQuestion);
}