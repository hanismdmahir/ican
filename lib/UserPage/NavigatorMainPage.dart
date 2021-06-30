import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ican_system/CommunicationPage/ListPatientRecord.dart';
import 'package:ican_system/CommunicationPage/TrackInteraction.dart';
import 'package:ican_system/Model/UserModel.dart';
import 'package:ican_system/UserManagementPage/UpdateProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ican_system/UserPage/widget.dart';

import '../operation.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
UserModel user = UserModel();

class NavigatorMainPage extends StatefulWidget {
  @override
  _NavigatorMainPageState createState() => _NavigatorMainPageState();
}

class _NavigatorMainPageState extends State<NavigatorMainPage> {
  final double runSpacing = 4;
  final double spacing = 4;
  final int listSize = 4;
  final columns = 2;

  @override
  Widget build(BuildContext context) {
    final w = (MediaQuery.of(context).size.width - runSpacing * (columns - 1)) /
        columns;
    return StreamBuilder(
      stream: getUserDataStream(_auth.currentUser.uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: LinearProgressIndicator());
        } else {
          user.username = snapshot.data['username'];
          user.email = snapshot.data['email'];
          user.password = snapshot.data['password'];
          user.fullname = snapshot.data['fullname'];

          return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              appBar: getAppBar(context),
              body: Container(
                child: Column(children: <Widget>[
                  SizedBox(height: 50),
                  Stack(alignment: Alignment.center, children: <Widget>[
                    Container(
                        height: 50,
                        width: 50,
                        child:
                            Image.asset('assets/icons/administrator-male.png')),
                  ]),
                  Stack(alignment: Alignment.center, children: <Widget>[
                    Text(user.username),
                  ]),
                  Stack(alignment: Alignment.center, children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.blue,
                      ),
                      margin: EdgeInsets.all(10),
                      width: 120,
                      height: 30,
                      child: ElevatedButton(
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return UpdateProfilePage();
                            },
                          ));
                        },
                      ),
                    ),
                  ]),
                  new Divider(height: 5.0, color: Colors.black),
                  Row(children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ListPatientRecord();
                        },
                      )),
                      child: Container(
                        width: w,
                        height: w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            new Image.asset(
                              'assets/icons/notepad.png',
                              width: 50.0,
                              height: 50.0,
                              fit: BoxFit.cover,
                            ),
                            Text('Patient Interaction')
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return TrackInteraction();
                        },
                      )),
                      child: Container(
                        width: w,
                        height: w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            new Image.asset(
                              'assets/icons/print.png',
                              width: 50.0,
                              height: 50.0,
                              fit: BoxFit.cover,
                            ),
                            Text('Interaction Report')
                          ],
                        ),
                      ),
                    )
                  ])
                ]),
              ));
        }
      },
    );
  }

  
}
