import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_utopia/actions/actions.dart';
import 'package:flutter_application_utopia/actions/getController.dart';
import 'package:flutter_application_utopia/const/navBar.dart';
import 'package:flutter_application_utopia/const/commonColor.dart';
import 'package:flutter_application_utopia/screens/channel_page.dart';
import 'package:flutter_application_utopia/screens/create_new_server.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(HomeController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: getCustomenavBar(0),
      backgroundColor: ptaNI,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Servers",
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
                Get.to(CreateNewServer());
              },
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add_circle_outline_sharp)),
                  Text("Create New Server"),
                ],
              )),
          SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: FirebaseFirestore.instance.collection("server").get(),
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
                        return InkWell(
                          onTap: () {
                            Get.to(ChannelPage(ind: index));
                          },
                          child: listCard(index, data.docs[index].data()),
                        );
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

  listCard(index, mapData) {
    return FutureBuilder(
        future: getImageUrl("server/" + mapData['pic']),
        builder: (context, snapshot) {
          print("......... " + snapshot.data.toString());

          return Container(
            color: grey.withOpacity(0.27),
            padding: EdgeInsets.symmetric(vertical: 7),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            child: ListTile(
              leading: CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(
                  snapshot.data.toString(),
                ),
              ),
              title: Text(
                "${mapData['name']}",
                style: TextStyle(color: Colors.black),
              ),
              trailing: Container(
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
          );
        });
  }
}
