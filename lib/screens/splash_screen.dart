// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

class SplashScreenPage extends StatefulWidget {
  SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black38,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1,
        // decoration: BoxDecoration(
        //   color: Colors.black12,
        //   image: DecorationImage(
        //     fit: BoxFit.fill,
        //     image: Image.asset(
        //       'assets/images/bg_login.png',
        //     ).image,
        //   ),
        // ),
        alignment: Alignment(-0.050000000000000044, 0),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment(0.05, -1),
                  child: Image.asset(
                    'assets/images/utopiaLogo.jpg',
                    width: 400,
                    height: 300,
                    fit: BoxFit.none,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.asset(
                              'assets/images/splash.png',
                              width: 164,
                              height: 234,
                              fit: BoxFit.fitHeight,
                            ),
                            const Text(
                              'Chat and Hangout with Your Friends and Family',
                              style: TextStyle(
                                  fontSize: 13, color: Colors.white70),
                            )
                          ],
                        ),
                      ),
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
