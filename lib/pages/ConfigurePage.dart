import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ConfigurePage extends StatefulWidget {
  @override
  _ConfigurePageState createState() => _ConfigurePageState();
}

class _ConfigurePageState extends State<ConfigurePage> {
  String _name;
  String _totalQuestion;
  String _totalTime;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      // ignore: missing_return
      validator: (String value) {
        // ignore: missing_return
        if (value.isEmpty) return "Name is required";
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildTotalQuestion() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Total Question'),
      keyboardType: TextInputType.number,
      // ignore: missing_return
      validator: (String value) {
        // ignore: missing_return
        if (value.isEmpty) return "Total Question is required";
        // ignore: unrelated_type_equality_checks
        if (int.tryParse(value)<=0) return "Input must be greater than 0";
      },
      onSaved: (String value) {
        _totalQuestion = value;
      },
    );
  }

  Widget _buildTotalTime() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Total Time'),
      keyboardType: TextInputType.number,
      // ignore: missing_return
      validator: (String value) {
        // ignore: missing_return
        if (value.isEmpty) return "Total Time is required";
        // ignore: unrelated_type_equality_checks
        if (int.tryParse(value)<=0) return "Input must be greater than 0";

      },
      onSaved: (String value) {
        _totalTime = value;
      },
    );
  }

  Widget _createQuestionnaire() {
    return RaisedButton(
        child: Text("Create"),
        onPressed: () {
          if (_formKey.currentState.validate()) return;
          _formKey.currentState.save();
          // print(_name);
          // print(_totalQuestion);
          // print(_totalTime);

        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              centerTitle: true,
              floating: true,
              pinned: true,
              stretchTriggerOffset: 100,
              onStretchTrigger: (){},
              
              flexibleSpace: FlexibleSpaceBar(
                // stretchModes: <StretchMode>[
                //   StretchMode.zoomBackground,
                //   StretchMode.blurBackground,
                //   StretchMode.fadeTitle,
                // ],
                centerTitle: true,
                collapseMode: CollapseMode.parallax,
                background: Image(
                  image: AssetImage("assets/camera.jpg"), fit: BoxFit.cover,),
                ),
              actions: [Icon(
                Icons.play_arrow_sharp,size: 30,),
                SizedBox(width: 10,),
                
              ],
              actionsIconTheme: IconTheme.of(context),
              iconTheme: IconTheme.of(context),
            ),

            SliverList(
                delegate: SliverChildListDelegate(
                    [
                        Material(
                          elevation: 0,
                          type: MaterialType.canvas,
                          borderOnForeground: false,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildName(),
                                _buildTotalQuestion(),
                                _buildTotalTime(),
                                SizedBox(height: 500,),
                                _createQuestionnaire(),
                            ],
                          ),
                      ),
                        ),
                    ]
                )
            )

          ],
        )
    );
  }
}
