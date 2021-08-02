// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, deprecated_member_use, unused_import, unnecessary_statements

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_utopia/actions/actions.dart';
import 'package:flutter_application_utopia/const/commonColor.dart';
import 'package:flutter_application_utopia/const/common_widgets.dart';
import 'package:flutter_application_utopia/model/user.dart';
import 'package:flutter_application_utopia/screens/channel_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfilePage extends StatefulWidget {
  UpdateProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phonenumberController = TextEditingController();
  // TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    atStart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          'Update Profile',
          style: TextStyle(color: Colors.white),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      //backgroundcolor: Colors.black,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          //height: 620,
          decoration: BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.rectangle,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 65,
                        child: Center(
                          child: CircleAvatar(
                            radius: 62,
                            backgroundImage:
                                AssetImage("assets/images/splash.png"),
                            backgroundColor: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getCustomeTextFieldwithController("Name",
                            "Please Enter Your Name !", _nameController),
                        getCustomeTextFieldwithController("UserName",
                            "Please Enter UserName !", _usernameController),
                        getCustomeTextFieldwithController(
                            "Email", "Please Enter Email !", _emailController),
                        getCustomeTextFieldwithController(
                            "Phone Number",
                            "Please Enter Phone Number !",
                            _phonenumberController),
                        //enable this is user really wants this

                        // getCustomeTextFieldwithController(
                        //     "password",
                        //     "Please Enter Your  Password !",
                        //     _passwordController),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.symmetric(vertical: 7),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.5),
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(30),
                            // shape: StadiumBorder(),
                          ),
                          child: TextButton(
                            child: Text(
                              'Update Profile',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal),
                            ),
                            onPressed: () async {
                              var collection = FirebaseFirestore.instance
                                  .collection('users');
                              collection
                                  .doc('qZ4W6khw1fMQV18QXGH5')
                                  //ask faizan to make it dynamic(fetch Docid)
                                  .update({
                                    'name': _nameController.text,
                                    'username': _usernameController.text,
                                    'email': _emailController.text,
                                    'phonenumber': _phonenumberController.text,
                                    //'password': '$_usernameController',
                                  })
                                  .then((_) => print('Updated'))
                                  .catchError((error) =>
                                      print('Update failed: $error'));
                            },
                          ),
                        ),
                        SizedBox(
                          height: 19,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

atStart() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("diary", "yes");
  var userId = prefs.getString(
    "email",
  );
}
