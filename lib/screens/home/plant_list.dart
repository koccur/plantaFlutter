import 'package:flutter/material.dart';
import 'package:planta_flutter/models/Plant_Alt.dart';
import 'package:planta_flutter/screens/home/plant_card.dart';
import 'package:provider/provider.dart';

class PlantList extends StatefulWidget {
  @override
  _PlantListState createState() => _PlantListState();
}

class _PlantListState extends State<PlantList> {
  @override
  Widget build(BuildContext context) {
    final plants = Provider.of<List<PlantALT>>(context) ?? [];
    return ListView.builder(
      itemCount: plants.length,
      itemBuilder: (context, index) {
        return PlantCard(plant: plants[index]);
      },
    );
  }
}
