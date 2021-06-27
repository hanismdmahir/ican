import 'package:flutter/material.dart';
import 'package:ican_system/ResourcesPage/DoctorListResource.dart';
import 'package:ican_system/operation.dart';

class CancerInformationPage extends StatefulWidget {
  @override
  _CancerInformationState createState() => _CancerInformationState();
}

class _CancerInformationState extends State<CancerInformationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _comment;
  String _title;
  String _description;
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
          'Cancer Information',
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
        child: Column(
            key: _formKey,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 30,
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
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.calendar_today),
                  hintText: 'Enter Description',
                  labelText: 'Description',
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
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
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
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
                      _insertInfo();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DoctorListResource();
                      }));
                    },
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    child: Text(
                      "SAVE",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                ),
              )
            ]),
      ),
    );
  }

  void _insertInfo() async {
    setState(() {
      _comment = _commentController.text;
      _description = _descriptionController.text;
      _title = _titleController.text;
    });

    //insertdatabase
    insertDataResources(_comment, _description, _title);
  }
}
