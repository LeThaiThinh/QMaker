import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DemoLocalization.dart';

String getTranslated(BuildContext context,String key){
  return DemoLocalizations.of(context).getTranslatedValue(key);
}
//
const String ENGLISH='en';
const String VIETNAM='vi';
const String CHINA='zh';

const String LANGUAGE_CODE='languageCode';
Future<Locale> setLocale(String languageCode) async{
  SharedPreferences preferences=await SharedPreferences.getInstance();
  await preferences.setString(LANGUAGE_CODE, languageCode);
  return _locale(languageCode);
}
Locale _locale(String languageCode) {
  Locale _temp;
  switch (languageCode) {
    case ENGLISH:
      _temp = Locale(languageCode, 'US');
      break;
    case VIETNAM:
      _temp = Locale(languageCode, 'VN');
      break;
    case CHINA:
      _temp = Locale(languageCode, 'CN');
      break;
    default:
      _temp = Locale(languageCode, 'US');
  }
  return _temp;
}

Future<Locale> getLocale() async{
  SharedPreferences preferences=await SharedPreferences.getInstance();
  String languageCode = preferences.getString(LANGUAGE_CODE)??ENGLISH;
  return _locale(languageCode);
}
