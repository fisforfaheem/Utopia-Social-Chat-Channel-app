// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, deprecated_member_use, unused_import, unnecessary_statements

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_utopia/actions/actions.dart';
import 'package:flutter_application_utopia/const/commonColor.dart';
import 'package:flutter_application_utopia/const/common_widgets.dart';
import 'package:flutter_application_utopia/model/user.dart';
import 'package:flutter_application_utopia/screens/channel_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfilePage extends StatefulWidget {
  final url, email;
  UpdateProfilePage({Key? key, this.email, this.url}) : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phonenumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String docID = '';
  String dob = "";
  String gender = "";
  bool isAllowed = false;

  @override
  void initState() {
    super.initState();
    atStart();
  }

  bool passToggale = true;

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
                            backgroundImage: NetworkImage(widget.url),
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
                        getCustomeTextFieldwithController(
                            "UserName",
                            "Please Enter UserName !",
                            _usernameController,
                            false),
                        getCustomeTextFieldwithController("Email",
                            "Please Enter Email !", _emailController, true),
                        getCustomeTextFieldwithController(
                            "Phone Number",
                            "Please Enter Phone Number !",
                            _phonenumberController,
                            false),

                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                          child: TextFormField(
                            controller: _passwordController,
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            autocorrect: false,
                            obscureText: passToggale,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              hintText: "password",
                              fillColor: Colors.white,
                              filled: true,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passToggale = !passToggale;
                                  });
                                },
                                icon: Icon(
                                  Icons.remove_red_eye_rounded,
                                  color:
                                      passToggale ? Colors.grey : Colors.blue,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                              ),
                            ),
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),

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
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              var pic = pref.getString("pic");
                              print(dob);
                              var jsonData = Users(
                                      email: _emailController.text,
                                      username: _usernameController.text,
                                      dob: DateTime.parse(dob),
                                      gender: gender,
                                      password: '',
                                      isAllowed: isAllowed,
                                      pic: pic!,
                                      phonenumber: _phonenumberController.text)
                                  .toMap();
                              if (_passwordController.text.length > 0) {
                                User user = FirebaseAuth.instance.currentUser!;
                                user.updatePassword(_passwordController.text);
                                print(user);
                              }
                              var collection = FirebaseFirestore.instance
                                  .collection('users');
                              collection
                                  .doc(docID)
                                  //ask faizan to make it dynamic(fetch Docid)
                                  .update(jsonData)
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

  atStart() async {
    var dataUser = await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: widget.email.toString())
        .get();

    isAllowed = dataUser.docs.first.data()['isAllowed'];
    dob = dataUser.docs.first.data()['dob'];
    _emailController.text = widget.email;
    _usernameController.text = dataUser.docs.first.data()['username'];

    _phonenumberController.text = dataUser.docs.first.data()['phonenumber'];
    docID = dataUser.docs.first.id;
    print(docID);
    setState(() {});
  }
}
