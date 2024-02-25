import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/view/auth/login.dart';
import 'package:vendor/view/main_pages.dart';

class CheckingAuth extends StatefulWidget {
  const CheckingAuth({Key? key}) : super(key: key);

  @override
  State<CheckingAuth> createState() => _CheckingAuthState();
}

class _CheckingAuthState extends State<CheckingAuth> {

  // This widget is the root of your application.
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(_auth.currentUser == null){
      Get.offAll(MainPage());
    }else{
      Get.offAll(Login());

    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Center(
        child: Container(
          width: 300,
          height: 200,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            color: const Color(0xFFFFFF),
            borderRadius:
            BorderRadius.all( Radius.circular(32.0)),
          ),
          child: Center(
            child: Image.asset("assets/images/logo.png"),
          )
        ),
      ),
    );
  }
}
