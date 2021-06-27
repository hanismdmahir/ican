/* import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
bool passGood = true;
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

final TextEditingController _old = TextEditingController();
final TextEditingController _new = TextEditingController();
final TextEditingController _newrepeat = TextEditingController();

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        scrollable: true,
        title: Text('Feedback'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel')),
          TextButton(onPressed: () async {}, child: Text('Reset')),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        content: Form(
            key: _formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextFormField(
                controller: _old,
                obscureText: true,
                validator: (value) {
                  return value.isNotEmpty ? null : "Enter the Current Password";
                },
                decoration: InputDecoration(
                    hintText: "Current Password",
                    errorText: (passGood) ? null : "Wrong Password"),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _new,
                obscureText: true,
                validator: (value) {
                  return value.isNotEmpty ? null : "Enter the New Password";
                },
                decoration: InputDecoration(hintText: "New Password"),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _newrepeat,
                obscureText: true,
                validator: (value) {
                  if (value.isNotEmpty) {
                    if (_new.text == value) {
                      return null;
                    } else {
                      return 'Repeat Password is not correct';
                    }
                  } else {
                    return "Repeat the New Password";
                  }
                },
                decoration: InputDecoration(hintText: "Repeat New Password"),
              ),
              SizedBox(height: 15),
            ])));
  }
}

/* void _insertFeedback() async {
  try {
    await firestore
        .collection("interaction")
        .doc(_auth.currentUser.uid)
        .update({
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
} */
 */
