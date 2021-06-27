//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ican_system/Model/InteractionModel.dart';
import 'package:quick_feedback/quick_feedback.dart';

class ListInteractionRecord extends StatefulWidget {
  ListInteractionRecord(this.fullname);
  final String fullname;
  @override
  _ListInteractionRecordState createState() => _ListInteractionRecordState();
}

class _ListInteractionRecordState extends State<ListInteractionRecord> {
  List<InteractionModel> interactionList = [];
  _ListInteractionRecordState();

  @override
  Widget build(BuildContext context) {
    //  Stream<QuerySnapshot> interaction = FirebaseFirestore.instance
    //       .collection('interaction')
    //      .where('patientName', isEqualTo: fullname)
    //       .snapshots();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: Text(
            'Interaction Record',
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
            stream: FirebaseFirestore.instance
                .collection('interaction')
                .where('patientName', isEqualTo: widget.fullname)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                for (var i = 0; i < snapshot.data.docs.length; i++) {
                  InteractionModel r = InteractionModel();
                  r.title = snapshot.data.docs[i]['title'];
                  r.patientName = snapshot.data.docs[i]['patientName'];
                  r.comment = snapshot.data.docs[i]['comment'];
                  r.date = snapshot.data.docs[i]['date'];
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
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return QuickFeedback(
                                        title:
                                            'Leave a feedback', // Title of dialog
                                        showTextBox: true, // default false
                                        textBoxHint:
                                            'Share your feedback', // Feedback text field hint text default: Tell us more
                                        submitText:
                                            'SUBMIT', // submit button text default: SUBMIT
                                        onSubmitCallback: (feedback) {
                                          insertFeedback(
                                              feedback['rating'],
                                              feedback['feedback'],
                                              interactionList[index]
                                                  .id); // map { rating: 2, feedback: 'some feedback' }
                                          Navigator.of(context).pop();
                                        },
                                        askLaterText: 'ASK LATER',
                                        onAskLaterCallback: () {
                                          print(
                                              'Do something on ask later click');
                                        },
                                      );
                                    },
                                  );
                                },
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)),
                                child: Text(
                                  interactionList[index].date +
                                      ':' +
                                      interactionList[index].title,
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

Future<void> insertFeedback(int rating, String feedback, String id) async {
  await FirebaseFirestore.instance.collection("interaction").doc(id).update({
    'rating': rating,
    'feedback': feedback,
  });
}
