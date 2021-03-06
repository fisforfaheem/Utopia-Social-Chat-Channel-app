// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_import, deprecated_member_use, import_of_legacy_library_into_null_safe, unnecessary_statements

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_utopia/actions/actions.dart';
import 'package:flutter_application_utopia/const/commonColor.dart';
import 'package:flutter_application_utopia/model/user.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:passwordfield/passwordfield.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _dobController = TextEditingController(text: "DOB");
  TextEditingController _genderController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  int _radioValue = 1;
  bool isMale = true;
  bool passToggale = true;

  String selectedRole = 'Male';

  void _handleRadioValueChange(int? value) {
    print(value!);
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 1:
          selectedRole = 'Male';
          break;
        case 2:
          selectedRole = 'Female';
          break;
      }

      selectedRole == 'Male' ? isMale = true : isMale = false;
    });
    print("sel =? " + selectedRole);
  }

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
            height: size.height - 100,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Sign Up",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600)),
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
                            "Name",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextFormField(
                          controller: _usernameController,
                          autofocus: true,
                          keyboardType: TextInputType.name,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                              errorText: validateName(_usernameController.text),
                              border: OutlineInputBorder(),
                              hintText: "Name",
                              labelStyle: TextStyle(color: Colors.black38),
                              fillColor: Colors.black87),
                          style: TextStyle(color: Colors.black87),
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
                        TextFormField(
                          autovalidate: true,
                          controller: _passwordController,
                          autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          obscureText: passToggale,
                          // textCapitalization: TextCapitalization.words,
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
                          validator: (input) => input!.length >= 6
                              ? null
                              : "password Should be 6 or more",
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
                            "Gender",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: blue,
                              fillColor: MaterialStateProperty.all(blue),
                              value: 1,
                              hoverColor: Colors.white,
                              groupValue: _radioValue,
                              onChanged: _handleRadioValueChange,
                            ),
                            Text("Male"),
                            SizedBox(
                              width: 10,
                            ),
                            Radio(
                              activeColor: blue,
                              fillColor: MaterialStateProperty.all(blue),
                              value: 2,
                              hoverColor: Colors.white,
                              groupValue: _radioValue,
                              onChanged: _handleRadioValueChange,
                            ),
                            Text("Female")
                          ],
                        ),
                      ],
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "DOB",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextField(
                          controller: _dobController,
                          readOnly: true,
                          autofocus: true,
                          keyboardType: TextInputType.datetime,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        minTime: DateTime(1900, 3, 5),
                                        maxTime: DateTime(2019, 6, 7),
                                        onChanged: (date) {
                                      setState(() {
                                        _dobController.text =
                                            date.toString().split(' ')[0];
                                        SelectedDate = date;
                                      });
                                      print('change $date');
                                    }, onConfirm: (date) {
                                      print('confirm $date');
                                      setState(() {
                                        _dobController.text =
                                            date.toString().split(' ')[0];
                                        SelectedDate = date;
                                      });
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en);
                                  },
                                  icon: Icon(Icons.calendar_today)),
                              border: OutlineInputBorder(),
                              hintText: "${_dobController.text}",
                              labelStyle: TextStyle(color: Colors.black38),
                              fillColor: Colors.black87),
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
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
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        onPressed: () {
                          Map<String, dynamic> jsonY = Users(
                            pic: "",
                            email: _emailController.text,
                            username: _usernameController.text,
                            dob: SelectedDate,
                            gender: selectedRole,
                            password: "",
                            isAllowed: true,
                            phonenumber: "",
                          ).toMap();

                          funcSignUp(_emailController.text,
                              _passwordController.text, jsonY);
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
