import 'package:baitaplon/page/ConfigurePage.dart';
import 'package:baitaplon/page/MainPage.dart';
import 'package:baitaplon/page/questionnaire/CreateQuestionPage.dart';
import 'package:baitaplon/page/questionnaire/CreateQuestionnairePage.dart';
import 'package:baitaplon/page/bottom/HomePage.dart';
import 'package:baitaplon/page/auth/LoginPage.dart';
import 'package:baitaplon/page/SettingPage.dart';
import 'package:baitaplon/page/questionnaire/EditQuestionnairePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'RouteName.dart';

class CustomRouter {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case mainRoute:
        return MaterialPageRoute(builder: (_) => MainPage());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case settingRoute:
        return MaterialPageRoute(builder: (_) => SettingPage());
      case configureRoute:
        return MaterialPageRoute(builder: (_) => ConfigurePage());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case createQuestionnaireRoute:
        return MaterialPageRoute(builder: (_) => CreateQuestionnairePage());
      case createQuestionRoute:
        return MaterialPageRoute(builder: (_) => CreateQuestionPage());
    }
  }
}
