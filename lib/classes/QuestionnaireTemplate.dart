import 'Question.dart';

class QuestionnaireTemplate{
  int totalQuestion;
  List<Question> listQuestion=[];
  bool isEditing;
  QuestionnaireTemplate(this.totalQuestion, this.listQuestion, this.isEditing);

  QuestionnaireTemplate.cop(QuestionnaireTemplate template){
    this.totalQuestion=template.totalQuestion;
    this.listQuestion=template.listQuestion;
    this.isEditing=template.isEditing;
  }
}