import 'package:baitaplon/localization/LocalizationConstant.dart';
import 'package:baitaplon/routes/RouteName.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key}):super(key:key);
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Page"),
      ),
      body: Container(
        child: MaterialButton(
          color: Colors.blue,
          child: Text(getTranslated(context, "Navigator to setting page")),
          onPressed: (){
            Navigator.pushNamed(context, settingRoute);
          },
        ),
      ),
    );
  }
}
