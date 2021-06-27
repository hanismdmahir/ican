import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ican_system/CommunicationPage/ViewRecordPatientPage.dart';
import 'package:ican_system/CommunicationPage/recordPatient.dart';
import 'package:ican_system/Model/InteractionModel.dart';

class ListPatientRecord extends StatefulWidget {
  @override
  _ListPatientRecordState createState() => _ListPatientRecordState();
}

class _ListPatientRecordState extends State<ListPatientRecord> {
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  List<InteractionModel> interactionList = [];
  _ListPatientRecordState();

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> interaction =
        FirebaseFirestore.instance.collection('interaction').snapshots();

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
      body: StreamBuilder(
          stream: interaction,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              for (var i = 0; i < snapshot.data.docs.length; i++) {
                InteractionModel r = InteractionModel();
                r.title = snapshot.data.docs[i]['title'];
                r.date = snapshot.data.docs[i]['date'];
                r.comment = snapshot.data.docs[i]['comment'];
                r.patientName = snapshot.data.docs[i]['patientName'];
                r.feedback = snapshot.data.docs[i]['feedback'];
                r.id = snapshot.data.docs[i].reference.id;

                interactionList.add(r);
              }

              return ListView.builder(
                  itemCount: interactionList.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            width: 360,
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
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return ViewRecordPatientPage(
                                      interaction: interactionList[index],
                                    );
                                  },
                                ));
                              },
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                              child: Text(
                                interactionList[index].date +
                                    ':' +
                                    interactionList[index].title,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    );
                  });
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return RecordPatientPage();
          },
        )),
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
