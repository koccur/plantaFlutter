import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planta_flutter/models/User.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference reference = Firestore.instance.collection('users');

  Future updateUserData(String name) async {
    return await reference.document(uid).setData({'name': name});
  }

  Stream<UserData> get userData {
    return reference.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  UserData _userDataFromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserData(
      uid: documentSnapshot.data['uid'],
      name: documentSnapshot.data['name'],
    );
  }
}
