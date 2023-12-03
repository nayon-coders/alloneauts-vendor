import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getToken();

  }

  String? token;
  bool isChecking = true;
  bool isAuth = true;
  //get token
  getToken() async {

    dynamic token = await SessionManager().get("token");

    if(token != null){
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const MainPage()), (route) => false);
          // Do something
        }else{
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const Login()), (route) => false);
          // Do something
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
