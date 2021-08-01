import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_utopia/actions/actions.dart';
import 'package:flutter_application_utopia/const/commonColor.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateNewServer extends StatefulWidget {
  const CreateNewServer({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<CreateNewServer> {
  File choseImage = File("");
  final serverName = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ptaNI,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          "Create New Server",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  //  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 5),
                  child: CircleAvatar(
                    maxRadius: 90,
                    backgroundColor: Colors.black,
                    child: choseImage.path != ""
                        ? CircleAvatar(
                            backgroundImage: FileImage(choseImage),
                            maxRadius: 85,
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
                            maxRadius: 85,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: IconButton(
                                  onPressed: () async {
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      child: Text(
                        "Server Name",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: serverName,
                      style: TextStyle(),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Server Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  //btn
                  isLoading
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 0.0),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 0.0),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            padding: EdgeInsets.symmetric(vertical: 7),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              color: grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(30),
                              // shape: StadiumBorder(),
                            ),
                            child: TextButton(
                              child: Text(
                                'Create ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              ),
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                try {
                                  if (serverName.text.length > 0 &&
                                      choseImage.path != "") {
                                    await createnewServer(
                                        choseImage, serverName.text);
                                  } else
                                    Get.snackbar(
                                        "Alert !",
                                        choseImage.path == ""
                                            ? " Pick File "
                                            : "Please Enter Server Name ",
                                        colorText: Colors.white,
                                        backgroundColor: Colors.black);
                                } catch (e) {
                                  print(e);
                                }
                                setState(() {
                                  isLoading = false;
                                });
                                //Get.offAll(HomeScreen());
                              },
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

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
                    onTap: () async {
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
                          style: TextStyle(fontSize: 25),
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
                          style: TextStyle(fontSize: 25),
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
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        choseImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
