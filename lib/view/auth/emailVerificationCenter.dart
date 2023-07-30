import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view/auth/congratulation.dart';
import 'package:vendor/view/auth/login.dart';
import 'package:vendor/view_controller/richText.dart';

import '../../view_controller/appButton.dart';
import '../../view_controller/bigText.dart';

class EmailVerificationCenter extends StatefulWidget {
  const EmailVerificationCenter({Key? key}) : super(key: key);

  @override
  State<EmailVerificationCenter> createState() => _EmailVerificationCenterState();
}

class _EmailVerificationCenterState extends State<EmailVerificationCenter> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/map-bg.png")
            )
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(50),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: size.width*.30,
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(30),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Column(
                children: [
                  Image.asset("assets/images/logo.png", height: 100, width: 100,),
                  SizedBox(height: 40,),
                  BigText(text: "Email Verification"),
                  SizedBox(height: 10,),
                  RichTextWidget(leftText: "We send a verfication code on ", rightText: "nayon.coders@gmail.com"),
                  SizedBox(height: 40,),
                  OTPTextField(
                    length: 5,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 50,
                    style: TextStyle(
                        fontSize: 17,
                      color: AppColors.green
                    ),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.box,
                    onCompleted: (pin) {
                      print("Completed: " + pin);
                    },
                  ),
                  SizedBox(height: 30,),
                  Align(
                    alignment: Alignment.center,
                    child: AppButton(
                      width: size.width*.30,
                      text: "Continue",
                      onClick: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Congratulation(title: "Email verification success",))),
                    ),
                  ),
                  SizedBox(height: 15,),

                  Center(
                    child: TextButton(
                      onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Login())),
                      child: Text("I have an accout. Login."),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
