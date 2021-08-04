import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_utopia/actions/actions.dart';
import 'package:flutter_application_utopia/const/navBar.dart';
import 'package:flutter_application_utopia/const/commonColor.dart';
import 'package:flutter_application_utopia/screens/addafriendscreen.dart';
import 'package:flutter_application_utopia/screens/create_new_channel.dart';
import 'package:flutter_application_utopia/screens/create_new_server.dart';
import 'package:flutter_application_utopia/screens/invite.dart';
import 'package:flutter_application_utopia/screens/message_screen.dart';
import 'package:get/get.dart';

class AllFriends extends StatefulWidget {
  final ind;
  const AllFriends({Key? key, this.ind}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AllFriends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: getCustomenavBar(1),
      backgroundColor: ptaNI,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          "Friends",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          OutlinedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.black),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(00.0))),
              ),
              onPressed: () {
                Get.to(AddAFriendPage());
              },
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add_circle_outline_sharp)),
                  Text("Add Friend"),
                ],
              )),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: FutureBuilder(
                future: FirebaseFirestore.instance.collection("friends").get(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  if (snapshot.hasData) {
                    QuerySnapshot data = snapshot.data;
                    print(data);
                    return ListView.builder(
                        itemCount: data.docs.length,
                        itemBuilder: (ctx, index) {
                          return listCard(index, data.docs[index]);
                        });
                  } else
                    return Center(
                      child: Text("Empty ...."),
                    );
                }),
          ),
        ],
      ),
    );
  }

  listCard(index, jsonMap) {
    print(jsonMap['toemail']);
    return Container(
      color: grey.withOpacity(0.27),
      padding: EdgeInsets.symmetric(vertical: 7),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("users")
              .where("email",
                  isEqualTo: jsonMap['toemail'].toString().replaceAll(" ", ''))
              .get(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return CircularProgressIndicator();
            QuerySnapshot data = snapshot.data;

            print(data.docs.length);
            var abc = data.docs[0].data();
            var JsonD = jsonEncode(abc);
            var jsonE = jsonDecode(JsonD);
            if (snapshot.hasData)
              return ListTile(
                onTap: () {
                  // Get.to(MessageScreen());
                },
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/splash.png"),
                ),
                title: Text("${jsonE['username']}"),
                subtitle: Text(
                  "${jsonMap['toemail']}",
                  style: TextStyle(color: Colors.black),
                ),
              );
            else {
              return Text("Not FOund");
            }
          }),
    );
  }
}
