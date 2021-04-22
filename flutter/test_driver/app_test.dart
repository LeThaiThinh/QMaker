import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Quiz App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    String numTest = "16";
    test('Signup', () async {
      final signupButtonLogin = find.byValueKey("signupButtonLogin");
      final nameSignup = find.byValueKey('nameSignup');
      final usernameSignup = find.byValueKey('usernameSignup');
      final passwordSignup = find.byValueKey('passwordSignup');
      final signup = find.byValueKey('signup');
      final appBarHome = find.byValueKey('appBarHome');
      await driver.tap(signupButtonLogin, timeout: Duration(seconds: 1));
      await driver.tap(nameSignup, timeout: Duration(seconds: 1));
      await driver.enterText("name" + numTest, timeout: Duration(seconds: 1));
      await driver.tap(usernameSignup, timeout: Duration(seconds: 1));
      await driver.enterText("username" + numTest,
          timeout: Duration(seconds: 1));
      await driver.tap(passwordSignup, timeout: Duration(seconds: 1));
      await driver.enterText("password" + numTest,
          timeout: Duration(seconds: 1));
      await driver.tap(signup, timeout: Duration(seconds: 1));
      expect(await driver.getText(appBarHome), "Home");
    });
    test('Go to create Questionnaire', () async {
      final titleCreateQuestionnaire =
          find.byValueKey("titleCreateQuestionnaire");
      final addQuestionnaire = find.byValueKey("addQuestionnaire");
      await driver.tap(addQuestionnaire, timeout: Duration(seconds: 1));
      expect(
          await driver.getText(titleCreateQuestionnaire,
              timeout: Duration(seconds: 1)),
          "New Questionaire");
    });
    test('Create Questionnaire', () async {
      final nameCreateQuestionnaire =
          find.byValueKey("nameCreateQuestionnaire");
      final topicreateQuestionnaire =
          find.byValueKey('topicCreateQuestionnaire');
      final timeLimitCreateQuestionnaire =
          find.byValueKey('timeLimitCreateQuestionnaire');
      // final privateCreateQuestionnaire =
      //     find.byValueKey('privateCreateQuestionnaire');
      final desCreateQuestionnaire = find.byValueKey('desCreateQuestionnaire');
      final createQuestionnaire = find.byValueKey('createQuestionnaire');
      await driver.tap(nameCreateQuestionnaire, timeout: Duration(seconds: 1));
      await driver.enterText("name" + numTest, timeout: Duration(seconds: 1));
      await driver.tap(topicreateQuestionnaire, timeout: Duration(seconds: 1));
      await driver.enterText("topic" + numTest, timeout: Duration(seconds: 1));
      await driver.tap(desCreateQuestionnaire, timeout: Duration(seconds: 1));
      await driver.enterText("des" + numTest, timeout: Duration(seconds: 1));
      // await driver.tap(privateCreateQuestionnaire,
      //     timeout: Duration(seconds: 1));
      await driver.tap(timeLimitCreateQuestionnaire,
          timeout: Duration(seconds: 1));
      await driver.enterText("1" + numTest, timeout: Duration(seconds: 1));
      await driver.tap(createQuestionnaire, timeout: Duration(seconds: 1));
    });
    test('Go to add Question', () async {
      final titleCreateQuestion = find.byValueKey("titleCreateQuestion");
      final goToAddQuestionnaire = find.byValueKey('goToAddQuestionnaire');
      await driver.tap(goToAddQuestionnaire, timeout: Duration(seconds: 1));
      expect(
          await driver.getText(titleCreateQuestion,
              timeout: Duration(seconds: 1)),
          "New Question");
    });
    test('Create Question', () async {
      final questionCreateQuestion = find.byValueKey("questionCreateQuestion");
      final correctAnswerCreateQuestion =
          find.byValueKey('correctAnswerCreateQuestion');
      final incorrectAnswerCreateQuestion1 =
          find.byValueKey('incorrectAnswerCreateQuestion1');
      final incorrectAnswerCreateQuestion2 =
          find.byValueKey('incorrectAnswerCreateQuestion2');
      final incorrectAnswerCreateQuestion3 =
          find.byValueKey('incorrectAnswerCreateQuestion3');
      final createQuestion = find.byValueKey('createQuestion');
      final questionTileText = find.byValueKey('questionTileText');
      await driver.tap(questionCreateQuestion, timeout: Duration(seconds: 1));
      await driver.enterText("question" + numTest,
          timeout: Duration(seconds: 1));
      await driver.tap(correctAnswerCreateQuestion,
          timeout: Duration(seconds: 1));
      await driver.enterText("correctAnswer" + numTest,
          timeout: Duration(seconds: 1));
      await driver.tap(incorrectAnswerCreateQuestion1,
          timeout: Duration(seconds: 1));
      await driver.enterText("incorrectAnswer1" + numTest,
          timeout: Duration(seconds: 1));
      await driver.tap(incorrectAnswerCreateQuestion2,
          timeout: Duration(seconds: 1));
      await driver.enterText("incorrectAnswer2" + numTest,
          timeout: Duration(seconds: 1));
      await driver.tap(incorrectAnswerCreateQuestion3,
          timeout: Duration(seconds: 1));
      await driver.enterText("incorrectAnswer3" + numTest,
          timeout: Duration(seconds: 1));
      await driver.tap(createQuestion, timeout: Duration(seconds: 1));
      expect(await driver.getText(questionTileText), "question" + numTest);
    });
    test('Edit Question', () async {
      final questionEditQuestion = find.byValueKey("questionEditQuestion");
      final questionTile = find.byValueKey("questionTile");
      final updateQuestion = find.byValueKey("updateQuestion");
      final questionTileText = find.byValueKey('questionTileText');
      await driver.tap(questionTile, timeout: Duration(seconds: 1));
      await driver.tap(questionEditQuestion, timeout: Duration(seconds: 1));
      await driver.enterText("newQuestion" + numTest,
          timeout: Duration(seconds: 1));
      await driver.tap(updateQuestion, timeout: Duration(seconds: 1));
      expect(await driver.getText(questionTileText), "newQuestion" + numTest);
    });
    test('Play Questionnaire with correct answer', () async {
      final backToQuestionnaire = find.byValueKey("backToQuestionnaire");
      final startQuestionnaire = find.byValueKey('startQuestionnaire');
      final correctAnswerTile = find.byValueKey('correctAnswerTile');
      final score = find.byValueKey("score");
      await driver.tap(backToQuestionnaire, timeout: Duration(seconds: 1));
      await driver.tap(startQuestionnaire, timeout: Duration(seconds: 1));
      await driver.tap(correctAnswerTile, timeout: Duration(seconds: 1));
      expect(await driver.getText(score), "100");
    });
    test('Play Questionnaire again with incorrect answer', () async {
      final playAgain = find.byValueKey("playAgain");
      final incorrectAnswerTile1 = find.byValueKey('incorrectAnswerTile1');
      final score = find.byValueKey("score");
      await driver.tap(playAgain, timeout: Duration(seconds: 1));
      await driver.tap(incorrectAnswerTile1, timeout: Duration(seconds: 1));
      expect(await driver.getText(score), "0");
    });
    test('Back to home and check new Questionnaire', () async {
      final backToHomeFromResultPage =
          find.byValueKey("backToHomeFromResultPage");
      final topicOfQuestionnaire = find.byValueKey('topicOfQuestionnaire');
      await driver.tap(backToHomeFromResultPage, timeout: Duration(seconds: 1));
      expect(await driver.getText(topicOfQuestionnaire), "topic" + numTest);
    });
    test('Search Questionnaire', () async {
      final bottomNavigationBar = find.byTooltip("search");
      final floatingSearchBar = find.text('Search...');
      await driver.tap(bottomNavigationBar, timeout: Duration(seconds: 1));
      await driver.tap(floatingSearchBar, timeout: Duration(seconds: 2));
      await driver.enterText("name" + numTest, timeout: Duration(seconds: 1));
      await driver.tap(bottomNavigationBar, timeout: Duration(seconds: 2));
      expect(find.text('name' + numTest), isNotNull);
    });
    test("Check profile's user", () async {
      final bottomNavigationBar = find.byTooltip("profile");
      final nameOfUserProfile = find.byValueKey("nameOfUserProfile");
      await driver.tap(bottomNavigationBar, timeout: Duration(seconds: 1));
      expect(
          await driver.getText(nameOfUserProfile,
              timeout: Duration(seconds: 1)),
          "Hello name" + numTest);
    });
    test("Change Language app", () async {
      final language = find.byValueKey("language");
      final vietnamese = find.text("Vietnamese");
      final nameOfUserProfile = find.byValueKey("nameOfUserProfile");
      await driver.tap(language, timeout: Duration(seconds: 1));
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(vietnamese, timeout: Duration(seconds: 1));
      await Future.delayed(Duration(seconds: 2));
      expect(
          await driver.getText(nameOfUserProfile,
              timeout: Duration(seconds: 1)),
          "Xin chào name" + numTest);
    });
    test("Change Password", () async {
      final goToChangePass = find.byValueKey("goToChangePass");
      final currentPassInput = find.byValueKey("currentPassInput");
      final newPassInput = find.byValueKey("newPassInput");
      final retypeNewPassInput = find.byValueKey('retypeNewPassInput');
      final updatePass = find.byValueKey('updatePass');
      await driver.tap(goToChangePass, timeout: Duration(seconds: 1));
      await driver.tap(currentPassInput, timeout: Duration(seconds: 1));
      await driver.enterText("password" + numTest,
          timeout: Duration(seconds: 1));
      await driver.tap(newPassInput, timeout: Duration(seconds: 1));
      await driver.enterText("newPassword" + numTest,
          timeout: Duration(seconds: 1));
      await driver.tap(retypeNewPassInput, timeout: Duration(seconds: 1));
      await driver.enterText("newPassword" + numTest,
          timeout: Duration(seconds: 1));
      await driver.tap(updatePass);
    });
    test("Delete Question", () async {
      final bottomNavigationBar = find.byTooltip("collection");
      final questionnaireTileCollection =
          find.byValueKey("questionnaireTileCollection");
      final goToEditQuestionnaire = find.byValueKey("goToEditQuestionnaire");
      final questionTile = find.byValueKey("questionTile");
      final deleteQuestion = find.byValueKey("deleteQuestion");
      await driver.tap(bottomNavigationBar, timeout: Duration(seconds: 1));
      await driver.tap(questionnaireTileCollection,
          timeout: Duration(seconds: 1));
      await driver.tap(goToEditQuestionnaire, timeout: Duration(seconds: 1));
      await driver.tap(questionTile, timeout: Duration(seconds: 1));
      await driver.tap(deleteQuestion, timeout: Duration(seconds: 1));
    });
    test("Delete Questionnaire", () async {
      final deleteQuestionnaire = find.byValueKey("deleteQuestionnaire");
      await driver.tap(deleteQuestionnaire, timeout: Duration(seconds: 1));
    });
    test("Logout", () async {
      final logout = find.byValueKey("logout");
      await driver.tap(logout, timeout: Duration(seconds: 1));
    });
    test('Login with new password', () async {
      final usernameLogin = find.byValueKey('usernameLogin');
      final passwordLogin = find.byValueKey('passwordLogin');
      final login = find.byValueKey('login');
      final appBarHome = find.byValueKey('appBarHome');
      await driver.tap(usernameLogin, timeout: Duration(seconds: 1));
      await driver.enterText("username" + numTest,
          timeout: Duration(seconds: 1));
      await driver.tap(passwordLogin, timeout: Duration(seconds: 1));
      await driver.enterText("newpassword" + numTest,
          timeout: Duration(seconds: 1));
      await driver.tap(login, timeout: Duration(seconds: 1));
      expect(await driver.getText(appBarHome), "Home");
    });
  });
}
