// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_utopia/const/commonColor.dart';
import 'package:flutter_application_utopia/const/navBar.dart';
import 'package:flutter_application_utopia/screens/getstarted_screen.dart';
import 'package:flutter_application_utopia/screens/privacyscreen.dart';
import 'package:flutter_application_utopia/screens/updateprofile_screen.dart';
import 'package:get/get.dart';

class SettingPage extends StatefulWidget {
  SettingPage({
    Key? key,
  }) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: getCustomenavBar(3),
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.justify,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              Get.offAll(GetStartedPage());
            },
            icon: Icon(
              Icons.login_rounded,
              color: Colors.white,
              size: 30,
            ),
            iconSize: 30,
          ),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width,
                height: 230,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 88,
                      child: Center(
                        child: CircleAvatar(
                          radius: 86,
                          backgroundImage:
                              AssetImage("assets/images/splash.png"),
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'User Name',
                      style: TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height - 230,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.8)),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 12),
                          child: Text(
                            '  \n   User Settings',
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(UpdateProfilePage());
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.manage_accounts,
                                size: 30,
                              ),
                              Text(
                                ' Update Profile',
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(PrivacyPage());
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.privacy_tip_rounded,
                                size: 30,
                              ),
                              Text(
                                ' Privacy',
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: Colors.black,
                            thickness: 2,
                          ),
                        ),
                        Text(
                          '   Nitro Settings',
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        InkWell(
                          onTap: () {},
                          focusColor: Colors.red,
                          splashColor: Colors.amber,
                          child: Row(
                            children: [
                              Icon(
                                Icons.subscriptions_rounded,
                                size: 30,
                              ),
                              Text(
                                ' Subscribe',
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Image.asset(assets/image/)
                        InkWell(
                          onTap: () {},
                          focusColor: Colors.red,
                          splashColor: Colors.amber,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                ' 🚀  Boost',
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Divider(
                            color: Colors.black,
                            thickness: 2,
                          ),
                        ),

                        Text(
                          '   App Information',
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.info,
                                size: 30,
                              ),
                              Text(
                                ' About',
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.black,
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Icon(
                                Icons.support_agent_rounded,
                                size: 30,
                              ),
                              Text(
                                ' Support ',
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.black,
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
