//import 'dart:convert';
//
//import 'package:planta_flutter/model/Place.dart';
//import 'package:http/http.dart' as http;
//
//Future<Place> getPlace() async {
//  final response = await http.get('http://10.0.2.2:3000/plants/3');
//  if (response.statusCode == 200) {
//    return Place.fromJson(json.decode(response.body));
//  } else {
//    throw Exception('Failed to get place with id:3');
//  }
//}
