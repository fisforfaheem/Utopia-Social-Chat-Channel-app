// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_application_utopia/const/commonColor.dart';
import 'package:flutter_application_utopia/screens/signin_screen.dart';
import 'package:flutter_application_utopia/screens/signin_screen_faheem.dart';
import 'package:flutter_application_utopia/screens/signup_screen.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class GetStartedPage extends StatefulWidget {
  //SplashScreenWidget({Key key}) : super(key: key);

  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var inkWell = InkWell(
      onTap: () {
        Get.to(() => SignUpPage());
      },
      child: Column(
        children: [
          Text(
            '\nSign Up Here!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 3),
          Container(
            color: ptaNI,
            width: 100,
            height: 2,
          ),
        ],
      ),
    );
    return Scaffold(
      //  appBar: AppBar(),
      key: scaffoldKey,
      //backgroundColor: Colors.black,
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [
              grey,
              Colors.black,
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/utopiaLogo.jpg',
                fit: BoxFit.fill,
                height: 250,
                width: size.width,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Welcome to Utopia!',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'A place where you can talk to your friends,\n            family and Utopia community.\n\n\n',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => SignInPage());
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: ptaNI,
                      ),
                      child: Center(
                        child: Text(
                          'GET STARTED',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '\n\nDon\'t have an account yet?',
                    style: TextStyle(fontSize: 13, color: Colors.white70),
                  ),
                  inkWell,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
