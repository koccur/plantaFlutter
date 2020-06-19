import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../colors.dart';

class AddPlantRoute extends StatefulWidget {
  @override
  _AddPlantRoute createState() => _AddPlantRoute();
}

class _AddPlantRoute extends State<AddPlantRoute> {
  bool checkboxWaterValue = false;
  bool checkboxSprayValue = false;
  bool checkboxFertValue = false;
  final _formKey = GlobalKey<FormState>();

  Widget addPlantBarFunc(context) {
    return AppBar(
        leading: IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: new Center(
            child: new Text('Plantmagedon', textAlign: TextAlign.center)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
//            save
            },
          )
        ]);
  }

  Widget leftSideBoxFunc(context) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(right: 4),
        width: 130.0,
        height: 130.0,
        decoration: new BoxDecoration(
            color: Colors.white,
            border: new Border.all(width: 5, color: AppColors.ThemeColor)),
        child: SvgPicture.asset('images/icons/plant-temp.svg'));
  }

  Widget checkboxContainer(context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
            Checkbox(
              value: checkboxWaterValue,
              onChanged: (bool newValue) {
                setState(() {
                  checkboxWaterValue = newValue;
                });
              },
            ),
            Text("Podlewanie"),
          ]),
          Row(
            children: <Widget>[
              Checkbox(
                value: checkboxSprayValue,
                onChanged: (bool newValue) {
                  setState(() {
                    checkboxSprayValue = newValue;
                  });
                },
              ),
              Text("Zraszanie"),
            ],
          ),
          Row(children: <Widget>[
            Checkbox(
              value: checkboxFertValue,
              onChanged: (bool newValue) {
                setState(() {
                  checkboxFertValue = newValue;
                });
              },
            ),
            Text("Nawożenie"),
          ])
        ],
      ),
    );
  }

  Widget sunnyAndLocContainer(context) {
    return Container(
      child: Column(
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return "write text";
              }
              return null;
            },
            decoration: InputDecoration(labelText: "Nasłonecznienie"),
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return "write text";
              }
              return null;
            },
            decoration: InputDecoration(labelText: "Lokalizacja"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Add plant',
        theme: ThemeData(primaryColor: AppColors.ThemeColor),
        home: Scaffold(
            appBar: addPlantBarFunc(context),
            body: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    leftSideBoxFunc(context),
                    Text("Nazwa rośliny"),
                    checkboxContainer(context),
                    sunnyAndLocContainer(context),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Notatki"),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                // If the form is valid, display a Snackbar.
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text('Processing Data')));
                              }
                            },
                            child: Text('Submit')))
                  ],
                ))));
  }
}

// Add your onPressed code here!
