import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ican_system/CommunicationPage/ViewReport.dart';
import 'package:ican_system/Model/ReportPatientModel.dart';

List<ReportPatientModel> reportList = [];

class ListInteractionRecordDoctor extends StatefulWidget {
  @override
  _ListInteractionRecordDoctorState createState() =>
      _ListInteractionRecordDoctorState();
}

class _ListInteractionRecordDoctorState
    extends State<ListInteractionRecordDoctor> {
  _ListInteractionRecordDoctorState();

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> report =
        FirebaseFirestore.instance.collection('patientReport').snapshots();

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
        body: StreamBuilder(
            stream: report,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                reportList.clear();
                for (var i = 0; i < snapshot.data.docs.length; i++) {
                  ReportPatientModel r = ReportPatientModel();
                  r.address = snapshot.data.docs[i]['address'];
                  r.date = snapshot.data.docs[i]['date'];
                  r.diagnosis = snapshot.data.docs[i]['diagnosis'];
                  r.navigatorName = snapshot.data.docs[i]['navigatorName'];
                  r.note = snapshot.data.docs[i]['note'];
                  r.pAddress = snapshot.data.docs[i]['pAddress'];
                  r.pDob = snapshot.data.docs[i]['pDob'];
                  r.pGender = snapshot.data.docs[i]['pGender'];
                  r.pName = snapshot.data.docs[i]['pName'];
                  r.id = snapshot.data.docs[i].reference.id;

                  reportList.add(r);
                }

                return ListView.builder(
                    itemCount: reportList.length,
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewReport(
                                        report: reportList[index],
                                      ),
                                    ),
                                  );
                                },
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)),
                                child: Text(
                                  reportList[index].date +
                                      ' : ' +
                                      reportList[index].diagnosis,
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
                        ],
                      );
                    });
              }
            }));
  }
}
