import 'package:flutter/material.dart';
import 'package:planta_flutter/screens/auth/register.dart';
import 'package:planta_flutter/screens/auth/logIn.dart';

class Auth extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LogIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
