import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ican_system/Model/UserModel.dart';
import 'package:ican_system/UserManagementPage/ResetPassword.dart';
import 'package:image_picker/image_picker.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
UserModel user = UserModel();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _fullname = TextEditingController();
final TextEditingController _age = TextEditingController();
final TextEditingController _dob = TextEditingController();
final TextEditingController _username = TextEditingController();
final TextEditingController _contactnum = TextEditingController();
final TextEditingController _email = TextEditingController();
final TextEditingController _password = TextEditingController();
final firestore = FirebaseFirestore.instance;

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  PickedFile imageFile;
  Future _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.blueAccent,
          title: Text(
            'Update Profile',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.black,
              )),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("user")
                .doc(_auth.currentUser.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text('Loading...'),
                );
              } else {
                user.username = snapshot.data['username'];
                user.email = snapshot.data['email'];
                user.password = snapshot.data['password'];
                user.dob = snapshot.data['DOB'];
                user.age = snapshot.data['age'];
                user.fullname = snapshot.data['fullname'];
                user.contactNumber = snapshot.data['contactNumber'];

                _username.text = user.username;
                _email.text = user.email;
                _password.text = user.password;
                _dob.text = user.dob;
                _age.text = user.age;
                _fullname.text = user.fullname;
                _contactnum.text = user.contactNumber;

                return Form(
                    key: _formKey,
                    child: Container(
                      child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(15.0),
                          children: <Widget>[
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                                height: 80,
                                width: 80,
                                child: Column(
                                  children: [
                                    Card(
                                      child: (imageFile == null)
                                          ? Text("Choose Image")
                                          : Image.file(File(imageFile.path)),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        _showChoiceDialog(context);
                                      },
                                      child: Text("Select Image"),
                                    ),
                                  ],
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: new TextFormField(
                                  controller: _username,
                                  decoration: InputDecoration(
                                      icon: const Icon(Icons.person),
                                      labelText: 'Username ',
                                      contentPadding: EdgeInsets.all(10))),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: new TextFormField(
                                  controller: _fullname,
                                  decoration: InputDecoration(
                                      icon: const Icon(
                                          Icons.supervised_user_circle),
                                      labelText: 'Full Name',
                                      contentPadding: EdgeInsets.all(10))),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 150,
                                  child: TextField(
                                      controller: _age,
                                      decoration: InputDecoration(
                                          icon: const Icon(Icons
                                              .confirmation_number_outlined),
                                          labelText: 'Age',
                                          contentPadding: EdgeInsets.all(10))),
                                ),
                                SizedBox(
                                    width: 150,
                                    child: TextField(
                                        controller: _dob,
                                        decoration: InputDecoration(
                                            icon: const Icon(
                                                Icons.calendar_today_outlined),
                                            labelText: 'DOB',
                                            contentPadding:
                                                EdgeInsets.all(10)))),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: new TextFormField(
                                  controller: _contactnum,
                                  decoration: InputDecoration(
                                      icon: const Icon(Icons.phone_android),
                                      labelText: 'Contact Number',
                                      contentPadding: EdgeInsets.all(10))),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Container(
                                    width: 150,
                                    padding: EdgeInsets.only(top: 3, left: 3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                        border: Border(
                                            bottom:
                                                BorderSide(color: Colors.black),
                                            top:
                                                BorderSide(color: Colors.black),
                                            right:
                                                BorderSide(color: Colors.black),
                                            left: BorderSide(
                                                color: Colors.black))),
                                    child: MaterialButton(
                                      minWidth: double.infinity,
                                      height: 60,
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                ResetPassword());
                                      },
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0)),
                                      child: Text(
                                        "RESET PASSWORD",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Container(
                                    width: 150,
                                    padding: EdgeInsets.only(top: 3, left: 3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                        border: Border(
                                            bottom:
                                                BorderSide(color: Colors.black),
                                            top:
                                                BorderSide(color: Colors.black),
                                            right:
                                                BorderSide(color: Colors.black),
                                            left: BorderSide(
                                                color: Colors.black))),
                                    child: MaterialButton(
                                      minWidth: double.infinity,
                                      height: 60,
                                      onPressed: () {},
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0)),
                                      child: Text(
                                        "RESET EMAIL",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Container(
                                padding: EdgeInsets.only(top: 3, left: 3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    border: Border(
                                        bottom: BorderSide(color: Colors.black),
                                        top: BorderSide(color: Colors.black),
                                        right: BorderSide(color: Colors.black),
                                        left: BorderSide(color: Colors.black))),
                                child: MaterialButton(
                                  minWidth: double.infinity,
                                  height: 60,
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      _updateUserInfo();
                                    }
                                  },
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0)),
                                  child: Text(
                                    "SAVE",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ]),
                    ));
              }
            }));
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile;
    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile;
    });
    Navigator.pop(context);
  }
}

void _updateUserInfo() async {
  try {
    await firestore.collection("user").doc(_auth.currentUser.uid).update({
      'username': _username.text,
      'fullname': _fullname.text,
      'age': _age.text,
      'DOB': _dob.text,
      'contactNumber': _contactnum.text,
    });
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}
