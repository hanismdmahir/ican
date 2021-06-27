import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ican_system/UserManagementPage/signup.dart';
import 'package:ican_system/UserPage/PatientMainPage.dart';
import 'package:ican_system/UserPage/NavigatorMainPage.dart';
import 'package:ican_system/UserPage/DoctorMainPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  String _userEmail;
  var type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
          child: Form(
        key: _formKey,
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(15.0),
            children: <Widget>[
              Text(
                "Login",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please Enter Your Email';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please Enter Your Password';
                    }
                    return null;
                  },
                ),
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
                        _signInWithEmailAndPassword();
                      }
                    },
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    child: Text(
                      "Login",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return SignupPage();
                        },
                      )),
                      child: Text(
                        "Forget Password?",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                        onTap: () => Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return SignupPage();
                              },
                            )),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'New Here? Sign Up Now!',
                                style: TextStyle(
                                    color: Color(0xff06224A),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ]),
                        ))
                  ]),
            ]),
      )),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;

      if (user != null) {
        setState(() {
          _success = true;
          _userEmail = user.email;
        });

        var doc = FirebaseFirestore.instance.collection("user").doc(user.uid);

        DocumentSnapshot value = await doc.get();

        type = value['userType'];

        final snackBar = SnackBar(
          content: Text(user.email + ' Has Successfully Login ! '),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        if (type == 'Patient') {
          //navigate ke patient main page
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return PatientMainPage();
            },
          ));
        } else if (type == 'Doctor') {
          //navigate ke doctor main page
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return DoctorMainPage();
            },
          ));
        } else if (type == 'Navigator') {
          //navigate ke navigator main page
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return NavigatorMainPage();
            },
          ));
        }
      } else {
        setState(() {
          _success = false;
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
