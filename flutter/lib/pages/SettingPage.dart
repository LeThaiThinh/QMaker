import 'package:baitaplon/classes/language.dart';
import 'package:baitaplon/localization/LocalizationConstant.dart';
import 'package:baitaplon/routes/RouteName.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  _changeLanguage(Language language) async {
    Locale _temp=await setLocale(language.languageCode);
    MyApp.setLocale(context,_temp);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting Page'),

      ),
      body: Container(
        child: Column(
          children:[
              DropdownButton<Language>(
              hint: Text("Language"),
              // style: TextStyle(fontSize: 5),
              iconSize: 30,
              underline: SizedBox(),
              icon: Icon(
                Icons.language,
                color: Colors.green,
              ),
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                      (lang)=>DropdownMenuItem(
                      value: lang,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(lang.flag,style: TextStyle(fontSize: 20),),
                          Text(lang.name,style: TextStyle(fontSize: 20),),
                        ],
                      )
                  )
              ).toList(),
              onChanged: (Language language) {
                _changeLanguage(language);
                print(language);
              },
            ),
            MaterialButton(
              color: Colors.lightGreen,
              child: Text(getTranslated(context, "Navigator to setting page")),
              onPressed: (){
                Navigator.pushNamed(context, homeRoute);
              },
            ),
          ]
        ),
      ),
    );
  }
}
