import 'package:baitaplon/constants/myColors.dart';
import 'package:baitaplon/constants/sharedData.dart';
import 'package:baitaplon/models/Questionnaire.dart';
import 'package:baitaplon/models/Users.dart';
import 'package:baitaplon/page/ConfigurePage.dart';
import 'package:baitaplon/page/bottom/HomePage.dart';
import 'package:baitaplon/page/bottom/ProfilePage.dart';
import 'package:baitaplon/page/bottom/SearchPage.dart';
import 'package:baitaplon/page/questionnaire/CreateQuestionPage.dart';
import 'package:baitaplon/routes/RouteName.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  User user;

  List<Widget> _bodyOptions = [
    HomePage(),
    SearchPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    setState(() {
      user = Provider.of<SharedData>(context, listen: false).user;
    });

    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          title: Consumer<SharedData>(
            builder: (context, data, child) => Text(data.user.name),
          )),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: "Profile"),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (val) {
          setState(() {
            _currentIndex = val;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(createQuestionnaireRoute);
        },
      ),
      body: _bodyOptions.elementAt(_currentIndex),
    );
  }
}
