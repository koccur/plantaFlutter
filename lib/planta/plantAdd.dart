import 'package:flutter/material.dart';

import '../colors.dart';

class AddPlantRoute extends StatefulWidget {
  @override
  _AddPlantRoute createState() => _AddPlantRoute();

}

class _AddPlantRoute extends State<AddPlantRoute> {
  Widget addPlantBarFunc(context) {
    return AppBar(
        leading: IconButton(icon: Icon(Icons.cancel), onPressed: () {
          Navigator.pop(context);
        }),
        title: new Center(
            child: new Text('Plantmagedon', textAlign: TextAlign.center)),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.check), onPressed: () {
//            save
          },)
        ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Add plant',
        theme: ThemeData(primaryColor: AppColors.ThemeColor),
        home: Scaffold(
          appBar: addPlantBarFunc(context),
          body: Form(
            child:Column(
            children: <Widget>[

              ],
            )
          )

    ));
  }
}

// Add your onPressed code here!
