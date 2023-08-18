import 'dart:html';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/model/authModel/loginModel.dart';

class LocalStorage{

  //login data save local storage
  static Future saveLoginData({required Map loginModel})async{
    print("user name ===== ${loginModel}");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    //token
    prefs.setString("token", loginModel["data"]["token"]);
    //user info
    prefs.setString("id", loginModel["data"]["user"]["id"].toString());
    prefs.setString("userName", loginModel["data"]["user"]["name"]);
    prefs.setString("userImage", loginModel["data"]["user"]["image"]);
    prefs.setString("userEmail", loginModel["data"]["user"]["email"]);
    prefs.setString("userPhone", loginModel["data"]["user"]["phone"]);

    print("user name ===== ${prefs.getString("token")}");
  }



}