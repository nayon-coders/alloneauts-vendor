import 'package:flutter/material.dart';

class AppSnackBar{
  static Future appSnackBar(String text, Color bg, BuildContext context)async{
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(

      backgroundColor: bg,
      content: Text('$text'),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 100,
          right: 20,
          left: 20),
    ));
  }
}