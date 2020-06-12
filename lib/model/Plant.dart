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
        this.notes}) {}

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
//  factory Plant.fromJsonPlants(List<Map<String,dynamic>> json){
//    List list = new List();
//    for(int i = 0;i<json.length;i++){
//      list.add(Plant.fromJson(json[i]));
//    }
//
//     return list;
//  }
}

class Plants{
  final List<Plant> plants;
  Plants({this.plants}){

  }

  factory Plants.fromJson(Map<String,dynamic> json){
    return Plants(
      plants: json['plants']
    );
  }
}
