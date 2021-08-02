// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, deprecated_member_use, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_utopia/actions/actions.dart';
import 'package:flutter_application_utopia/const/commonColor.dart';
import 'package:flutter_application_utopia/const/common_widgets.dart';
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

  // getCurrentUserData() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setString("email",user.email.toString());
  //   pref.setString("pic", user.photoURL.toString());
  // }

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
                        //     "Phone Number",
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
                            onPressed: () {
                              //Update User Pofile
                            },
                          ),
                        ),
                        FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection("profileimages")
                              .get(),
                          builder: (ctx, AsyncSnapshot snap) {
                            if (snap.connectionState == ConnectionState.waiting)
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            QuerySnapshot data = snap.data;
                            print(data.docs.length);
                            if (snap.hasData)
                              return Container(
                                child: Expanded(
                                  child: Center(),
                                  // child: listCard(data.docs[index].data()),
                                ),
                              );
                            else
                              return Center();
                          },
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
