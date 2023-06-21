import 'package:flutter/material.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view/auth/signup.dart';
import 'package:vendor/view/main_pages.dart';
import 'package:vendor/view_controller/appButton.dart';
import 'package:vendor/view_controller/appInput.dart';
import 'package:vendor/view_controller/bigText.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email = TextEditingController();
  var pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size  =MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SingleChildScrollView(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Image.asset("assets/images/logo.png", height: 100, width: 100,),
                SizedBox(height: 40,),
                BigText(text: "Login"),
                SizedBox(height: 40,),
                AppInput(
                    controller: email,
                    title: "Email",
                    hintText: "Type you email",
                    prefixIcon: Icons.email_outlined
                ),
                SizedBox(height: 20,),
                AppInput(
                    controller: pass,
                    title: "Password",
                    hintText: "password",
                    prefixIcon: Icons.key
                ),
                SizedBox(height: 30,),
                Align(
                  alignment: Alignment.center,
                  child: AppButton(
                    width: 100,
                    text: "Login",
                    onClick: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage())),
                  ),
                ),
                SizedBox(height: 15,),
                Center(
                  child: TextButton(
                    onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp())),
                    child: Text("I Don't have an accout. Signup."),
                  ),
                )


              ],
            ),
          ),
        ),
      ),
    );
  }
}
