import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:planta_flutter/env.dart';
import 'package:planta_flutter/models/Plant.dart';

class PlantController {
  static Future<Plant> getPlant(int id) async {
    final response = await http.get(Variables.API_URL + 'plants/allInfo/' + id.toString());
    if (response.statusCode == 200) {
      return Plant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get plant with id:3');
    }
  }

  static Future<PlantList> getPlants() async {
    final response = await http.get(Variables.API_URL + 'plants/allInfo');
    if (response.statusCode == 200) {
      PlantList plantList = PlantList.fromJson(json.decode(response.body));
      return plantList;
    } else {
      throw Exception('Failed to get plants');
    }
  }

  static Future createPlant(Plant plantDTO) async {
    final http.Response response = await http.post(Variables.API_URL + 'plants',
        headers: <String, String>{'Content-type': 'application/json;charset=UTF-8'}, body: jsonEncode(plantDTO));

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to create Plant');
    }
  }

  static Future updatePlant(Plant plantDto) async {
    final http.Response response = await http.put(Variables.API_URL + 'plants/${plantDto.uid}',
        headers: <String, String>{'Content-type': 'application/json;charset=UTF-8'}, body: jsonEncode(plantDto));
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to update Plant');
    }
  }
}
