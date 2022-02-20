import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase{

  final String uid;
  DataBase({ required this.uid });

  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future<void> updateUserData(String sugars, String name, int strength) async {
  return await brewCollection.doc(uid).set({
  'sugars': sugars,
  'name': name,
  'strength': strength,
  });
}
}