import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planta_flutter/controllers/Plant.controller.dart';
import 'package:planta_flutter/model/Fertilization.dart';
import 'package:planta_flutter/model/Place.dart';
import 'package:planta_flutter/model/Plant.dart';
import 'package:planta_flutter/model/Water.dart';

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
  Plant plant = new Plant(
      id: null,
      water: new Water(),
      place: new Place(),
      picture: null,
      notes: null,
      fertilization: new Fertilization(),
      name: null);

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
            onPressed: () async{
            await PlantController.createPlant(Plant(
                                  id: null,
                                  fertilization: Fertilization(
                                    lastActivity: '1',
                                    intensity: 1,
                                    frequency: 1
                                  ),
                                  name: plant.name,
                                  notes: plant.notes,
                                  picture: null,
                                  place: Place(
                                      sunnyLevel: plant.place.sunnyLevel,
                                      roomName: plant.place.roomName),
                                  water: Water(
                                    spray: null,
                                    frequency: 1,
                                    intensity: 1,
                                    lastActivity: '1',
                                  )
                              )).whenComplete(() => Navigator.pop(context))
                .whenComplete(() => PlantController.getPlants());
//            todo: dodac odswiezanie listy po dodaniu elementu
            },
          ),
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
              onChanged: (String value) {
                plant.place.sunnyLevel = 1;
              }),
          TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return "write text";
                }
                return null;
              },
              decoration: InputDecoration(labelText: "Lokalizacja"),
              onChanged: (String value) {
                plant.place.roomName = value;
              })
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
                    TextFormField(
                        decoration: InputDecoration(labelText: "Nazwa rośliny"),
                        onChanged: (String value) {
                          plant.name = value;
                        }),
                    checkboxContainer(context),
                    sunnyAndLocContainer(context),
                    TextFormField(
                        decoration: InputDecoration(labelText: "Notatki"),
                        onChanged: (String value) {
                          plant.notes = value;
                        }),
                  ],
                )),

        ));
  }
}

// Add your onPressed code here!
