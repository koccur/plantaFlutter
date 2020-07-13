import 'package:flutter/material.dart';
import 'package:planta_flutter/models/Plant_Alt.dart';
import 'package:planta_flutter/planta/plantHome.dart';
import 'file:///C:/projects/planta_flutter/lib/shared/colors.dart';
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
          appBar: AppBar(title: Text("Plantmagedon"), backgroundColor: AppColors.ThemeColor,
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                  onPressed: () async {
                    await _authService.signOut();
                  }, label: Text('Logout'), icon: Icon(Icons.person)),
              IconButton(onPressed: () {}, icon: Icon(Icons.calendar_today)),
              IconButton(onPressed: () => _showSettingsPanel(), icon: Icon(Icons.settings)),
            ],
          ), body: PlantHome(),
        ));
  }
}
