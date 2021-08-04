// ignore_for_file: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_utopia/screens/getstarted_screen.dart';
import 'package:flutter_application_utopia/screens/home_screen.dart';
import 'package:flutter_application_utopia/screens/imageuploadtest.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

var screens;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  var email = pref.getString("email") ?? '';
  if (email == '' || email == null)
    screens = GetStartedPage();
  else
    screens = HomeScreen();

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UTopia',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: screens,
    );
  }
}
