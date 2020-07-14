import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:planta_flutter/models/Fertilization.dart';
import 'package:planta_flutter/models/Place.dart';
import 'package:planta_flutter/models/Plant.dart';
import 'package:planta_flutter/models/Water.dart';

class PlantService {
  final String userUid;
  final String plantUid;

  PlantService({this.userUid, this.plantUid});

  final CollectionReference reference = Firestore.instance.collection('users');

  Stream<List<Plant>> getPlantsByUserId() {
    return reference.document(userUid).collection('plants').snapshots().map((event) => _plantListFromSnapshot(event));
  }

  Future createPlant(Plant plant) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var subCollection = reference.document(user.uid).collection('plants').document();
    return await subCollection.setData({
      "uid": subCollection.documentID,
      "name": plant.name,
      "notes": plant.notes,
      "picture": plant.picture,
      "water": {
        "intensity": plant.water.intensity,
        "frequency": plant.water.frequency,
        "lastActivity": plant.water.lastActivity
      },
      "fertilization": {
        "intensity": plant.fertilization.intensity,
        "frequency": plant.fertilization.frequency,
        "lastActivity": plant.fertilization.lastActivity
      },
      "place": {"roomName": plant.place.roomName, "sunnyLevel": plant.place.sunnyLevel}
    });
  }

  Future updatePlant(Plant plant) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return await reference.document(user.uid).collection('plants').document(plant.uid).updateData({
      "name": plant.name,
      "notes": plant.notes,
      "picture": plant.picture,
      "water": {
        "intensity": plant.water.intensity,
        "frequency": plant.water.frequency,
        "lastActivity": plant.water.lastActivity
      },
      "fertilization": {
        "intensity": plant.fertilization.intensity,
        "frequency": plant.fertilization.frequency,
        "lastActivity": plant.fertilization.lastActivity
      },
      "place": {"roomName": plant.place.roomName, "sunnyLevel": plant.place.sunnyLevel}
    });
  }


  List<Plant> _plantListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Plant(
          uid: doc.data['uid'] ?? '',
          name: doc.data['name'] ?? '',
          notes: doc.data['notes'] ?? '',
          picture: doc.data['picture'] ?? null,
          water: _getDataFromWater(doc.data['water']) ?? null,
          fertilization: _getDataFromFert(doc.data['fertilization']) ?? null,
          place: _getDataFromPlace(doc.data['place']) ?? null);
    }).toList();
  }

  _getDataFromPlace(Map<dynamic, dynamic> place) {
    if (place == null) {
      return null;
    }
    return Place(roomName: place['roomName'], sunnyLevel: place['sunnyLevel']);
  }

  _getDataFromWater(Map<dynamic, dynamic> water) {
    if (water == null) {
      return null;
    }
    return Water(
        frequency: water['frequency'], intensity: water['intensity'], lastActivity: water['lastActivity'].toString());
  }

  _getDataFromFert(Map<dynamic, dynamic> fert) {
    if (fert == null) {
      return null;
    }
    return Fertilization(
        frequency: fert['frequency'], intensity: fert['intensity'], lastActivity: fert['lastActivity'].toString());
  }


}
