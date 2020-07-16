import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planta_flutter/models/Plant.dart';
import 'package:planta_flutter/shared/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';

class PlantHome2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final plants = Provider.of<List<Plant>>(context) ?? [];

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
      return RaisedButton(
        onPressed: () => Navigator.pushNamed(context, '/addPlant', arguments: plant),
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
