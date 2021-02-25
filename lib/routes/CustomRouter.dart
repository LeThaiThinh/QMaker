import 'package:baitaplon/pages/AboutPage.dart';
import 'package:baitaplon/pages/HomePage.dart';
import 'package:baitaplon/pages/LoginPage.dart';
import 'package:baitaplon/pages/MenuPage.dart';
import 'package:baitaplon/pages/NotFoundPage.dart';
import 'package:baitaplon/pages/SettingPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'RouteName.dart';

class CustomRouter{
  static Route<dynamic> allRoutes(RouteSettings settings){
    switch(settings.name){
      case homeRoute:
        return MaterialPageRoute(builder: (_)=>HomePage());
      case aboutRoute:
        return MaterialPageRoute(builder: (_)=>AboutPage());
      case settingRoute:
        return MaterialPageRoute(builder: (_)=>SettingPage());
      case menuRoute:
        return MaterialPageRoute(builder: (_)=>MenuPage());
      case loginRoute:
        return MaterialPageRoute(builder: (_)=>LoginPage());
    }
    return MaterialPageRoute(builder: (_)=>NotFoundPage());
  }
}