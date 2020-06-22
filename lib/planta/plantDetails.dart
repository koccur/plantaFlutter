//import 'package:flutter/material.dart';
//import 'package:planta_flutter/colors.dart';
//import 'package:flutter_svg/flutter_svg.dart';
//import 'package:planta_flutter/planta/plantHome.dart';
//
//class PlantDetails extends StatefulWidget{
//
//  @override
//  _PlantDetails createState() =>_PlantDetails();
//
//}
//
//
//class _PlantDetails extends State<PlantDetails> {
//  static List<Widget> iconsAppBar = [
//    IconButton(icon: Icon(Icons.cancel), onPressed: null),
//    IconButton(icon: Icon(Icons.check), onPressed: null)
//  ];
//
//  Widget appBar = AppBar(title: Text('Plantmagedon'), actions: iconsAppBar);
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: appBar,
//      body: Center(
//        child: RaisedButton(
//          child: Text('Open route'),
//        ),
//      ),
//    );
//  }
//}
//
////class FirstRoute extends StatelessWidget {
////  @override
////  Widget build(BuildContext context) {
////    return Scaffold(
////      appBar: AppBar(
////        title: Text('First Route'),
////      ),
////      body: Center(
////        child: RaisedButton(
////          child: Text('Open route'),
////          onPressed: () {
////            Navigator.push(
////              context,
////              MaterialPageRoute(builder: (context) => SecondRoute()),
////            );
////          },
////        ),
////      ),
////    );
////  }
////}
////
////class SecondRoute extends StatelessWidget {
////  @override
////  Widget build(BuildContext context) {
////    return Scaffold(
////      appBar: AppBar(
////        title: Text("Second Route"),
////      ),
////      body: Center(
////        child: RaisedButton(
////          onPressed: () {
////            Navigator.pop(context);
////          },
////          child: Text('Go back!'),
////        ),
////      ),
////    );
////  }
////}
