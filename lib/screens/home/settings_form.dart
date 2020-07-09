import 'package:flutter/material.dart';
import 'package:planta_flutter/models/User.dart';
import 'package:planta_flutter/services/database.dart';
import 'package:planta_flutter/shared/constants.dart';
import 'package:planta_flutter/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> intensities = ['1', '2', '3'];

  String _currentName;
  String _currentIntensty;
  int _currentFrequency;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(children: <Widget>[
                Text(
                  'Update intenstity',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  initialValue: _currentName ?? userData.name,
                  decoration: textInputDecoration.copyWith(hintText: 'Name'),
                  validator: (value) => value.isEmpty ? 'Enter a name' : null,
                  onChanged: (value) => setState(() => _currentName = value),
                ),
                SizedBox(
                  height: 20.0,
                ),
                DropdownButtonFormField(
                  value: _currentIntensty ?? userData.intensity,
                  items: intensities.map((inten) {
                    return DropdownMenuItem(value: inten, child: Text('$inten intensity'));
                  }).toList(),
                  onChanged: (value) => setState(() => _currentIntensty = value),
                ),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text('Update'),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(_currentName ?? userData.name,
                          _currentFrequency ?? userData.frequency, _currentIntensty ?? userData.intensity);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
                Slider(
                  value: (_currentFrequency ?? 100).toDouble(),
                  activeColor: Colors.blue[_currentFrequency ?? 100],
                  min: 100,
                  max: 900,
                  divisions: 8,
                  onChanged: (value) => setState(() => _currentFrequency = value.round()),
                )
              ]),
            );
          } else {
            return Loading();
          }
        });
  }
}
