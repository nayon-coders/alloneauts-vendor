import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/firebase/controller/auth_controller.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view/auth/checkingAuth.dart';
import 'package:vendor/view/auth/login.dart';
import 'package:vendor/view/auth/offers.dart';
import 'package:vendor/view/auth/signup.dart';
import 'package:vendor/view/dashboard/dashboard.dart';
import 'package:vendor/view/main_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:universal_html/html.dart' as html;

import 'view/auth/verification_center/accountVerificationCenter.dart';
import 'view/auth/congratulation.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyAjdeDf3BkaH-MzV3TR2qQa07p6WWSctBs",
        authDomain: "alloneautos-7207a.firebaseapp.com",
        projectId: "alloneautos-7207a",
        storageBucket: "alloneautos-7207a.appspot.com",
        messagingSenderId: "1058538096944",
        appId: "1:1058538096944:web:68b75a1cdb67bae12320f5",
        measurementId: "G-JW6VWJ2XVE"
    )
  );

  alwaysRemoveCookies();

  //FirebaseAuthController.vendorRegister();



  runApp(const MyApp());
}

void alwaysRemoveCookies() {
  html.window.document.cookie?.split(';').forEach((cookie) {
    final eqIndex = cookie.indexOf('=');
    final name = eqIndex > -1 ? cookie.substring(0, eqIndex) : cookie;
    html.window.document.cookie = '$name=; expires=Thu, 01 Jan 1970 00:00:00 GMT';
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultGlobalState: true,
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
          fontFamily: "themeFont"
      ),
    // home: Login(),

    home: _auth.currentUser == null ? const Login() : const MainPage()
    );
  }
}
