import 'Fertilization.dart';
import 'Place.dart';
import 'Water.dart';

class Plant {
  final int id;
  final String name;
  final String picture;
  final Water water;
  final Fertilization fertilization;
  final Place place;
  final String notes;

  Plant(
      {this.id,
      this.name,
      this.picture,
      this.water,
      this.fertilization,
      this.place,
      this.notes});

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
        id: json['id'],
        name: json['name'],
        picture: json['picture'],
        water: Water.fromJson(json['water']),
        fertilization: Fertilization.fromJson(json['fertilization']),
        place: Place.fromJson(json['place']),
        notes: json['notes']);
  }
}
class PlantList{
  final List<Plant> plants;

  PlantList({this.plants});

  factory PlantList.fromJson(List<dynamic> parsedJson){

    List<Plant> plants = new List<Plant>();
    plants  = parsedJson.map((el)=>Plant.fromJson(el)).toList();

    return new PlantList(plants: plants);
  }

}
