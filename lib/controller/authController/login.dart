import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vendor/app_config.dart';
import 'package:vendor/model/authModel/loginModel.dart';

class LoginController{
  
  //login controller
  static Future loginController({
  required String email,
  required String pass,
})async{
    print("password === ${pass}");
    var res = await http.post(Uri.parse(AppConfig.LOGIN),
      headers: <String, String>{
        'Content-Type': 'application/json',  // Set the appropriate content type
      },
      body: jsonEncode(<String, String>{
        'email': email,
        "password": pass
      }),
    );
   // LoginModel.fromJson(jsonDecode(res.body));
    print("login data ===== ${jsonDecode(res.body)}");
    return res;
  }
  
}