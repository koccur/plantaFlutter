// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:planta_flutter/controllers/Camera.controller.dart';
import 'package:planta_flutter/planta/plantHome.dart';
import 'package:planta_flutter/screens/wrapper.dart';
import 'package:planta_flutter/services/auth.dart';
import 'package:provider/provider.dart';

import 'models/User.dart';
import 'planta/plantAdd.dart';
import 'package:planta_flutter/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(StreamProvider<User>.value(
    value: AuthService().user,
    child: MaterialApp(home: Wrapper()

//        dzialajace elementy
//    home: PlantHome(),
//    initialRoute: '/',
//    routes: {
//      '/addPlant': (context) => AddPlantRoute(),
//      '/takePhoto': (context) => TakePictureScreen(camera: firstCamera)
//    },
//    title: 'Plantmagedon',
//    theme: ThemeData(primaryColor: AppColors.ThemeColor),
        ),
  ));
}
