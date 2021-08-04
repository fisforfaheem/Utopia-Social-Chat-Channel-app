import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_utopia/actions/actions.dart';
import 'package:flutter_application_utopia/const/commonColor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateNewChannel extends StatefulWidget {
  final name;
  const CreateNewChannel({Key? key, this.name}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<CreateNewChannel> {
  final channelController = TextEditingController();
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
                  controller: channelController,
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
              isLoading ? CircularProgressIndicator() : Center(),

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
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      createnewChannel(channelController.text, widget.name);

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
    );
  }
}
