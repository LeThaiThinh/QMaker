import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/bottomType.dart';
import '../page/MainPage.dart';
import '../page/SettingPage.dart';
import '../page/auth/LoginPage.dart';
import '../page/bottom/HomePage.dart';
import '../page/questionnaire/CreateQuestionnairePage.dart';
import '../page/questionnaire/QuestionnairePage.dart';
import '../page/questionnaire/question/CreateQuestionPage.dart';
import 'RouteName.dart';

class CustomRouter {
  // ignore: missing_return
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case mainRoute:
        return MaterialPageRoute(
            builder: (_) => MainPage(
                  initBody: BottomType.home,
                ));
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case settingRoute:
        return MaterialPageRoute(builder: (_) => SettingPage());
      case configureRoute:
        return MaterialPageRoute(builder: (_) => QuestionnairePage());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case createQuestionnaireRoute:
        return MaterialPageRoute(builder: (_) => CreateQuestionnairePage());
      case createQuestionRoute:
        return MaterialPageRoute(builder: (_) => CreateQuestionPage());
    }
  }
}
