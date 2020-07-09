import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planta_flutter/models/Plant_Alt.dart';

class PlantCard extends StatelessWidget {
  final PlantALT plant;

  PlantCard({this.plant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown,
            child: SvgPicture.asset('images/icons/plant-temp.svg'),
          ),
          title: Text(plant.name),
          subtitle: Text(plant.intensity),
        ),
      ),
    );
  }
}
