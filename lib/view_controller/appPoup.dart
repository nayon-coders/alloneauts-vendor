import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:vendor/utility/app_color.dart';

class AppPopup{
  static appPopup({
    required BuildContext context,
    required String title ,
    required String body,
    required DialogType dialogType,
    required VoidCallback onOkBtn,
  }){
    return AwesomeDialog(
      width: 500,
      context: context,
      animType: AnimType.scale,
      dialogType: dialogType,

      // body: Center(child: Text(
      //   'If the body is specified, then title and description will be ignored, this allows to 											further customize the dialogue.',
      //   style: TextStyle(fontStyle: FontStyle.italic),
      // ),),
      title: title,
      desc:  body,
      btnOkOnPress: onOkBtn,
      btnOkColor: AppColors.green,
      btnOkText: "Ok!"
    )..show();
  }
}