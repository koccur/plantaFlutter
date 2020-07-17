import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planta_flutter/models/Plant.dart';
import 'package:planta_flutter/services/plant.dart';
import 'package:planta_flutter/shared/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';

class PlantHome2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final plants = Provider.of<List<Plant>>(context) ?? [];
    final plantService = PlantService();

    String _getFormattedDate(String date) {
      if (date != null) {
        var currDt = DateTime.parse(date);
        var newFormat = DateFormat("yyyy-MM-dd");
        String newDate = newFormat.format(currDt);
        return newDate;
      }
      return 'no Data'; //todo: translate
    }

    _getImage(String path) {
      if (path == null) {
        return SvgPicture.asset('images/icons/plant-temp.svg');
      } else {
        return Image.file(File(path));
      }
    }

    Widget leftSideBoxFunc(context, Plant plant) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(right: 4),
        width: 130.0,
        height: 130.0,
        decoration:
            new BoxDecoration(color: Colors.white, border: new Border.all(width: 5, color: AppColors.ThemeColor)),
        child: _getImage(plant.picture),
      );
    }

    String getSprayLastActivation(Plant plant) {
//    if (plant.water.spray != null) {
//      return _getFormattedDate(plant.water.spray.lastActivity);
//    }

      return 'no Data'; //todo: translate
    }

    void _waterPlant(Plant plant) {
      plantService.waterPlant(plant);
      Navigator.of(context).pop();
    }

    void _fertilizePlant(Plant plant) {
      plantService.fertilizePlant(plant);
      Navigator.of(context).pop();
    }

    void _showDeletePlantDialog(context, Plant plant) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SimpleDialog(elevation: 12,
                contentPadding: EdgeInsets.only(top: 0, bottom: 16),
                children: <Widget>[
                  Container(padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    margin: EdgeInsets.only(bottom: 24),
                    child: Text(plant.name, style: TextStyle(fontSize: 21),
                ),
                    color: AppColors.ThemeColor,
              ),
                  Container(child: Text('Are you sure that you want to delete this plant?'),
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 16),),
                  Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(child: Text('Cancel'), onPressed: () => Navigator.of(context).pop(),),
                      FlatButton(child: Text('Yes'), onPressed: () {
                        Navigator.of(context).pop();
                        plantService.deletePlant(plant.uid);
                      })
                    ],)
                ]);
          });
    }

    void _showPlantActionDialog(context, Plant plant) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SimpleDialog(
              contentPadding: EdgeInsets.only(top: 0, bottom: 16),
              children: <Widget>[
                Container(
                  child: Row(children: <Widget>[
                    IconButton(
                        icon: new Icon(Icons.edit, color: Colors.white),
                        iconSize: 32.0,
                        onPressed: () => Navigator.popAndPushNamed(context, '/addPlant', arguments: plant)),
                    IconButton(
                        icon: new Icon(Icons.delete, color: Colors.white),
                        iconSize: 32.0,
                        onPressed: () => _showDeletePlantDialog(context, plant)),
                    IconButton(
                      icon: new Icon(Icons.cancel, color: Colors.white),
                      iconSize: 32.0,
                      padding: EdgeInsets.only(left: 140),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ]),
                  color: AppColors.ThemeColor,
                  margin: EdgeInsets.only(bottom: 16),
                ),
                Text(
                  plant.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                Container(margin: EdgeInsets.only(top: 16), padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SvgPicture.asset('images/icons/water.svg', width: 20, height: 20),
                    ),
                    Text(plant.water.lastActivity),
                    IconButton(
                      icon: new Icon(Icons.cached, color: Colors.black45,
                      ), onPressed: () => _waterPlant(plant),
                    )
                  ]),
                ),
                Container(alignment: Alignment.center, padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Row(children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SvgPicture.asset(
                          'images/icons/fertilization.svg',
                          width: 20,
                          height: 20,
                        )),
                    Text(plant.fertilization.lastActivity),
                    IconButton(
                      icon: new Icon(Icons.cached, color: Colors.black38,
                      ), onPressed: () => _fertilizePlant(plant),
                    )
                  ]),
                ),
              ],
            );
          });
    }

    Widget rightSideBoxFunc(context, Plant plant) {
      return Container(
          height: 130,
          width: 130,
          color: Colors.white,
          margin: EdgeInsets.only(left: 4),
          padding: EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              Expanded(child: (Text(plant.name, textAlign: TextAlign.left))),
              Expanded(
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      'images/icons/water.svg',
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(width: 12),
                    Text(_getFormattedDate(plant.water.lastActivity)),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      'images/icons/spray.svg',
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(width: 12),
                    Text(getSprayLastActivation(plant))
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset('images/icons/fertilization.svg', width: 20, height: 20),
                    SizedBox(width: 12),
                    Text(_getFormattedDate(plant.fertilization.lastActivity))
                  ],
                ),
              ),
            ],
          ));
    }

    Widget plantBoxFunc(context, Plant plant) {
      return Row(children: <Widget>[
        Expanded(child: leftSideBoxFunc(context, plant)),
        Expanded(child: rightSideBoxFunc(context, plant))
      ]);
    }

    RaisedButton plantButtonFunc(context, Plant plant) {
      return RaisedButton(onPressed: () => _showPlantActionDialog(context, plant),
        child: plantBoxFunc(context, plant),
        padding: EdgeInsets.all(10),
      );
    }

    if (plants.length == 0) {
      return Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text('There is empty here', style: TextStyle(fontSize: 20)),
                margin: EdgeInsets.only(bottom: 16),
              ),
              RaisedButton(
                child: Text('Add your plant :)'),
                onPressed: () => Navigator.pushNamed(context, '/addPlant'),
              )
            ],
          ));
    } else {
      return Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            child: Text('Add your plant :)'),
            onPressed: () => Navigator.pushNamed(context, '/addPlant'),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: plants.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 0),
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: <Widget>[plantButtonFunc(context, plants[index]), SizedBox(height: 20)],
                  ),
                  padding: const EdgeInsets.all(10),
                );
              },
            ),
          )
        ],
      );
    }
  }
}
