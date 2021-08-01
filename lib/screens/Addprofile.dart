// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_utopia/actions/actions.dart';
import 'package:flutter_application_utopia/const/commonColor.dart';
import 'package:flutter_application_utopia/screens/home_screen.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:path/path.dart' as Path;

class Addprofile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  appBar: AppBar(),
        // ignore: unnecessary_new
        body: ProfileState());
  }
}

class ProfileState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Header(),
        SignupCard(),
      ],
    );
  }
}

class SignupCard extends StatefulWidget {
  late File _image;
  late String _uploadedFileURL;
  @override
  _SignupCardState createState() => _SignupCardState();
}

class _SignupCardState extends State<SignupCard> {
  bool rdMale = true, rdFeMale = false;
  File chosedFile = File("");
  var task = null;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/utopiaLogo.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
            width: size.width,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            height: size.height - 300,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 15),
                        child: Text(
                          "Upload Profile Picture",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        //  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 5),
                        child: CircleAvatar(
                          maxRadius: 110,
                          backgroundColor: Colors.black,
                          child: chosedFile.path != ""
                              ? CircleAvatar(
                                  maxRadius: 107,
                                  backgroundImage: FileImage(chosedFile),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: IconButton(
                                        onPressed: () {
                                          chooseDialog();
                                        },
                                        icon: Icon(
                                          Icons.add_circle_outline,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/images/splash.png"),
                                  maxRadius: 107,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: IconButton(
                                        onPressed: () {
                                          chooseDialog();
                                        },
                                        icon: Icon(
                                          Icons.add_circle_outline,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 0.0),
                      child: Container(
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
                            'Next',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                          onPressed: () {
                            uploadFile(chosedFile);
                            // Get.offAll(HomeScreen());
                            //Get.offAll(HomeScreen());
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    task != null ? buildUploadStatus() : Center(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUploadStatus() => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            if (percentage == "100.0") Get.offAll(HomeScreen());
            print(percentage);

            return percentage != "100.0" || percentage != "0.0"
                ? Column(
                    children: [
                      CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '$percentage %',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                : Container();
          } else {
            return Container();
          }
        },
      );

  chooseDialog() {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            elevation: 1.0,
            content: Container(
              height: 85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      picker(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.photo,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Select From Gallery ",
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      picker(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.camera,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Take From Camera ",
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  picker(source) async {
    var permitted = await Permission.camera.request().isGranted;
    if (!permitted) return;
    permitted = await Permission.storage.request().isGranted;
    if (!permitted) return;
    final pickedFile = await ImagePicker().getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        //  this.IsImagePick = true;
        chosedFile = File(pickedFile.path);
        //_image = File(pickedFile.path);

      } else {
        print('No image selected.');
      }
    });
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          margin: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 220.0),
          //constraints: BoxConstraints(maxHeight: 500),
          decoration: BoxDecoration(
            color: Colors.black54,
            gradient: LinearGradient(
              colors: [
                grey,
                Colors.black87,
              ],
            ),
          ),
        ),
        Center(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      //margin: EdgeInsetsDirectional.fromSTEB(0.0, 36.0, 0.0, 0.0),
                      child: Image.asset(
                        'assets/images/utopiaLogo.jpg',
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Expanded(
                    //margin: EdgeInsetsDirectional.fromSTEB(0.0, 36.0, 0.0, 0.0),
                    child: Image.asset(
                      'assets/images/utopiaLogo.jpg',
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.center,
                    colors: [
                      grey,
                      Colors.black87,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

////
