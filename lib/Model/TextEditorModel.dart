import 'package:flutter/material.dart';

class TextEditor {
  TextEditingController date;
  TextEditingController navigatorName;
  TextEditingController address;
  TextEditingController pname;
  TextEditingController paddress;
  TextEditingController diagnosis;
  TextEditingController note;
  TextEditingController pgender;
  TextEditingController pdob;
  TextEditingController comment;
  TextEditingController title;

  TextEditor() {
    date = TextEditingController();
    navigatorName = TextEditingController();
    address = TextEditingController();
    pname = TextEditingController();
    paddress = TextEditingController();
    diagnosis = TextEditingController();
    note = TextEditingController();
    pdob = TextEditingController();
    pgender = TextEditingController();
    comment = TextEditingController();
    title = TextEditingController();
  }
}
