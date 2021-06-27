import 'package:flutter/material.dart';
import 'package:ican_system/UserPage/NavigatorMainPage.dart';
import 'package:ican_system/operation.dart';

class RecordPatientPage extends StatefulWidget {
  final String title = 'Registration';
  @override
  _RecordPatientPageState createState() => _RecordPatientPageState();
}

class _RecordPatientPageState extends State<RecordPatientPage> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _patientNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String _comment;
  String _title;
  String _patientName;
  String _date;

  /* DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      // setState(() {
      selectedDate = picked;
    // });
  } */

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
        child: Column(
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
                controller: _dateController,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.calendar_today),
                  hintText: 'Enter Date',
                  labelText: 'Date',
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
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
                      _insertInteraction();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return NavigatorMainPage();
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

              //      Text("${selectedDate.toLocal()}".split(' ')[0]),
              //  SizedBox(height: 20.0,),
              //   ElevatedButton(
              //     onPressed: () => _selectDate(context),
              //   child: Text('Select date'),
              // ),
            ]),
      ),
    );
  }

  void _insertInteraction() async {
    setState(() {
      _comment = _commentController.text;
      _patientName = _patientNameController.text;
      _date = _dateController.text;
      _title = _titleController.text;
    });

    //insertdatabase
    insertDatainteraction(_comment, _patientName, _date, _title);
  }
}
