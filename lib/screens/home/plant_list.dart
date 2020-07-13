import 'package:flutter/material.dart';
import 'package:planta_flutter/models/Plant.dart';
import 'package:planta_flutter/screens/home/plant_card.dart';
import 'package:provider/provider.dart';

class PlantList extends StatefulWidget {
  @override
  _PlantListState createState() => _PlantListState();
}

class _PlantListState extends State<PlantList> {
  @override
  Widget build(BuildContext context) {
    final plants = Provider.of<List<Plant>>(context) ?? [];

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
      return ListView.builder(
        itemCount: plants.length,
        itemBuilder: (context, index) {
          return PlantCard(plant: plants[index]);
        },
      );
    }
  }
}
