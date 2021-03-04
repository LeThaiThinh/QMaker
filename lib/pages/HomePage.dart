import 'dart:math';
import 'dart:ui';

import 'package:baitaplon/classes/Question.dart';
import 'package:baitaplon/classes/Questionnaire.dart';
import 'package:baitaplon/classes/QuestionnaireTemplate.dart';
import 'package:baitaplon/classes/language.dart';
import 'package:baitaplon/localization/LocalizationConstant.dart';
import 'package:baitaplon/models/User.dart';
import 'package:baitaplon/routes/RouteName.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final UserModel userModel=Provider.of<UserModel>(context);
    final tabs = [
      getTranslated(context, "Questionnaires"),
      getTranslated(context, "Creations"),
      getTranslated(context, "Something"),
    ];
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: _drawerList(),
          appBar: AppBar(
            bottom: TabBar(tabs: [for (final tab in tabs)Tab(text: tab,)],),
            title: Text(getTranslated(context, "Home Page")),
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
                    print(language);
                  },
                ),
              )
            ],
          ),
          body:TabBarView(
            children: [
              Text("s"),
              _questionnairesList(userModel),
              Text("s"),
            ],
          ),
        ),
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
      // color: Theme.of(context).primaryColor,
      child: ListView(
        children:[
          DrawerHeader(
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 130, 0),
                child: Column(
                  children: [
                    Flexible(flex:5,child:CircleAvatar(backgroundColor: Colors.grey,radius: 100,)),
                    Flexible(
                        flex:1,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed:  (){
                                // Navigator.pop(context);
                                Navigator.pushNamed(context, loginRoute);
                              },
                              iconSize: 10,
                            ),
                            Text("data",style: TextStyle(backgroundColor: Colors.red),),
                          ],
                        )),
                  ],
                ),
            ),
          ),
          Title(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15,0,0,0),
                child: Text(getTranslated(context, "Questionnaires"),style: TextStyle(color: Color.fromRGBO(100, 8, 8, 0.6),),),
              )),
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
          Title(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15,0,0,0),
                child: Text(getTranslated(context, "Something"),style: TextStyle(color: Color.fromRGBO(100, 8, 8, 0.6),),),
              )),
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
              Navigator.pushNamed(context, loginRoute);
            },

          ),
        ],
        ),

      );
  }

  Scaffold _questionnairesList(UserModel userModel){
    String defaultName="Template";
    int defaultTotalTime=300;
    int defaultTotalQuestion=0;
    return Scaffold(
      body: GridView.builder(
        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0
        ),
        itemCount: userModel.listQuestionnaireTemplate.length,
        itemBuilder: (BuildContext context,index){
          return RaisedButton(
            onPressed: (){
              Navigator.pushNamed(context, configureRoute);
            },
            child: Column(
              children:[
                Icon(Icons.info),
                Text(userModel.listQuestionnaireTemplate[index].name),
                Text(userModel.listQuestionnaireTemplate[index].totalQuestion.toString()),
                Text(userModel.listQuestionnaireTemplate[index].totalTime.toString()),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Provider.of<UserModel>(context,listen: false).addListQuestionnaireTemplate(new QuestionnaireTemplate(defaultTotalQuestion,defaultTotalTime,defaultName,[]));
        },
      ),
    );
  }
}
