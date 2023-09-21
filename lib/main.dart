import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view/auth/checkingAuth.dart';
import 'package:vendor/view/auth/login.dart';
import 'package:vendor/view/auth/offers.dart';
import 'package:vendor/view/auth/signup.dart';
import 'package:vendor/view/dashboard/dashboard.dart';
import 'package:vendor/view/main_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
          fontFamily: "themeFont"
      ),
     home: CheckingAuth(),
    );
  }
}
