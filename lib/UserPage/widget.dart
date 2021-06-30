import 'package:flutter/material.dart';
import 'package:ican_system/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

AppBar getAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    brightness: Brightness.light,
    backgroundColor: Colors.blueAccent,
    actions: [
      IconButton(
        icon: Icon(Icons.logout),
        onPressed: () async {
          await _auth.signOut();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (BuildContext context) => HomePage()),
              (route) => false);
        },
      )
    ],
  );
}
