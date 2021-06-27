import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ican_system/CommunicationPage/ListPatientRecord.dart';
import 'package:ican_system/Model/InteractionModel.dart';

final firestore = FirebaseFirestore.instance;

class ViewRecordPatientPage extends StatefulWidget {
  final InteractionModel interaction;
  ViewRecordPatientPage({Key key, @required this.interaction})
      : super(key: key);
  @override
  _ViewRecordPatientPageState createState() => _ViewRecordPatientPageState();
}

class _ViewRecordPatientPageState extends State<ViewRecordPatientPage> {
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _patientNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _feedback = TextEditingController();
  String id;
  @override
  Widget build(BuildContext context) {
    _commentController.text = widget.interaction.comment;
    _titleController.text = widget.interaction.title;
    _patientNameController.text = widget.interaction.patientName;
    _dateController.text = widget.interaction.date;
    _feedback.text = widget.interaction.feedback;
    id = widget.interaction.id;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: Text(
            'Patient Record',
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
          child: Container(
            child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(15.0),
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.category),
                      hintText: 'Enter Title',
                      labelText: 'Title',
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter Title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _dateController,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.calendar_today),
                      hintText: 'Enter Date',
                      labelText: 'Date',
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter Date';
                      }
                      return null;
                    },
                    //  onTap: () => _selectDate(context),
                    // textInputAction: const TextInputAction("${selectedDate.toLocal()}".split(' ')[0]),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _patientNameController,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter Your Patient Name',
                      labelText: 'Patient Name',
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter Patient Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.photo_camera, color: Colors.deepOrange),
                      Icon(Icons.cloud_upload, color: Colors.green[500]),
                      Icon(Icons.upload_file, color: Colors.green[500]),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.record_voice_over_rounded),
                      hintText: 'Record Audio',
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.comment),
                      hintText: 'Write Your Comment',
                      labelText: 'Comment',
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter Comment';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _feedback,
                    readOnly: true,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.comment),
                      hintText: 'Patient Feedback',
                      labelText: 'Feedback',
                    ),
                  ),
                  SizedBox(
                    height: 30,
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
                              deleteInteraction(id);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ListPatientRecord();
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
                              _updateInteraction(id);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ListPatientRecord();
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
          ),
        ));
  }

  Future<void> deleteInteraction(String id) async {
    await FirebaseFirestore.instance.collection("interaction").doc(id).delete();
  }

  void _updateInteraction(String id) async {
    await firestore.collection("interaction").doc(id).update({
      'comment': _commentController.text,
      'title': _titleController.text,
      'patientName': _patientNameController.text,
      'date': _dateController.text
    });
  }
}
