// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_utopia/const/commonColor.dart';
import 'package:flutter_application_utopia/screens/Addprofile.dart';
import 'package:get/get.dart';

class SignInPageFashee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      // ignore: unnecessary_new
      body: Container(
        color: Colors.black,
        child: SignIn(),
      ),
    );
  }
}

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Header(),
        Center(
          child: SignInCard(),
        ),
        Positioned.fill(
          top: 700.0,
          child: Container(
            color: Colors.black,
            width: 300,
            height: 600,
          ),
        ),
      ],
    );
  }
}

class SignInCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0), color: Colors.white),
      padding: EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 20.0),
      margin: EdgeInsetsDirectional.fromSTEB(32.0, 112.0, 32.0, 112.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 6.0),
              child: Text("Sign In",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600)),
            ),
            SizedBox(
              height: 19,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                child: TextField(
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.black38),
                      fillColor: Colors.black87),
                  style: TextStyle(color: Colors.black87),
                )),
            SizedBox(
              height: 19,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                child: TextField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      suffixIcon:
                          IconButton(onPressed: () {}, icon: Icon(Icons.lock)),
                      border: OutlineInputBorder(),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.black38),
                      fillColor: Colors.black87),
                  style: TextStyle(color: Colors.black87),
                )),

            // ignore: unnecessary_new
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 0.0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 7),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.5),
                  color: ptaNI,
                  borderRadius: BorderRadius.circular(30),
                  // shape: StadiumBorder(),
                ),
                child: TextButton(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.normal),
                  ),
                  onPressed: () {
                    Get.to(Addprofile());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          margin: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 220.0),
          //constraints: BoxConstraints(maxHeight: 500),
          decoration: BoxDecoration(
            color: Colors.black54,
            gradient: LinearGradient(
              colors: [
                grey,
                Colors.black87,
              ],
            ),
          ),
        ),
        Center(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      //margin: EdgeInsetsDirectional.fromSTEB(0.0, 36.0, 0.0, 0.0),
                      child: Image.asset(
                        'assets/images/utopiaLogo.jpg',
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Expanded(
                    //margin: EdgeInsetsDirectional.fromSTEB(0.0, 36.0, 0.0, 0.0),
                    child: Image.asset(
                      'assets/images/utopiaLogo.jpg',
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.center,
                    colors: [
                      grey,
                      Colors.black87,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
