import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  static String id="Menu";
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Map<String,dynamic>> dishes=new List<Map<String,dynamic>>();
  CollectionReference db=FirebaseFirestore.instance.collection("Dishes");
  Stream<List<Map<String,dynamic>>> menu() async*{
    await Future<void>.delayed(Duration(seconds: 1));
    db.snapshots().listen((event) {
      List<DocumentSnapshot> datas = event.docs;
      for(DocumentSnapshot data in datas) {
        if(!dishes.contains(data.data())) {
          print(data.data());
          dishes.add(data.data());
          print("y");
        }
      }
      print(dishes.length);
    });
    yield dishes;
    await Future<void>.delayed(Duration(seconds: 1));
  }
  @override
  void initState() {


    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (dishes!=null) SizedBox(
              height: 300,
              child: StreamBuilder<List<Map<String,dynamic>>>(
                stream:menu(),
                initialData: [{"name":"no","image":"no","numberInStock":"no"}],
                builder: (BuildContext context, AsyncSnapshot<List<Map<String,dynamic>>> snapshot) {
                  if(snapshot.hasData)return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                            children: [
                              Image.asset("assets/"+snapshot.data[index]["image"],height: 300,width: 300,fit: BoxFit.cover,),
                              Column(
                                children: [
                                  Text(snapshot.data[index]["name"]),
                                  Text(snapshot.data[index]["numberInStock"].toString()),
                                ],
                              )
                            ],
                        );
                      }
                  );
                  return Text("nô");
                }
              ),
            ) else Text("nô"),
          ],
        ),
    );
  }
}
