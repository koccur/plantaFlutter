import 'package:flutter/material.dart';
import 'package:planta_flutter/models/User.dart';
import 'package:planta_flutter/screens/home/home.dart';
import 'package:provider/provider.dart';

import 'auth/auth.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    if (user != null) {
      return Home();
    }
    return Auth();
  }
}
