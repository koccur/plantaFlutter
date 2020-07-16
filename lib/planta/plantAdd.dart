import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:planta_flutter/models/Fertilization.dart';
import 'package:planta_flutter/models/Place.dart';
import 'package:planta_flutter/models/Plant.dart';
import 'package:planta_flutter/models/Water.dart';
import 'package:planta_flutter/services/plant.dart';
import 'package:planta_flutter/shared/colors.dart';

class AddPlantRoute extends StatefulWidget {
  @override
  _AddPlantRoute createState() => _AddPlantRoute();
}

class _AddPlantRoute extends State<AddPlantRoute> {
  final PlantService plantService = PlantService();

  bool checkboxWaterValue = false;
  bool checkboxSprayValue = false;
  bool checkboxFertValue = false;
  final _formKey = GlobalKey<FormState>();
  Plant _plant;

  Widget addPlantBarFunc(context) {
    return AppBar(leading: IconButton(icon: Icon(Icons.cancel), onPressed: () {
      Navigator.pop(context);
    }),
        title: new Center(child: new Text('Plantmagedon', textAlign: TextAlign.center)),
        actions: <Widget>[IconButton(icon: Icon(Icons.check), onPressed: () async {
                if (_plant.uid != null) {
                  await plantService.updatePlant(_plant).whenComplete(() => Navigator.pop(context));
                } else {
            await plantService.createPlant(_plant).whenComplete(() => Navigator.pop(context));
          }
        }),
        ]);
  }

  Widget leftSideBoxFunc(context) {
    return Container(child: Align(alignment: Alignment.topCenter,
        child: Container(padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(top: 4),
            width: 130.0,
            height: 130.0,
            decoration: new BoxDecoration(color: Colors.white, border: new Border.all(width: 5, color: AppColors.ThemeColor)),
                child: FlatButton(
                  onPressed: () => waitForPhoto(),
                  padding: EdgeInsets.all(0.0),
              child: _getImage(_plant.picture),))));
  }

  _getImage(String path) {
    if (path == null) {
      return SvgPicture.asset('images/icons/plant-temp.svg');
    } else {
      return Image.file(File(path));
    }
  }

