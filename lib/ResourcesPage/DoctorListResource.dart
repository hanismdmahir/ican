import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ican_system/Model/ResourcesModel.dart';
import 'package:ican_system/ResourcesPage/CancerInformation.dart';
import 'package:ican_system/ResourcesPage/ViewResource.dart';

class DoctorListResource extends StatefulWidget {
  @override
  _DoctorListResourceState createState() => _DoctorListResourceState();
}

class _DoctorListResourceState extends State<DoctorListResource> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  List<ResourcesModel> resourcesList = [];
  _DoctorListResourceState();

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> resources =
        FirebaseFirestore.instance.collection('resources').snapshots();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          'Resource List',
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
          stream: resources,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              resourcesList.clear();
              for (var i = 0; i < snapshot.data.docs.length; i++) {
                ResourcesModel r = ResourcesModel();
                r.title = snapshot.data.docs[i]['title'];
                r.description = snapshot.data.docs[i]['description'];
                r.comment = snapshot.data.docs[i]['comment'];
                r.id = snapshot.data.docs[i].reference.id;

                resourcesList.add(r);
              }

              return ListView.builder(
                  itemCount: resourcesList.length,
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
                                    builder: (context) => ViewResourcePage(
                                      resource: resourcesList[index],
                                    ),
                                  ),
                                );
                              },
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                              child: Text(
                                resourcesList[index].title,
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
            return CancerInformationPage();
          },
        )),
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
