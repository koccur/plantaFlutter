// A screen that takes in a list of cameras and the Directory to store images.
import 'dart:io';
import 'dart:async';

import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:planta_flutter/models/Plant.dart';

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  // Add two variables to the state class to store the CameraController and
  // the Future.
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  Plant _plant;

  @override
  void initState() {
    super.initState();
    // To display the current output from the camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera, // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next steps.
    _plant = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text('Take a picture of your plant')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt), // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Construct the path where the image should be saved using the
            // pattern package.
            final directory = await getApplicationDocumentsDirectory();
            final path = join(directory.path, _plant.uid != null ? '${_plant.uid}.png' : 'tempId.png',);
            File file = File(path);
            // Attempt to take a picture and log where it's been saved.
            await (file.delete()).whenComplete(() {
              _controller.takePicture(path);
              _uploadPhotoViaFireBase(path);
            });

//            // If the picture was taken, display it on a new screen.
//            Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) => DisplayPictureScreen(imagePath: path),
//              ),
//            Navigator.of(context).pop(true);
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },),);
  }

  Future _uploadPhotoViaFireBase(String temporaryPath) async {
    if (_plant.uid != null) {
      final path = '${_plant.uid}.png';
      StorageReference storageReference = FirebaseStorage.instance.ref().child(path);

      File file = File(temporaryPath);
      StorageUploadTask uploadTask = storageReference.putFile(file);
      await uploadTask.onComplete;
      print('File uploaded');
      storageReference.getDownloadURL().then((url) => setStateAndPop(temporaryPath));
    } else {
      setStateAndPop(temporaryPath);
    }
  }

  void setStateAndPop(String path) {
    setState(() {
      _plant.picture = path;
      Navigator.pop(context, true);
    });
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(
        children: <Widget>[
          Image.file(File(imagePath)),
          RaisedButton(
            onPressed: () => {
              Navigator.popAndPushNamed(context, '/addPlant', arguments: imagePath),
            },
            child: Text('Save an image'),
          )
        ],
      ),
    );
  }
}
