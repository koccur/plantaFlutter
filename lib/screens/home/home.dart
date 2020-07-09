import 'package:flutter/material.dart';
import 'package:planta_flutter/models/Plant_Alt.dart';
import 'package:planta_flutter/screens/home/plant_list.dart';
import 'package:planta_flutter/screens/home/settings_form.dart';
import 'package:planta_flutter/services/auth.dart';
import 'package:planta_flutter/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<PlantALT>>.value(
        value: DatabaseService().plants,
        child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text("Planta"),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                  onPressed: () async {
                    await _authService.signOut();
                  },
                  icon: Icon(Icons.person),
                  label: Text('Logout')),
              FlatButton.icon(
                  onPressed: () => _showSettingsPanel(), icon: Icon(Icons.settings), label: Text('settings'))
            ],
          ),
          body: PlantList(),
        ));
  }
}
