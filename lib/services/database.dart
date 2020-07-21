import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planta_flutter/models/User.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference reference = Firestore.instance.collection('users');

  Future updateUserData(String email, String name) async {
    return await reference.document(uid).setData({'email': email, 'name': name});
  }

  Future updateUserName(String name) async {
    return await reference.document(uid).setData({'name': name});
  }

  Stream<UserData> get userData {
    return reference.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  UserData _userDataFromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserData(
      uid: documentSnapshot.data['uid'],
      email: documentSnapshot.data['email'],
      name: documentSnapshot.data['name'],
    );
  }
}
