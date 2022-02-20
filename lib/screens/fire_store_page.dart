import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_tutorial/constants/decoration.dart';
import 'package:flutter/material.dart';

class Firestore extends StatefulWidget {
  const Firestore({Key? key}) : super(key: key);

  @override
  _FirestoreState createState() => _FirestoreState();
}

class _FirestoreState extends State<Firestore> {
  TextEditingController collection = TextEditingController();
  TextEditingController data = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: collection,
              keyboardType: TextInputType.name,
              onChanged: (_) {},
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Collection',
                hintStyle: const TextStyle(color: Colors.black54),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: data,
              keyboardType: TextInputType.name,
              onChanged: (_) {},
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'data',
                hintStyle: const TextStyle(color: Colors.black54),
              ),
            ),
            SizedBox(
              height: 20
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(40),
              ),
              onPressed: () {
                FirebaseFirestore firestore = FirebaseFirestore.instance;
                CollectionReference users = firestore.collection('users');
                final Map<String, dynamic> userData = {
                  'data': data.text,
                };
                users.doc(collection.text).set(userData);
              },
              child: Text('Add'),
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(40),
              ),
              onPressed: () async {
                FirebaseFirestore firestore = FirebaseFirestore.instance;
                CollectionReference users = firestore.collection('users');
                final Map<String, dynamic> userData = {
                  'data': data.text,
                };
                final userData1 = await users.doc(collection.text).get();
                print(userData1['data']);
              },
              child: Text('getData'),
            ),
          ],
        ),
      ),
    );
  }
}
