import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ican_system/CommunicationPage/ListInteractionReportForDoctor.dart';
import 'package:ican_system/Model/InteractionModel.dart';
import 'package:ican_system/Model/TextEditorModel.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditor _controller = new TextEditor();

final listOfUser = ["Female", "Male"];
String dropdownValue = 'Male';

class CreateInteractionReport extends StatefulWidget {
  final InteractionModel interaction;

  CreateInteractionReport({Key key, this.interaction}) : super(key: key);
  @override
  _CreateInteractionReportState createState() =>
      _CreateInteractionReportState();
}

class _CreateInteractionReportState extends State<CreateInteractionReport> {
  @override
  Widget build(BuildContext context) {
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
                          controller: _controller.date,
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
                          controller: _controller.navigatorName,
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
                          controller: _controller.address,
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
                          controller: _controller.pname,
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
                          controller: _controller.paddress,
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
                              controller: _controller.pdob,
                              decoration: InputDecoration(
                                  icon:
                                      const Icon(Icons.calendar_today_outlined),
                                  labelText: 'DOB :',
                                  contentPadding: EdgeInsets.all(10))),
                        ),
                        SizedBox(
                          width: 150,
                          child: new TextField(
                              controller: _controller.pgender,
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
                          controller: _controller.diagnosis,
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
                          controller: _controller.note,
                          decoration: InputDecoration(
                              icon: const Icon(Icons.note_add_outlined),
                              labelText: 'Note :',
                              contentPadding: EdgeInsets.all(10))),
                    ),
                    SizedBox(
                      height: 5,
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
                              _createInteractionReport();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ListInteractionRecordDoctor();
                              }));
                            }
                          },
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)),
                          child: Text(
                            "SAVE",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ]),
            )));
  }
}

Future<void> _createInteractionReport() async {
  await FirebaseFirestore.instance.collection("patientReport").add({
    'date': _controller.date.text,
    'address': _controller.address.text,
    'diagnosis': _controller.diagnosis.text,
    'navigatorName': _controller.navigatorName.text,
    'note': _controller.note.text,
    'pAddress': _controller.paddress.text,
    'pDob': _controller.pdob.text,
    'pName': _controller.pname.text,
    'pGender': _controller.pgender.text
  });
}
