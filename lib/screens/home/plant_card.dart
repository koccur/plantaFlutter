import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planta_flutter/models/Plant.dart';
import 'file:///C:/projects/planta_flutter/lib/shared/colors.dart';

class PlantCard extends StatelessWidget {
  final Plant plant;

  PlantCard({this.plant});

  _setPlantAsWatered() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(radius: 30, backgroundColor: AppColors.ThemeColor,
            child: SvgPicture.asset('images/icons/plant-temp.svg'),
//            wyglada na coraz bardziej zdechła jak nie jest podlewana od paru dni
          ),
          title: Text(plant.name),
          subtitle: Text(plant.water.lastActivity),
          //todo:wstawić podlewanko
          onLongPress: () => _setPlantAsWatered(),
          trailing: Icon(Icons.settings),
          isThreeLine: true,
        ),
      ),
    );
  }
}