  Widget checkboxContainer(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Row(children: <Widget>[Checkbox(value: checkboxWaterValue, onChanged: (bool newValue) {
          setState(() {
            checkboxWaterValue = newValue;
          });
        },), Text("Water"), //todo:translate
        ]),
        if (checkboxWaterValue)Column(children: <Widget>[
          Row(children: <Widget>[
            Container(padding: EdgeInsets.only(left: 42), child: Text('Intensity'),),
            Expanded(child: Slider(
              value: _plant.water.intensity.toDouble(),
              onChanged: !checkboxWaterValue ? null : (double newIntensity) {
                setState(() {
                  _plant.water.intensity = newIntensity.round();
                });
              },
              max: 3.0,
              min: 1.0,
              divisions: 2,
              label: _plant.water.intensity.toString(),)),
          ],),
          Row(children: <Widget>[
            Container(padding: EdgeInsets.only(left: 42),
              margin: EdgeInsets.only(bottom: 8, top: 8),
              child: Text('Frequency (days)'),),
            Container(child: TextFormField(
              initialValue: _plant.water.frequency.toString(), keyboardType: TextInputType.number, onChanged: (String value) {
              _plant.water.frequency = int.parse(value);
            },), margin: EdgeInsets.only(left: 16), height: 50, width: 50,)
          ],),
          Container(child: Row(children: <Widget>[
            Icon(Icons.access_time),
            Text('Last activity'),
            Container(
              child: Row(children: <Widget>[
                Container(child: Text(_getFormattedDate(_plant.water.lastActivity)), margin: EdgeInsets.only(right: 8),),
                IconButton(onPressed: () =>
                    _selectDate(
                        context, _plant.water.lastActivity != null ? DateTime.parse(_plant.water.lastActivity) : null,
                        true), icon: Icon(Icons.calendar_today),)
              ],), height: 50, width: 220, margin: EdgeInsets.only(left: 24),)
          ]), margin: EdgeInsets.only(top: 8, bottom: 8), padding: EdgeInsets.only(left: 42),)
        ]),
        Row(children: <Widget>[Checkbox(value: checkboxSprayValue, onChanged: (bool newValue) {
          setState(() {
            checkboxSprayValue = newValue;
          });
        },), Text("Spray"), //todo:translate
        ],),
        Row(children: <Widget>[Checkbox(value: checkboxFertValue, onChanged: (bool newValue) {
          setState(() {
            checkboxFertValue = newValue;
          });
        },), Text("Fertilization"), //todo:translate
        ]),
        if (checkboxFertValue)Column(children: <Widget>[
          Row(children: <Widget>[
            Container(padding: EdgeInsets.only(left: 42), child: Text('Intensity'),),
            Expanded(child: new Slider(
              value: _plant.fertilization.intensity.toDouble(),
              onChanged: !checkboxFertValue ? null : (double newIntensity) {
                setState(() {
                  _plant.fertilization.intensity = newIntensity.round();
                });
              },
              max: 3.0,
              min: 1.0,
              divisions: 2,
              label: _plant.fertilization.intensity.toString(),)),
          ],),
          Row(children: <Widget>[
            Container(padding: EdgeInsets.only(left: 42),
              margin: EdgeInsets.only(bottom: 8, top: 8),
              child: Text('Frequency (days)'),),
            Container(child: TextFormField(
                initialValue: _plant.fertilization.frequency.toString(), keyboardType: TextInputType.number, onChanged: (String value) {
              _plant.fertilization.frequency = int.parse(value);
            }), margin: EdgeInsets.only(left: 16), height: 50, width: 50,)
          ],),
          Container(child: Row(children: <Widget>[
            Icon(Icons.access_time),
            Text('Last activity'),
            Container(child: Row(
              children: <Widget>[
                Container(
                  child: Text(_getFormattedDate(_plant.fertilization.lastActivity)), margin: EdgeInsets.only(right: 8),),
                IconButton(onPressed: () =>
                    _selectDate(context, _plant.fertilization.lastActivity != null
                        ? DateTime.parse(_plant.fertilization.lastActivity)
                        : null, false), icon: Icon(Icons.calendar_today),)
              ],), height: 50, width: 220, margin: EdgeInsets.only(left: 24),)
          ]), margin: EdgeInsets.only(top: 8, bottom: 8), padding: EdgeInsets.only(left: 42),)
        ]),
      ]),);
  }

  Future<Null> _selectDate(BuildContext context, DateTime time, bool isWater) async {
    final DateTime date = await showDatePicker(context: context,
        initialDate: time != null ? time : new DateTime.now(),
        firstDate: DateTime(2020, 1),
        lastDate: DateTime(2030));
    if (date != null && date != time) {
      setState(() {
        if (isWater) {
          _plant.water.lastActivity = _getFormattedDate(date.toString());
        } else {
          _plant.fertilization.lastActivity = _getFormattedDate(date.toString());
        }
      });
    }
  }

  Widget sunnyAndLocContainer(context) {
    return Container(child: Column(children: <Widget>[
      Row(children: <Widget>[
        Container(padding: EdgeInsets.only(left: 42), child: Text('Sunny level'),),
        Expanded(child: Slider(
          value: _plant.place.sunnyLevel.toDouble(),
          onChanged: (double newIntensity) {
            setState(() {
              _plant.place.sunnyLevel = newIntensity.round();
            });
          },
          max: 3.0,
          min: 1.0,
          divisions: 2,
          label: _plant.place.sunnyLevel.toString(),)),
      ],),
      TextFormField(validator: (value) {
        if (value.isEmpty) {
          return "write text";
        }
        return null;
      },
          initialValue: _plant.place.roomName,
          decoration: InputDecoration(labelText: "Place", contentPadding: new EdgeInsets.only(left: 16)),
          onChanged: (String value) {
            _plant.place.roomName = value;
          })
    ],),);
  }

  String _getFormattedDate(String date) {
    if (date != null && date != "") {
      var currDt = DateTime.parse(date);
      var newFormat = DateFormat("yyyy-MM-dd");
      String newDate = newFormat.format(currDt);
      return newDate;
    }
    return ''; //todo: translate
  }

  @override
  Widget build(BuildContext context) {
    _initializePlantData(context);
    return Scaffold(appBar: addPlantBarFunc(context),
        body: Container(child: new Form(key: _formKey,
            child: ListView(children: <Widget>[
              leftSideBoxFunc(context),
              TextFormField(initialValue: _plant.name,
                  decoration: InputDecoration(labelText: "Plant name", contentPadding: new EdgeInsets.only(left: 16)),
                  onChanged: (String value) {
                    _plant.name = value;
                  }),
              checkboxContainer(context),
              sunnyAndLocContainer(context),
              TextFormField(initialValue: _plant.notes,
                  decoration: InputDecoration(labelText: "Notes", contentPadding: new EdgeInsets.only(left: 16)),
                  onChanged: (String value) {
                    _plant.notes = value;
                  }),
            ],)),));
  }

  _initializePlantData(context) {
    if (_plant != null) {
      return;
    }
    Plant plantTemp;
    if (ModalRoute.of(context).settings.arguments.runtimeType == Plant) {
      plantTemp = ModalRoute.of(context).settings.arguments;
    }

    if (plantTemp == null) {
      _plant = new Plant(uid: null,
          water: new Water(lastActivity: null, frequency: 1, intensity: 1),
          place: new Place(roomName: '', sunnyLevel: 1),
          picture: null,
          notes: '',
          fertilization: new Fertilization(lastActivity: null, frequency: 1, intensity: 1),
          name: '');
    } else {
      _plant = new Plant(fertilization: plantTemp.fertilization,
          name: plantTemp.name,
          uid: plantTemp.uid,
          notes: plantTemp.notes,
          picture: plantTemp.picture,
          water: plantTemp.water,
          place: plantTemp.place);

      checkboxWaterValue = _plant.water.lastActivity != '';
      checkboxFertValue = _plant.fertilization.lastActivity != '';
    }
    if (ModalRoute.of(context).settings.arguments.runtimeType == String &&
        ModalRoute.of(context).settings.arguments.toString().contains('png')) {
      _plant.picture = ModalRoute.of(context).settings.arguments;
    }
  }

  Future waitForPhoto() async {
    await Navigator.pushNamed(context, '/takePhoto', arguments: _plant).whenComplete(() => refreshMock());
  }

  // ignore: missing_return
  Widget refreshMock() {
    print("Refresh view");
//    todo: fix it
    setState(() {

    });
  }
}
