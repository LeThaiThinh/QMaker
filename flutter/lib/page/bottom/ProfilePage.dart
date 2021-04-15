import 'package:baitaplon/classes/language.dart';
import 'package:baitaplon/constants/myColors.dart';
import 'package:baitaplon/constants/sharedData.dart';
import 'package:baitaplon/main.dart';
import 'package:baitaplon/page/auth/ChangePassPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:baitaplon/localization/LocalizationConstant.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    return Align(
      child: Text(
        'Hello ' +
            Provider.of<SharedData>(context, listen: false).user.username,
        style: TextStyle(
          fontSize: 30,
          color: primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget changePassBtn() {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => ChangePassPage()));
        },
        leading: Icon(Icons.lock, color: primaryColor),
        title: Text(
          "Change Password",
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
    _changeLanguage(Language language) async {
      Locale _temp = await setLocale(language.languageCode);
      MyApp.setLocale(context, _temp);
    }

    return DropdownButton<Language>(
      hint: Text("Language"),
      // style: TextStyle(fontSize: 5),
      iconSize: 30,
      underline: SizedBox(),
      icon: Icon(
        Icons.language,
        color: Colors.green,
      ),
      items: Language.languageList()
          .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
              value: lang,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    lang.flag,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    lang.name,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              )))
          .toList(),
      onChanged: (Language language) {
        _changeLanguage(language);
        print(language);
      },
    );
  }
}
