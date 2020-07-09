import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planta_flutter/models/Plant_Alt.dart';
import 'package:planta_flutter/models/User.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference reference = Firestore.instance.collection('planta');

  Future updateUserData(String name, int frequency, String intensity) async {
    return await reference.document(uid).setData({'name': name, 'frequency': frequency, 'intensity': intensity});
  }

//  plant list from snapshot
  List<PlantALT> _plantListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return PlantALT(
          name: doc.data['name'] ?? '', intensity: doc.data['intensity'] ?? '', frequency: doc.data['frequency'] ?? 0);
    }).toList();
  }

  Stream<List<PlantALT>> get plants {
    return reference.snapshots().map(_plantListFromSnapshot);
  }

  Stream<UserData> get userData {
    return reference.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  UserData _userDataFromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserData(
      uid: documentSnapshot.data['uid'],
      name: documentSnapshot.data['name'],
      frequency: documentSnapshot.data['frequency'],
      intensity: documentSnapshot.data['intensity'],
    );
  }
}
