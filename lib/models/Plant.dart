import 'Fertilization.dart';
import 'Place.dart';
import 'Water.dart';

class Plant {
  final String uid;
  String name;
  String picture;
  Water water;
  Fertilization fertilization;
  Place place;
  String notes;

  Plant({this.uid, this.name, this.picture, this.water, this.fertilization, this.place, this.notes});

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(uid: json['uid'],
        name: json['name'],
        picture: json['picture'],
        water: Water.fromJson(json['water']),
        fertilization: Fertilization.fromJson(json['fertilization']),
        place: Place.fromJson(json['place']),
        notes: json['notes']);
  }

  Map<String, dynamic> toJson() => {"uid": uid,
        "name": name,
        "picture": picture,
        "water": water,
        "fertilization": fertilization,
        "place": place,
        "notes": notes
      };
}

class PlantList {
  final List<Plant> plants;

  PlantList({this.plants});

  factory PlantList.fromJson(List<dynamic> parsedJson) {
    List<Plant> plants = new List<Plant>();
    plants = parsedJson.map((el) => Plant.fromJson(el)).toList();

    return new PlantList(plants: plants);
  }
}

