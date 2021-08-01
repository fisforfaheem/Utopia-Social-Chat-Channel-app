// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_utopia/actions/actions.dart';
import 'package:flutter_application_utopia/const/commonColor.dart';
import 'package:flutter_application_utopia/screens/Addprofile.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignInPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool passToggale = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/utopiaLogo.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
            width: size.width,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            height: size.height - 300,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Sign In",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 19,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Email",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextFormField(
                          autovalidate: true,
                          controller: _emailController,
                          autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          // textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Email",
                              labelStyle: TextStyle(color: Colors.black38),
                              fillColor: Colors.black87),
                          style: TextStyle(color: Colors.black87),
                          validator: (input) =>
                              input!.isValidEmail() ? null : "Check your email",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 19,
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Password",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextField(
                          controller: _passwordController,
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          autocorrect: false,
                          obscureText: passToggale,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passToggale = !passToggale;
                                  });
                                },
                                icon: Icon(
                                  Icons.remove_red_eye_rounded,
                                  color:
                                      passToggale ? Colors.grey : Colors.blue,
                                ),
                              ),
                              border: OutlineInputBorder(),
                              hintText: "Password",
                              labelStyle: TextStyle(color: Colors.black38),
                              fillColor: Colors.black87),
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    // ignore: unnecessary_new
                    Container(
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
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        onPressed: () async {
                          try {
                            User user = (await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ))
                                .user!;
                            print(user);
                            if (user != null) {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              pref.setString("email", user.email.toString());
                              pref.setString("email", user.uid.toString());

                              Get.snackbar(
                                  'Found', ' user found ${user.email}');
                              print('User =>' + '${user.uid}');

                              Get.to(Addprofile());
                            }
                          } catch (e) {
                            print(e);
                            Get.snackbar(
                                'Error', '  Incorrect Email or Password !');
                            _emailController.text = "";
                            _passwordController.text = "";
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 19,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
