import 'package:flutter/material.dart';
import 'package:planta_flutter/models/Plant.dart';
import 'package:planta_flutter/models/User.dart';
import 'package:planta_flutter/planta/plant_home.dart';
import 'package:planta_flutter/screens/home/settings_form.dart';
import 'package:planta_flutter/services/auth.dart';
import 'package:planta_flutter/services/plant.dart';
import 'package:planta_flutter/shared/colors.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

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

    return StreamProvider<List<Plant>>.value(
        value: PlantService(userUid: user.uid).getPlantsByUserId(), child: Scaffold(appBar: AppBar(
      title: Text("Plantmagedon"),
      backgroundColor: AppColors.ThemeColor,
      elevation: 0.0,
      actions: <Widget>[
        FlatButton.icon(onPressed: () async {
          await _authService.signOut();
        }, label: Text('Logout'), icon: Icon(Icons.person)),
        IconButton(onPressed: () {}, icon: Icon(Icons.calendar_today)),
        IconButton(onPressed: () => _showSettingsPanel(), icon: Icon(Icons.settings)),
      ],), body: PlantHome2(),));
  }
}
