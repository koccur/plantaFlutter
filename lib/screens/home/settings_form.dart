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
                RaisedButton(color: Colors.deepOrange[400],
                  child: Text('Update'),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await DatabaseService(uid: user.uid).updateUserName(_currentName ?? userData.name);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
              ]),
            );
          } else {
            return Loading();
          }
        });
  }
}
