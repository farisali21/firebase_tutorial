import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_tutorial/constants/decoration.dart';
import 'package:flutter/material.dart';

import 'my_data.dart';

class FirestorePage extends StatefulWidget {
  final userUid;
  final userEmail;
  const FirestorePage(this.userUid, this.userEmail);

  @override
  _FirestorePageState createState() => _FirestorePageState();
}

class _FirestorePageState extends State<FirestorePage> {
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: name,
              keyboardType: TextInputType.name,
              onChanged: (_) {},
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'name',
                hintStyle: const TextStyle(color: Colors.black54),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: phoneNumber,
              keyboardType: TextInputType.name,
              onChanged: (_) {},
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Phone Number',
                hintStyle: const TextStyle(color: Colors.black54),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: address,
              keyboardType: TextInputType.name,
              onChanged: (_) {},
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'address',
                hintStyle: const TextStyle(color: Colors.black54),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(40),
              ),
              onPressed: () {
                print(widget.userUid);
                FirebaseFirestore firestore = FirebaseFirestore.instance;
                CollectionReference users = firestore.collection('users');
                final Map<String, dynamic> userData = {
                  'name': name.text,
                  'phone': phoneNumber.text,
                  'address': address.text,
                  'email': widget.userEmail,
                };
                users.doc(widget.userUid).set(userData);
              },
              child: Text('Set My Data'),
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(40),
              ),
              onPressed: () async {
                FirebaseFirestore firestore = FirebaseFirestore.instance;
                CollectionReference users = firestore.collection('users');

                final userData1 = await users.doc(widget.userUid).get();
                if(userData1['phone'] == null){
                  print('you Have no data');
                  return;
                }
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MyData(
                      name: userData1['name'],
                      phone: userData1['phone'],
                      address: userData1['address'],
                    ),
                  ),
                );
              },
              child: Text('getData'),
            ),
          ],
        ),
      ),
    );
  }
}
