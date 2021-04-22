import 'package:baitaplon/models/Question.dart';
import 'package:flutter_test/flutter_test.dart';

class Result {
  int totalCorrectAnswer = 0;
  void answer(String answer, Question question) =>
      answer == question.correctAnswer ? this.totalCorrectAnswer++ : {};
}

void main() {
  testWidgets('GameScreen ...', (tester) async {
    Result result = Result();
    Question question1 = Question(correctAnswer: "1");
    Question question2 = Question(correctAnswer: "2");
    Question question3 = Question(correctAnswer: "3");
    result.answer("1", question1);
    result.answer("2", question2);
    result.answer("2", question3);
    expect(result.totalCorrectAnswer, 2);
    // TODO: Implement test
  });
}
