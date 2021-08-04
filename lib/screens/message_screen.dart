import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_utopia/const/commonColor.dart';
import 'package:flutter_application_utopia/model/message.dart';
import 'package:flutter_application_utopia/screens/addafriendscreen.dart';
import 'package:flutter_application_utopia/screens/invite.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageScreen extends StatefulWidget {
  final channelName, servername;
  const MessageScreen({Key? key, this.channelName, this.servername})
      : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List membersData = [];
  final _messageController = TextEditingController();
  atStart() async {
    var data = await FirebaseFirestore.instance
        .collection("member")
        .where("server", isEqualTo: widget.servername)
        .where("channel", isEqualTo: widget.channelName)
        .get();
    data.docs.forEach((element) async {
      var userData = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: element.data()['member'])
          .get();
      print(userData.docs.first.data());
      membersData.add(userData.docs.first.data());

      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    atStart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "${widget.channelName}",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.to(Invite());
          },
          icon: Icon(Icons.person_add, color: Colors.white),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: new Icon(
                Icons.groups,
                color: Colors.white,
              ),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: Container(
          padding: EdgeInsets.only(top: 50),
          color: Colors.black,
          child: Column(
            children: [
              Text(
                "Channel Members",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: membersData.length,
                    itemBuilder: (ctx, index) {
                      return Container(
                        padding: EdgeInsets.only(left: 20, bottom: 10),
                        child: ListTile(
                          leading: Text(
                            "${index + 1}",
                            style: TextStyle(color: Colors.white),
                          ),
                          title: Text(
                            "${membersData[index]['username']}",
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            "${membersData[index]['email']}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
      drawerEnableOpenDragGesture: true,
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("message")
                      .where("server", isEqualTo: widget.servername)
                      .where("channel", isEqualTo: widget.channelName)
                      .orderBy("timestamp", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black)),
                      );
                    if (snapshot.hasData)
                      return ListView.builder(
                        itemCount: 2,
                        itemBuilder: (ctx, index) {
                          return Container(
                            child: listCard(index, index % 2 == 0),
                          );
                        },
                      );
                    else
                      return Center(
                        child: Text("Write A First Message ... "),
                      );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.photo),
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                sendMessage();
                              },
                              icon: Icon(
                                Icons.send,
                                color: Colors.blue,
                              )),
                          hintText: "Message",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  sendMessage() async {
    print("enter");
    SharedPreferences pref = await SharedPreferences.getInstance();
    String email = pref.getString('email') ?? "";
    var msg = Message(
      channel: widget.channelName,
      server: widget.servername,
      fromEmail: email,
      message: _messageController.text,
      timestamp: DateTime.now().toString(),
    ).toMap();
    await FirebaseFirestore.instance.collection("message").add(msg);
    _messageController.text = "";
    setState(() {});
  }

  listCard(index, bool fromMe) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment:
            fromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          fromMe
              ? Row(
                  children: [
                    getConatiner(index, fromMe),
                    SizedBox(
                      width: 4,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.black,
                    ),
                  ],
                )
              : Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    getConatiner(index, fromMe),
                  ],
                ),
        ],
      ),
    );
  }

  getConatiner(txt, fromMe) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: fromMe ? Colors.green : grey,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Hey What's Up ksdfjksjkdf ksdfj ksdjf ksdj fksjd fksdj kfsdj sdg f dsaf sadfasdf sdf  sdf asd f as df sad f  asd f asd fasd  f ads f sda f  asd f a ds f asd f  ads f  asdf  ads f  adsf asd  f asd f ads  kfj akdfj adskjf kasdj fkdas jfkadsjf kasdfj k",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
