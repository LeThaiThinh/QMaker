import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/classes/language.dart';
import 'package:frontend/constants/myColors.dart';
import 'package:frontend/constants/sharedData.dart';
import 'package:frontend/localization/LocalizationConstant.dart';
import 'package:frontend/main.dart';
import 'package:frontend/page/auth/ChangePassPage.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  _changeLanguage(Language language) async {
    Locale _temp = await setLocale2(language.languageCode);
    MyApp.setLocale(context, _temp);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20.0),
      children: [
        avatar(),
        SizedBox(height: 20),
        userName(),
        SizedBox(height: 40),
        changePassBtn(),
        SizedBox(height: 40),
        changeLanguage(),
      ],
    );
  }

  Widget avatar() {
    return Align(
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey[300]),
          shape: BoxShape.circle,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(1000.0),
          child: SvgPicture.asset("assets/logo.svg"),
        ),
      ),
    );
  }

  Widget userName() {
    String nameOfUser =
        Provider.of<SharedData>(context, listen: false).user.name;
    return Align(
      child: Text(
        getTranslated(context, 'Hello') + " " + nameOfUser.toString(),
        style: TextStyle(
          fontSize: 30,
          color: primaryColor,
          fontWeight: FontWeight.bold,
        ),
        key: Key("nameOfUserProfile"),
      ),
    );
  }

  Widget changePassBtn() {
    return Card(
      child: ListTile(
        key: Key("goToChangePass"),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => ChangePassPage()));
        },
        trailing: Icon(Icons.lock, color: primaryColor),
        title: Text(
          getTranslated(context, "Change Password"),
          style: TextStyle(
            color: primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget changeLanguage() {
    return Consumer<SharedData>(
      builder: (context, data, child) => Card(
        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: DropdownButton<Language>(
          key: Key("language"),
          hint: Text(
            "  " +
                getTranslated(context, data.language.flag) +
                "                                                  ",
            style: TextStyle(
              fontSize: 18,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          iconSize: 30,
          underline: SizedBox(),
          icon: Icon(
            
            Icons.language,
            color: primaryColor,
          ),
          items:
              Language.languageList().map<DropdownMenuItem<Language>>((lang) {
            return DropdownMenuItem(
                value: lang,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      getTranslated(context, lang.flag),
                      style: TextStyle(
                        fontSize: 18,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      lang.name,
                      style: TextStyle(
                        fontSize: 18,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ));
          }).toList(),
          onChanged: (Language _language) {
            Provider.of<SharedData>(context, listen: false)
                .changeLanguage(_language);
            _changeLanguage(_language);
            print(
                Provider.of<SharedData>(context, listen: false).language.flag);
          },
        ),
      ),
    );
  }
}
