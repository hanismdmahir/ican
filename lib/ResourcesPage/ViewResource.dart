import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ican_system/Model/ResourcesModel.dart';
import 'package:ican_system/ResourcesPage/DoctorListResource.dart';

final firestore = FirebaseFirestore.instance;

class ViewResourcePage extends StatelessWidget {
  final ResourcesModel resource;
  ViewResourcePage({Key key, @required this.resource}) : super(key: key);

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _comment = TextEditingController();
  final TextEditingController _id = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _title.text = resource.title;
    _description.text = resource.description;
    _comment.text = resource.comment;
    _id.text = resource.id;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          'Cancer Informations',
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
      body: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _title,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.category),
                  labelText: 'Title',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _description,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.calendar_today),
                  labelText: 'Description',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.file_download),
                  labelText: 'Uploaded File',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.record_voice_over_rounded),
                  labelText: 'Audio',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _comment,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.comment),
                  labelText: 'Comment',
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
                          deleteResource(_id.text);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DoctorListResource();
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
                          _updateResource(_id.text);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DoctorListResource();
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
    );
  }

  Future<void> deleteResource(String id) async {
    await FirebaseFirestore.instance.collection("resources").doc(id).delete();
  }

  void _updateResource(String id) async {
    await firestore.collection("resources").doc(id).update({
      'title': _title.text,
      'description': _description.text,
      'comment': _comment.text,
    });
  }
}
