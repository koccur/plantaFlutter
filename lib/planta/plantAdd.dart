import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
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
  Plant _plant = new Plant(
      id: null,
      water:
          new Water(lastActivity: '', frequency: 1, intensity: 3, spray: null),
      place: new Place(roomName: '', sunnyLevel: 1),
      picture: null,
      notes: '',
      fertilization:
      new Fertilization(lastActivity: '', frequency: 1, intensity: 1),
      name: '');

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
            onPressed: () async {
              await PlantController.createPlant(new Plant(
                id: null,
                fertilization: Fertilization(
                    lastActivity: this._plant.fertilization.lastActivity,
                    intensity: this._plant.fertilization.intensity,
                    frequency: this._plant.fertilization.frequency),
                name: this._plant.name,
                notes: this._plant.notes,
                picture: null,
                place: Place(
                    sunnyLevel: this._plant.place.sunnyLevel,
                    roomName: this._plant.place.roomName),
                water: Water(
                  spray: null,
                  frequency: this._plant.water.frequency,
                  intensity: this._plant.water.intensity,
                  lastActivity: this._plant.water.lastActivity,
                ),
              ))
                  .whenComplete(() => Navigator.pop(context))
                  .whenComplete(() => PlantController.getPlants());
//            todo: refresh list after add this element
            },
          ),
        ]);
  }

  Widget leftSideBoxFunc(context) {
    return Container(
        child: Align(
            alignment: Alignment.topCenter,
            child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(top: 4),
                width: 130.0,
                height: 130.0,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    border:
                    new Border.all(width: 5, color: AppColors.ThemeColor)),
                child: (SvgPicture.asset('images/icons/plant-temp.svg')))));
  }

  Widget checkboxContainer(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Row(children: <Widget>[
          Checkbox(
            value: checkboxWaterValue,
            onChanged: (bool newValue) {
              setState(() {
                checkboxWaterValue = newValue;
              });
            },
          ),
          Text("Water"), //todo:translate
        ]),
        if (checkboxWaterValue)
          Column(children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 42),
                  child: Text('Intensity'),
                ),
                Expanded(
                    child: new Slider(
                      value: this._plant.water.intensity.toDouble(),
                      onChanged: !checkboxWaterValue
                          ? null
                          : (double newIntensity) {
                        setState(() {
                          this._plant.water.intensity = newIntensity.round();
                        });
                      },
                      max: 3.0,
                      min: 1.0,
                      divisions: 2,
                      label: this._plant.water.intensity.toString(),
                    )),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 42),
                  margin: EdgeInsets.only(bottom: 8, top: 8),
                  child: Text('Frequency (days)'),
                ),
                Container(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (String value) {
                      _plant.water.frequency = int.parse(value);
                    },
                  ),
                  margin: EdgeInsets.only(left: 16),
                  height: 50,
                  width: 50,
                )
              ],
            ),
            Container(
              child: Row(children: <Widget>[
                Icon(Icons.access_time),
                Text('Last activity'),
                Container(
                  child: TextFormField(
                      keyboardType: TextInputType.datetime,
                      onChanged: (String value) {
                        _plant.water.lastActivity = value;
                      }), //---------------------------------
                  height: 50,
                  width: 150,
                  margin: EdgeInsets.only(left: 24),
                )
              ]),
              margin: EdgeInsets.only(top: 8, bottom: 8),
              padding: EdgeInsets.only(left: 42),
            )
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
            Text("Spray"), //todo:translate
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
          Text("Fertilization"), //todo:translate
        ]),
        if (checkboxFertValue)
          Column(children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 42),
                  child: Text('Intensity'),
                ),
                Expanded(
                    child: new Slider(
                      value: this._plant.fertilization.intensity.toDouble(),
                      onChanged: !checkboxFertValue
                          ? null
                          : (double newIntensity) {
                        setState(() {
                          this._plant.fertilization.intensity =
                              newIntensity.round();
                        });
                      },
                      max: 3.0,
                      min: 1.0,
                      divisions: 2,
                      label: this._plant.fertilization.intensity.toString(),
                    )),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 42),
                  margin: EdgeInsets.only(bottom: 8, top: 8),
                  child: Text('Frequency (days)'),
                ),
                Container(
                  child: TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (String value) {
                        _plant.fertilization.frequency = int.parse(value);
                      }),
                  margin: EdgeInsets.only(left: 16),
                  height: 50,
                  width: 50,
                )
              ],
            ),
            Container(
              child: Row(children: <Widget>[
                Icon(Icons.access_time),
                Text('Last activity'),
                Container(
                  child: TextFormField(
                      keyboardType: TextInputType.datetime,
                      onChanged: (String value) {
                        _plant.fertilization.lastActivity = value;
                      }),
                  height: 50,
                  width: 150,
                  margin: EdgeInsets.only(left: 24),
                )
              ]),
              margin: EdgeInsets.only(top: 8, bottom: 8),
              padding: EdgeInsets.only(left: 42),
            )
          ]),
      ]),
    );
  }

  Widget sunnyAndLocContainer(context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 42),
                child: Text('Sunny level'),
              ),
              Expanded(
                  child: new Slider(
                    value: this._plant.place.sunnyLevel.toDouble(),
                    onChanged: (double newIntensity) {
                      setState(() {
                        this._plant.place.sunnyLevel = newIntensity.round();
                      });
                    },
                    max: 3.0,
                    min: 1.0,
                    divisions: 2,
                    label: this._plant.place.sunnyLevel.toString(),
                  )),
            ],
          ),
          TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return "write text";
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: "Place",
                  contentPadding: new EdgeInsets.only(left: 16)),
              onChanged: (String value) {
                _plant.place.roomName = value;
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
            body: SafeArea(
              top: false,
              bottom: false,
              child: new Form(
                  key: _formKey,
                  child: new ListView(
                    children: <Widget>[
                      leftSideBoxFunc(context),
                      TextFormField(
                          decoration: InputDecoration(
                              labelText: "Plant name",
                              contentPadding: new EdgeInsets.only(left: 16)),
                          onChanged: (String value) {
                            _plant.name = value;
                          }),
                      checkboxContainer(context),
                      sunnyAndLocContainer(context),
                      TextFormField(
                          decoration: InputDecoration(
                              labelText: "Notes",
                              contentPadding: new EdgeInsets.only(left: 16)),
                          onChanged: (String value) {
                            _plant.notes = value;
                          }),
                    ],
                  )),
            )));
  }
}
