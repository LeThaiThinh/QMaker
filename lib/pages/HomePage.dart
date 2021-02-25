import 'package:baitaplon/classes/language.dart';
import 'package:baitaplon/localization/LocalizationConstant.dart';
import 'package:baitaplon/routes/RouteName.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  _changeLanguage(Language language) async {
    Locale _temp=await setLocale(language.languageCode);
    MyApp.setLocale(context,_temp);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawerList(),
      appBar: AppBar(
        title: Text(getTranslated(context, "homePage")),
        actions: [
          Padding(
            padding: EdgeInsets.all(8),
            child:DropdownButton(
              underline: SizedBox(),
              icon: Icon(
                Icons.language,
                color: Colors.white,
              ),
              items:
                Language.languageList().map<DropdownMenuItem<Language>>(
                        (lang)=>DropdownMenuItem(
                    value: lang,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(lang.flag),
                        Text(lang.name,style: TextStyle(fontSize: 30),),
                      ],
                    )
                  )
                ).toList(),
              onChanged: (Language language) {
                _changeLanguage(language);
              },
            ),
          )
        ],
      ),
      body:Container(
      ),
    );
  }

  Container _drawerList(){
    TextStyle _textStyle=TextStyle(
      color: Colors.white,
      fontSize: 24,
    );
    return Container(
      width: MediaQuery.of(context).size.width/1.5,
      color: Theme.of(context).primaryColor,
      child: ListView(
      children:[
        DrawerHeader(
          child: Container(
              height: 100,
              child: CircleAvatar(),
          ),
        ),
        ListTile(
          leading:Icon(
            Icons.info,
            color: Colors.white,
            size: 30,
        ),
          title: Text(
            'About Us',
            style: _textStyle,
          ),
          onTap: (){
            Navigator.pop(context);
            Navigator.pushNamed(context, aboutRoute);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
            color: Colors.white,
            size: 30,
          ),
          title: Text(
            'Setting',
            style: _textStyle,
          ),
          onTap: (){
            Navigator.pop(context);
            Navigator.pushNamed(context, settingRoute);
          },

        ),
        ListTile(
          leading: Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,
          ),
          title: Text(
            'Menu',
            style: _textStyle,
          ),
          onTap: (){
            Navigator.pop(context);
            Navigator.pushNamed(context, menuRoute);
          },

        ),
        ListTile(
          leading: Icon(
            Icons.login,
            color: Colors.white,
            size: 30,
          ),
          title: Text(
            'login',
            style: _textStyle,
          ),
          onTap: (){
            Navigator.pop(context);
            Navigator.pushNamed(context, loginRoute);
          },

        ),
      ],
      ),
    );
  }

}
