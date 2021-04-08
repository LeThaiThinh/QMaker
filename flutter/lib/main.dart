
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'constants/myColors.dart';
import 'constants/sharedData.dart';
import 'localization/DemoLocalization.dart';
import 'localization/LocalizationConstant.dart';
import 'routes/CustomRouter.dart';
import 'routes/RouteName.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_locale == null) {
      return Container(
        child: Center(child: CircularProgressIndicator()),
      );
    } else {
      return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: SharedData()),
          ],
          child: MaterialApp(
            theme: ThemeData(
              iconTheme: IconThemeData(
                color: primaryColor,
              ),
              primarySwatch: primarySwatchColor,
              primaryColor: primaryColor,
              appBarTheme: AppBarTheme(
                textTheme: TextTheme(
                  headline6: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
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
                if (locale.languageCode == deviceLocale.languageCode &&
                    locale.countryCode == deviceLocale.countryCode) {
                  return deviceLocale;
                }
              }
              return supportedLocales.first;
            },
            supportedLocales: [
              Locale('en', 'US'),
              Locale('vi', 'VN'),
              Locale('zh', 'CN'),
            ],
            onGenerateRoute: CustomRouter.allRoutes,
            initialRoute: loginRoute,
          ));
    }
  }
}
