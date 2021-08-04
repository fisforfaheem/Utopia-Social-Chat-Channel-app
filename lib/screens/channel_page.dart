// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_utopia/const/navBar.dart';
import 'package:flutter_application_utopia/const/commonColor.dart';
import 'package:flutter_application_utopia/screens/create_new_channel.dart';
import 'package:flutter_application_utopia/screens/create_new_server.dart';
import 'package:flutter_application_utopia/screens/invite.dart';
import 'package:flutter_application_utopia/screens/message_screen.dart';
import 'package:get/get.dart';

class ChannelPage extends StatefulWidget {
  final ind;
  const ChannelPage({Key? key, this.ind}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ChannelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // bottomNavigationBar: getCustomenavBar(0),
      backgroundColor: ptaNI,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          "Channels of ${widget.ind}",
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
                Get.to(CreateNewChannel(name: widget.ind));
              },
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add_circle_outline_sharp)),
                  Text("Create New Channel"),
                ],
              )),
          SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("channel")
                .where("server", isEqualTo: widget.ind)
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
                    child: ListView.builder(
                      itemCount: data.docs.length,
                      itemBuilder: (ctx, index) {
                        return listCard(index, data.docs[index].data());
                      },
                    ),
                  ),
                );
              else
                return Center(
                  child: Text("No Server Found ..."),
                );
            },
          ),
        ],
      ),
    );
  }

  listCard(index, jsonMap) {
    return Container(
      color: grey.withOpacity(0.27),
      padding: EdgeInsets.symmetric(vertical: 7),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      child: ListTile(
        onTap: () {
          Get.to(MessageScreen(
            channelName: jsonMap['name'],
            servername: widget.ind,
          ));
        },
        leading: CircleAvatar(
          backgroundImage: AssetImage("assets/images/splash.png"),
        ),
        title: Text(
          "${jsonMap['name']}",
          style: TextStyle(color: Colors.black),
        ),
        subtitle: Text(
          "Member ${jsonMap['noOfMember']}",
          style: TextStyle(color: Colors.black),
        ),
        trailing: IconButton(
          onPressed: () {
            Get.to(Invite());
          },
          icon: Icon(Icons.share),
        ),
      ),
    );
  }
}
