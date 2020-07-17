import 'package:flutter/material.dart';
import 'package:planta_flutter/models/Plant.dart';
import 'package:planta_flutter/models/User.dart';
import 'package:planta_flutter/planta/plant_home.dart';
import 'package:planta_flutter/services/auth.dart';
import 'package:planta_flutter/services/plant.dart';
import 'package:planta_flutter/shared/colors.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return StreamProvider<List<Plant>>.value(value: PlantService(userUid: user.uid).getPlantsByUserId(),
        child: Scaffold(key: _scaffoldKey,
          appBar: AppBar(
            title: Text("Plantmagedon"), backgroundColor: AppColors.ThemeColor, elevation: 0.0, actions: <Widget>[
//              Scaffold.of(context).openEndDrawer()
            IconButton(onPressed: () => Navigator.pushNamed(context, '/addPlant'),
              icon: Icon(Icons.add_circle),
              color: Colors.white,
              iconSize: 28,),
            IconButton(onPressed: () {}, icon: Icon(Icons.calendar_today), color: Colors.white, iconSize: 28),
            IconButton(onPressed: () {
              _scaffoldKey.currentState.openEndDrawer();
            }, icon: Icon(Icons.menu), color: Colors.white, iconSize: 28),
          ],),
          body: PlantHome2(),
          endDrawer: Drawer(child: ListView(children: <Widget>[
            DrawerHeader(decoration: BoxDecoration(color: AppColors.ThemeColor),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24),),),
            ListTile(leading: Icon(Icons.person), title: Text('Logout'), onTap: () async {
              Navigator.of(context).pop();
              await _authService.signOut();
            },),
          ],),),));
  }
}
