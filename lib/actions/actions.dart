// ignore_for_file: unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

String SelectedDate = 'null';
funSignIp(email, pass) {
  FirebaseFirestore.instance
      .collection("users")
      .where("email", isEqualTo: email)
      .get();
}

funcSignUp(email, pass, Map<String, dynamic> userJson) async {
  try {
    User? user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: pass,
    ))
        .user;
    if (user != null) {
      print(user);
      FirebaseFirestore.instance.collection("users").add(userJson);
    }
  } catch (e) {
    print(e);
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

String? validateName(String value) {
  if (value.isEmpty) {
    return "Name should not be empty";
  }
  return null;
}

///Date picker
class Date extends StatefulWidget {
  const Date({Key? key}) : super(key: key);

  @override
  _dateState createState() => _dateState();
}

class _dateState extends State<Date> {
  late DatePickerController _controller;
  DateTime _selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    _controller = DatePickerController(
        initialDateTime: DateTime.now(), minYear: 1952, maxYear: 2025);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DOB"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 150.0,
            alignment: Alignment.center,
            child: Text(
              "$_selectedDate",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
            ),
          ),
          ScrollDatePicker(
            controller: _controller,
            locale: DatePickerLocale.en_us,
            pickerDecoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent, width: 2.0)),
            config: DatePickerConfig(
                isLoop: true,
                selectedTextStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 17.0)),
            onChanged: (value) {
              setState(() {
                _selectedDate = value;
                SelectedDate = _selectedDate.toString();
              });
            },
          ),
        ],
      ),
    );
  }
}
