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
          "Channels",
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
                Get.to(CreateNewChannel());
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
          Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (ctx, index) {
                    return listCard(index);
                  })),
        ],
      ),
    );
  }

  listCard(index) {
    return Container(
      color: grey.withOpacity(0.27),
      padding: EdgeInsets.symmetric(vertical: 7),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      child: ListTile(
        onTap: () {
          Get.to(MessageScreen());
        },
        leading: CircleAvatar(
          backgroundImage: AssetImage("assets/images/splash.png"),
        ),
        title: Text(
          "Channel ${index + 1}",
          style: TextStyle(color: Colors.black),
        ),
        subtitle: Text(
          "Member ${index + 1}",
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
