import 'package:baitaplon/constants/bottomType.dart';
import 'package:baitaplon/constants/myColors.dart';
import 'package:baitaplon/constants/sharedData.dart';
import 'package:baitaplon/models/Questionnaire.dart';
import 'package:baitaplon/models/Users.dart';
import 'package:baitaplon/page/bottom/CollectionPage.dart';
import 'package:baitaplon/page/bottom/HomePage.dart';
import 'package:baitaplon/page/bottom/ProfilePage.dart';
import 'package:baitaplon/page/bottom/SearchPage.dart';
import 'package:baitaplon/page/questionnaire/question/CreateQuestionPage.dart';
import 'package:baitaplon/routes/RouteName.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  MainPage({
    Key key,
    @required this.initBody,
  }) : super(key: key);

  final BottomType initBody;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex;
  User user;
  List<Widget> bodyOptions = [
    HomePage(),
    SearchPage(),
    CollectionPage(),
    ProfilePage(),
  ];

  List<BottomNavigationBarItem> bottomOptions = [
    BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
    BottomNavigationBarItem(
        icon: Icon(Icons.book_outlined), label: "Collection"),
    BottomNavigationBarItem(
        icon: Icon(Icons.account_circle_outlined), label: "Profile"),
  ];
  @override
  void initState() {
    super.initState();

    switch (this.widget.initBody) {
      case BottomType.home:
        currentIndex = 0;
        break;
      case BottomType.search:
        currentIndex = 1;
        break;
      case BottomType.collection:
        currentIndex = 2;
        break;
      case BottomType.profile:
        currentIndex = 3;
        break;
      default:
        currentIndex = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      user = Provider.of<SharedData>(context, listen: false).user;
    });

    return Scaffold(
      appBar: appBar(),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomOptions,
        currentIndex: currentIndex,
        onTap: (val) {
          setState(() {
            currentIndex = val;
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, createQuestionnaireRoute);
        },
        child: Icon(Icons.add),
      ),
      body: bodyOptions.elementAt(currentIndex),
    );
  }

  AppBar appBar() {
    String title;

    switch (currentIndex) {
      case 0:
        Provider.of<SharedData>(context, listen: false)
            .changeCurrentMainPage(BottomType.home);
        title = "Home";
        break;
      case 1:
        Provider.of<SharedData>(context, listen: false)
            .changeCurrentMainPage(BottomType.search);
        title = "Search";
        break;
      case 2:
        Provider.of<SharedData>(context, listen: false)
            .changeCurrentMainPage(BottomType.collection);
        title = "Collection";
        break;
      case 3:
        Provider.of<SharedData>(context, listen: false)
            .changeCurrentMainPage(BottomType.profile);
        title = "Profile";
        break;
      default:
        Provider.of<SharedData>(context, listen: false)
            .changeCurrentMainPage(BottomType.home);
        title = "Quiz App";
    }

    return AppBar(
      title: Text(title),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: IconButton(
            icon: Icon(Icons.login_rounded, size: 30),
            onPressed: () {
              Navigator.pushReplacementNamed(context, loginRoute);
            },
          ),
        ),
      ],
    );
  }
}
