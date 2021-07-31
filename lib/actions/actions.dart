import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

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
