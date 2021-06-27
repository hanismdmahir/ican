import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ican_system/CommunicationPage/TrackInteraction.dart';
import 'package:ican_system/Model/ReportPatientModel.dart';

final firestore = FirebaseFirestore.instance;
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _date = TextEditingController();
final TextEditingController _navigatorName = TextEditingController();
final TextEditingController _address = TextEditingController();
final TextEditingController _pName = TextEditingController();
final TextEditingController _pAddress = TextEditingController();
final TextEditingController _pDob = TextEditingController();
final TextEditingController _diagnosis = TextEditingController();
final TextEditingController _note = TextEditingController();
final TextEditingController _remarks = TextEditingController();
final TextEditingController _pGender = TextEditingController();
String id;

class ViewReportNavigator extends StatefulWidget {
  final ReportPatientModel report;
  ViewReportNavigator({Key key, this.report}) : super(key: key);
  @override
  _ViewReportNavigatorState createState() => _ViewReportNavigatorState();
}

class _ViewReportNavigatorState extends State<ViewReportNavigator> {
  @override
  Widget build(BuildContext context) {
    _address.text = widget.report.address;
    _date.text = widget.report.date;
    _diagnosis.text = widget.report.diagnosis;
    _navigatorName.text = widget.report.navigatorName;
    _note.text = widget.report.note;
    _pAddress.text = widget.report.pAddress;
    _pDob.text = widget.report.pDob;
    _pGender.text = widget.report.pGender;
    _pName.text = widget.report.pName;
    _remarks.text = widget.report.remarks;
    id = widget.report.id;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: Text(
            'Interaction Report',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent),
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
        body: Form(
            key: _formKey,
            child: Container(
              child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(15.0),
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: new TextFormField(
                          controller: _date,
                          decoration: InputDecoration(
                              icon: const Icon(Icons.calendar_today),
                              labelText: 'Date of Interaction :',
                              contentPadding: EdgeInsets.all(10))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: new TextFormField(
                          controller: _navigatorName,
                          decoration: InputDecoration(
                              icon: const Icon(Icons.person),
                              labelText: 'Navigator Name :',
                              contentPadding: EdgeInsets.all(10))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: new TextFormField(
                          controller: _address,
                          decoration: InputDecoration(
                              icon: const Icon(Icons.home),
                              labelText: 'Interaction Address :',
                              contentPadding: EdgeInsets.all(10))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Patient's Information",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: new TextFormField(
                          controller: _pName,
                          decoration: InputDecoration(
                              icon: const Icon(Icons.person_outlined),
                              labelText: 'Name :',
                              contentPadding: EdgeInsets.all(10))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: new TextFormField(
                          controller: _pAddress,
                          decoration: InputDecoration(
                              icon: const Icon(Icons.home_outlined),
                              labelText: 'Address :',
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
                          child: new TextField(
                              controller: _pDob,
                              decoration: InputDecoration(
                                  icon:
                                      const Icon(Icons.calendar_today_outlined),
                                  labelText: 'DOB :',
                                  contentPadding: EdgeInsets.all(10))),
                        ),
                        SizedBox(
                          width: 150,
                          child: new TextField(
                              controller: _pGender,
                              decoration: InputDecoration(
                                  icon: const Icon(Icons.person),
                                  labelText: 'Gender :',
                                  contentPadding: EdgeInsets.all(10))),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: new TextFormField(
                          controller: _diagnosis,
                          decoration: InputDecoration(
                              icon: const Icon(Icons.note),
                              labelText: 'Diagnosis :',
                              contentPadding: EdgeInsets.all(10))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: new TextFormField(
                          controller: _note,
                          decoration: InputDecoration(
                              icon: const Icon(Icons.note_add_outlined),
                              labelText: 'Note :',
                              contentPadding: EdgeInsets.all(10))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: new TextFormField(
                          controller: _remarks,
                          readOnly: true,
                          decoration: const InputDecoration(
                              icon: const Icon(Icons.note_rounded),
                              labelText: 'Remarks From Doctor :',
                              contentPadding: EdgeInsets.all(10))),
                    ),
                    SizedBox(
                      height: 5,
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
                                    bottom: BorderSide(color: Colors.black),
                                    top: BorderSide(color: Colors.black),
                                    right: BorderSide(color: Colors.black),
                                    left: BorderSide(color: Colors.black))),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 60,
                              onPressed: () {
                                deleteReport(id);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return TrackInteraction();
                                }));
                              },
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                              child: Text(
                                "DELETE",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
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
                                    bottom: BorderSide(color: Colors.black),
                                    top: BorderSide(color: Colors.black),
                                    right: BorderSide(color: Colors.black),
                                    left: BorderSide(color: Colors.black))),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 60,
                              onPressed: () async {
                                _updateReport(id);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return TrackInteraction();
                                }));
                              },
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                              child: Text(
                                "UPDATE",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            )));
  }

  Future<void> deleteReport(String id) async {
    await FirebaseFirestore.instance
        .collection("patientReport")
        .doc(id)
        .delete();
  }

  void _updateReport(String id) async {
    await firestore.collection("patientReport").doc(id).update({
      'address': _address.text,
      'date': _date.text,
      'diagnosis': _diagnosis.text,
      'navigatorName': _navigatorName.text,
      'noted': _note.text,
      'pAddress': _pAddress.text,
      'pDob': _pDob.text,
      'pGender': _pGender.text,
      'pName': _pName.text,
    });
  }
}
