// ignore_for_file: unused_element

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_utopia/model/user.dart';
import 'package:flutter_application_utopia/screens/getstarted_screen.dart';
import 'package:flutter_application_utopia/screens/imageuploadtest.dart';
import 'package:flutter_application_utopia/screens/signin_screen.dart';
import 'package:get/get.dart';

import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

DateTime SelectedDate = DateTime(2021);
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
      Get.offAll(GetStartedPage());
    }
  } catch (e) {
    print(e);
    Get.snackbar("Alert !", e.toString());
  }
}

///file upload profile
var task;
Future uploadFile(file) async {
  if (file == null) return;
  print(file);
  SharedPreferences pref = await SharedPreferences.getInstance();
  var name = pref.getString("email");
  var uid = pref.getString("uid");
  final fileName = name;
  final destination = 'profileimages/$fileName';

  try {
    final ref = FirebaseStorage.instance.ref(destination);
    print(name);
    var jsonMap = await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: name!)
        .get();

    print(jsonMap.docs);

    Users u = Users.fromMap(jsonMap.docs[0].data());
    print(u);

    u.pic = name!;

    var jsonUpdated = u.toMap();

    FirebaseFirestore.instance.collection("users").doc(uid).update(jsonUpdated);
    return ref.putFile(file);
  } on FirebaseException catch (e) {
    Get.snackbar("Error", "$e");
    print(e);
    return null;
  }

  //if (task == null) return;

  // final snapshot = await task!.whenComplete(() {});
  // final urlDownload = await snapshot.ref.getDownloadURL();

  // print('Download-Link: $urlDownload');
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
