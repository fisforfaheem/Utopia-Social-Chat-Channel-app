// ignore_for_file: unused_element, unused_import

import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_utopia/model/friends.dart';
import 'package:flutter_application_utopia/model/server.dart';
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

// add friend
addFiendAction(fromemail, toemail) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String email = pref.getString("email")?.toString() ?? "";
  print("\n\n\n\\n\n\n");

  print(toemail);
  toemail =
      toemail.toString().toString().split(',')[5].replaceAll("email: ", "");
  if (email != "" && email != "null" && email != null)
    await FirebaseFirestore.instance.collection("friends").add({
      "fromEmail": email.toString(),
      "toemail": toemail.toString(),
    });
}

Future<List> getAllFriends() async {
  var alreadyFriends =
      await FirebaseFirestore.instance.collection("friends").get();
  List data = [];
  alreadyFriends.docs.forEach((element) {
    data.add(element.data());
  });
  return data;
}

///searching
Future<List<Search>> getSearch(txt) async {
  List<Search> data = [];

  var alreadyFriends =
      await FirebaseFirestore.instance.collection("friends").get();

  var isfound = await FirebaseFirestore.instance
      .collection("channel")
      .where("name", isGreaterThanOrEqualTo: txt)
      .get();
  //print(isfound);
  if (isfound.docs.length > 0) {
    isfound.docs.forEach((element) {
      var abc = null;
      if (alreadyFriends.docs.length > 0)
        try {
          abc = alreadyFriends.docs.firstWhere(
              (fe) => fe.data()['toemail'] == element.data()['name']);
        } catch (e) {}
      if (abc == null)
        data.add(Search(
            name: element.data()['name'], type: "channel  ${element.data()}"));
    });
  }
  isfound = await FirebaseFirestore.instance
      .collection("server")
      .where("name", isGreaterThanOrEqualTo: txt)
      .get();
  if (isfound.docs.length > 0) {
    isfound.docs.forEach((element) {
      var abc = null;
      if (alreadyFriends.docs.length > 0)
        try {
          abc = alreadyFriends.docs.firstWhere(
              (fe) => fe.data()['toemail'] == element.data()['name']);
        } catch (e) {}
      if (abc == null)
        data.add(Search(
            name: element.data()['name'], type: "server ${element.data()}"));
    });
  }

  // isfound = await FirebaseFirestore.instance
  //     .collection("users")
  //     .where("username", isGreaterThanOrEqualTo: txt)
  //     .get();
  SharedPreferences pref = await SharedPreferences.getInstance();
  String email = pref.getString("email") ?? "";
  final QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('users').get();
  final List<DocumentSnapshot> documents = querySnapshot.docs;
  final List<DocumentSnapshot> founded = documents
      .where((element) => element.data.toString().contains('$txt'))
      .toList();

  documents.forEach((element) {
    var d = jsonEncode(element.data()!);
    var jsonData = jsonDecode(d);
    print(jsonData);
    if (jsonData.toString().contains(txt)) if (jsonData['email'] != email) {
      var abc = null;
      if (alreadyFriends.docs.length > 0)
        try {
          abc = alreadyFriends.docs
              .firstWhere((fe) => fe.data()['toemail'] == jsonData['email']);
        } catch (e) {}
      if (abc == null)
        data.add(Search(name: jsonData['username'], type: "user $jsonData"));
    }
  });

  //  => ;
  // if (isfound.docs.length > 0) {
  //   isfound.docs.forEach((element) {
  //     data.add(
  //         Search(name: element.data()['name'], type: "user ${element.data()}"));
  //   });
  // }
  print(data.length);
  return data;
}

//// create Channel
Future createnewChannel(name, server) async {
  try {
    var isfound = await FirebaseFirestore.instance
        .collection("channel")
        .where("name", isEqualTo: name)
        .get();
    if (isfound.docs.length > 0) {
      Get.snackbar(
        "Alert !",
        "Already Exist ...",
        backgroundColor: Colors.white,
        colorText: Colors.black,
      );
      return null;
    }
    await FirebaseFirestore.instance.collection("channel").add({
      "name": name.toString(),
      "server": server.toString(),
      "noOfMember": 0
    });

    var jsonMap = await FirebaseFirestore.instance
        .collection("server")
        .where('name', isEqualTo: server.toString())
        .get();
    // .where("email", isEqualTo: name!)
    // .get();

    print(jsonMap.docs[0].data());
    var docId = jsonMap.docs.first.id;

    Server u = Server.fromMap(jsonMap.docs[0].data());
    print(docId + " .... Get");

    u.noOfChannel += 1;

    var jsonUpdated = u.toMap();

    FirebaseFirestore.instance
        .collection("server")
        .doc(docId)
        .update(jsonUpdated);

    Get.snackbar(
      "Alert !",
      "Created SuccessFully ...",
      backgroundColor: Colors.white,
      colorText: Colors.black,
    );
    return "ok";
  } on FirebaseException catch (e) {
    Get.snackbar("Error", "$e");
    print(e);
    return null;
  }
}

//// create server
Future createnewServer(File file, name) async {
  if (file == null) return;

  var isfound = await FirebaseFirestore.instance
      .collection("server")
      .where("name", isEqualTo: name)
      .get();
  if (isfound.docs.length > 0) {
    Get.snackbar(
      "Alert !",
      "Already Exist ...",
      backgroundColor: Colors.white,
      colorText: Colors.black,
    );
    return null;
  }
  SharedPreferences pref = await SharedPreferences.getInstance();
  var email = pref.getString("email");

  var exeT = file.path.split('/').last.split('.').last;
  final fileName = name + "." + exeT;
  final destination = 'server/$fileName';

  try {
    final ref = FirebaseStorage.instance.ref(destination);

    await FirebaseFirestore.instance.collection("server").add({
      "name": name.toString(),
      "pic": fileName.toString(),
      "createdBy": email,
      "noOfChannel": 0
    });

    Get.snackbar(
      "Alert !",
      "Created SuccessFully ...",
      backgroundColor: Colors.white,
      colorText: Colors.black,
    );

    return await ref.putFile(file);
  } on FirebaseException catch (e) {
    Get.snackbar("Error", "$e");
    print(e);
    return null;
  }
}

///get all servers

///file upload profile
///

Future uploadFile(File file) async {
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
        .where('email', isEqualTo: name.toString())
        .get();
    // .where("email", isEqualTo: name!)
    // .get();

    var exeT = file.path.split('/').last.split('.').last;

    print(jsonMap.docs[0].data());
    var docId = jsonMap.docs.first.id;

    Users u = Users.fromMap(jsonMap.docs[0].data());
    print(docId + " .... Get");

    u.pic = name! + "." + exeT;

    var jsonUpdated = u.toMap();

    FirebaseFirestore.instance
        .collection("users")
        .doc(docId)
        .update(jsonUpdated);

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

getImageUrl(filename) {
  var ref = FirebaseStorage.instance.ref().child(filename);
  var url = ref.getDownloadURL();
  return url;
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
