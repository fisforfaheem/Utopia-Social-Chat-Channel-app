import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_utopia/const/navBar.dart';
import 'package:flutter_application_utopia/const/commonColor.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateNewChannel extends StatefulWidget {
  const CreateNewChannel({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<CreateNewChannel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ptaNI,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          "Create New Channel",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  child: Text(
                    "Channel Name",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  style: TextStyle(),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Channel Name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              //btn
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 0.0),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 7),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.5),
                    color: grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(30),
                    // shape: StadiumBorder(),
                  ),
                  child: TextButton(
                    child: Text(
                      'Create ',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    onPressed: () {
                      //Get.offAll(HomeScreen());
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  chooseDialog() {
    return YYDialog().build(context)
      ..width = 140
      ..height = 130
      ..backgroundColor = Colors.white.withOpacity(1)
      ..borderRadius = 10.0
      ..showCallBack = () {
        print("showCallBack invoke");
      }
      ..gravityAnimationEnable = true
      ..dismissCallBack = () {
        print("dismissCallBack invoke");
      }
      ..widget(Padding(
        padding: EdgeInsets.only(top: 21),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  picker(ImageSource.gallery);
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_circle_outline_sharp,
                          size: 10,
                        )),
                    Text(
                      "Select From Gallery ",
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                )),
            TextButton(
                onPressed: () {
                  picker(ImageSource.gallery);
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_circle_outline_sharp,
                          size: 10,
                        )),
                    Text(
                      "Take From Camera ",
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                )),
          ],
        ),
      ))
      ..animatedFunc = (child, animation) {
        return ScaleTransition(
          child: child,
          scale: Tween(begin: 0.0, end: 2.0).animate(animation),
        );
      }
      ..show();
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

        //_image = File(pickedFile.path);

      } else {
        print('No image selected.');
      }
    });
  }
}
