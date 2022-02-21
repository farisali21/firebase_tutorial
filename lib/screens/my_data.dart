import 'package:flutter/material.dart';

class MyData extends StatelessWidget {
  final name;
  final phone;
  final address;
  const MyData({this.address, this.name, this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Card(
              child: Column(
                children: [
                  Card(
                    child: Text('User Details', style: TextStyle(fontSize: 30),),
                    color: Colors.amber,
                    elevation: 8,
                  ),
                  Text(name,  style: TextStyle(fontSize: 30),),
                  Text(phone,  style: TextStyle(fontSize: 30),),
                  Text(address,  style: TextStyle(fontSize: 30),),
                ],
              ),
            ),
      ),

    );
  }
}
