import 'package:baitaplon/models/Question.dart';
import 'package:flutter_test/flutter_test.dart';

class Result {
  List<Question> list = [];
  int totalCorrectAnswer;

  void addQuestion() => list.add(Question());
  void setTotalCorrectAnswer(int n) => totalCorrectAnswer = n;
  double score() => totalCorrectAnswer / list.length * 100;
}

void main() {
  testWidgets('score calculate ...', (tester) async {
    Result result = Result();
    result.addQuestion();
    result.addQuestion();
    result.addQuestion();
    result.setTotalCorrectAnswer(2);
    expect(result.score(), 2 / 3 * 100);
  });
}
