import 'package:flutter/material.dart';
import 'package:planta_flutter/services/auth.dart';
import 'package:planta_flutter/shared/colors.dart';
import 'package:planta_flutter/shared/constants.dart';
import 'package:planta_flutter/shared/loading.dart';

class LogIn extends StatefulWidget {
  final Function toggleView;
  LogIn({this.toggleView});

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(backgroundColor: AppColors.ThemeColor,
              elevation: 0.0,
              title: Text('Plantmagedon'),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text("Register"))
              ],
            ),
            body: Container(padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Column(children: <Widget>[
                  SizedBox(height: 20,),
                  Text('LOGIN', style: TextStyle(fontSize: 28),),
                  Form(key: _formKey,
                    child: Column(children: <Widget>[
                      SizedBox(height: 20),
                      TextFormField(decoration: textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (value) => value.isEmpty ? 'Enter an email' : null,
                        onChanged: (value) => setState(() => email = value),),
                      SizedBox(height: 20,),
                      TextFormField(decoration: textInputDecoration.copyWith(hintText: 'Password'),
                        obscureText: true,
                        validator: (value) => value.length < 6 ? 'Enter a password with min 6 chars long' : null,
                        onChanged: (value) => setState(() => password = value),),
                      SizedBox(height: 20,),
                      RaisedButton(color: Colors.pink[400],
                        child: Text("Sign in", style: TextStyle(color: Colors.white),),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _authService.signInViaEmail(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'problem with sigin';
                                loading = false;
                              });
                            }
                          }
//                  _authService.signInAnon()
                          },
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ])),
          );
  }
}
