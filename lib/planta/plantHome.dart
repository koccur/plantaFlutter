import 'package:flutter/material.dart';
import 'package:planta_flutter/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planta_flutter/controllers/Plant.controller.dart';
import 'package:planta_flutter/model/Plant.dart';
import 'dart:convert';

import 'package:planta_flutter/planta/plantAdd.dart';

class PlantHome extends StatefulWidget {
  @override
  _PlantHome createState() => _PlantHome();
}

class _PlantHome extends State<PlantHome> {
  Future<PlantList> futurePlants;
  Future<Plant> futurePlant;

  List<Widget> iconsAppBarFunc(context) {
    return [
      IconButton(icon: Icon(Icons.calendar_today), onPressed: null),
      IconButton(icon: Icon(Icons.menu), onPressed: null)
    ];
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
                  Text('15.10.2020'),
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
                  Text('15.10.2020')
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  SvgPicture.asset('images/icons/fertilization.svg',
                      width: 20, height: 20),
                  SizedBox(width: 12),
                  Text('15.10.2020')
                ],
              ),
            ),
          ],
        ));
  }

  Widget plantBoxFunc(context, Plant plant) {
    return Row(
      children: <Widget>[
        Expanded(child: leftSideBoxFunc(context)),
        Expanded(child: rightSideBoxFunc(context, plant))
      ],
    );
  }

  RaisedButton plantButtonFunc(context, Plant plant) {
    return RaisedButton(
      child: plantBoxFunc(context, plant),
      padding: EdgeInsets.all(10),
    );
  }

  Widget appBarFunc(context) {
    return AppBar(
        title: Text('Plantmagedon'), actions: iconsAppBarFunc(context));
  }

  Widget plantListFunc(context, Plant plant) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 64),
      alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[
          plantButtonFunc(context, plant),
          SizedBox(height: 20),
        ],
      ),
      padding: const EdgeInsets.all(10),
      decoration: new BoxDecoration(
        color: Colors.red,
      ),
    );
  }

  Widget plantsListFunc(context, PlantList plantList) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 64),
      alignment: Alignment.topCenter,
      child: ListView.builder(
        itemCount: plantList.plants.length,
        itemBuilder: (context,index){
          return plantListFunc(context, plantList.plants[index]);
        },
      ),
      padding: const EdgeInsets.all(10),
      decoration: new BoxDecoration(
        color: Colors.red,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    futurePlants = PlantController.getPlants();
    futurePlant = PlantController.getPlant(1);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plantmagedon',
      theme: ThemeData(primaryColor: AppColors.ThemeColor),
      home: Scaffold(
        appBar: appBarFunc(context),
        body: Container(
          alignment: Alignment.center,
          child: FutureBuilder<PlantList>(
            future: futurePlants,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return plantsListFunc(context, snapshot.data);
              } else if (snapshot.hasError) {
                return Text("Problem z danymi2");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddPlantRoute()));
          },
          child: Icon(Icons.add),
          backgroundColor: AppColors.ThemeColor,
        ),
      ),
    );
  }
}
