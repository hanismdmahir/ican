import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> insertDataUser(String _email, String _password, String _usertype,
    String _username, String uid) async {
  await FirebaseFirestore.instance.collection("user").doc(uid).set({
    'email': _email,
    'password': _password,
    'userType': _usertype,
    'username': _username,
    'uid': uid,
    'fullname': " ",
    'DOB': " ",
    "age": " ",
    "contactNumber": " "
  });
}

Future<void> insertDatainteraction(
    String _comment, String _patientName, String _date, String _title) async {
  await FirebaseFirestore.instance.collection("interaction").add({
    'comment': _comment,
    'date': _date,
    'patientName': _patientName,
    'title': _title,
    'feedback': ''
  });
}

Future<void> insertDataResources(
    String _comment, String _description, String _title) async {
  await FirebaseFirestore.instance.collection("resources").add({
    'comment': _comment,
    'description': _description,
    'title': _title,
  });
}

Future<void> editUserData(
    String _email, String _password, String _username, String id) async {
  // await FirebaseFirestore.instance.collection("user").document(id).updateData(
  //     {"email": _email}, {"password": _password}, {"username": _username});
}

Future<void> deleteUser(DocumentSnapshot doc) async {
//  await FirebaseFirestore.instance.collection("user").document(doc.documentID).delete();
}

Future<DocumentSnapshot> getUserData(String uid) async{
  return await FirebaseFirestore.instance.collection("user").doc(uid).get();
}

Stream<DocumentSnapshot> getUserDataStream(String uid) {
  return FirebaseFirestore.instance.collection("user").doc(uid).snapshots();
}
