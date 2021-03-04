import 'package:baitaplon/classes/Questionnaire.dart';
import 'package:baitaplon/models/User.dart';
import 'package:baitaplon/pages/HomePage.dart';
import 'package:baitaplon/routes/CustomRouter.dart';
import 'package:baitaplon/routes/RouteName.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'localization/DemoLocalization.dart';
import 'localization/LocalizationConstant.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context,Locale locale){
    _MyAppState state=context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Questionnaire> _listQuestionnaires;

  Locale _locale;
  void setLocale(Locale locale){
    setState(() {
      _locale=locale;
    });
  }
  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale=locale;
      });
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    if(_locale==null) {
      return Container(
        child: Center(
            child: CircularProgressIndicator()
        ),
      );
    }else
    {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserModel>.value(
              value: UserModel(null),
          )
        ],
        child: MaterialApp(
          //theme: ThemeData(primaryColor: Colors.green[500],),
          theme: ThemeData(primaryColor: Colors.green[500]),
          title: "hello",
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            DemoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: _locale,
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (locale.languageCode == deviceLocale.languageCode
                  && locale.countryCode == deviceLocale.countryCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
          supportedLocales: [
            Locale('en', 'US'),
            Locale('vi', 'VN'),
            Locale('zh','CN'),
          ],
          onGenerateRoute: CustomRouter.allRoutes,
          initialRoute: homeRoute,
        ),
      );
    }
  }
}

