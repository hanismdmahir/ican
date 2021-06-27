import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ican_system/CommunicationPage/ListInteractionReportForDoctor.dart';
import 'package:ican_system/HomePage.dart';
import 'package:ican_system/Model/UserModel.dart';
import 'package:ican_system/ResourcesPage/DoctorListResource.dart';
import 'package:ican_system/UserManagementPage/UpdateProfile.dart';
import 'package:ican_system/AppoinmentPage/ScheduleAppoinment.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
UserModel user = UserModel();

class DoctorMainPage extends StatefulWidget {
  @override
  _DoctorMainPageState createState() => _DoctorMainPageState();
}

class _DoctorMainPageState extends State<DoctorMainPage> {
  final double runSpacing = 4;
  final double spacing = 4;
  final int listSize = 4;
  final columns = 2;

  @override
  Widget build(BuildContext context) {
    final w = (MediaQuery.of(context).size.width - runSpacing * (columns - 1)) /
        columns;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("user")
          .doc(_auth.currentUser.uid)
          .snapshots(),
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
              appBar: AppBar(
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
                          MaterialPageRoute(
                              builder: (BuildContext context) => HomePage()),
                          (route) => false);
                    },
                  )
                ],
              ),
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
                          return AppointmentPage();
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
                              'assets/icons/kindle.png',
                              width: 50.0,
                              height: 50.0,
                              fit: BoxFit.cover,
                            ),
                            Text('Appointment Details')
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ListInteractionRecordDoctor();
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
                              'assets/icons/folder.png',
                              width: 50.0,
                              height: 50.0,
                              fit: BoxFit.cover,
                            ),
                            Text('Interaction Report')
                          ],
                        ),
                      ),
                    ),
                  ]),
                  Row(children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return DoctorListResource();
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
                              'assets/icons/plus.png',
                              width: 50.0,
                              height: 50.0,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              'Cancer & Treatment Information',
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    )
                  ]),
                ]),
              ));
        }
      },
    );
  }
}
