import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vendor/controller/authController/login.dart';
import 'package:vendor/model/authModel/loginModel.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view/auth/offers.dart';
import 'package:vendor/view/auth/signup.dart';
import 'package:vendor/view/main_pages.dart';
import 'package:vendor/view_controller/appButton.dart';
import 'package:vendor/view_controller/appInput.dart';
import 'package:vendor/view_controller/bigText.dart';

import '../../local_storage/localStorage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginModel? loginModel;

  var email = TextEditingController();
  var pass = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email.text = "contact.shahidul@gmail.com";
    pass.text = "abcdabcd";
  }


  @override
  Widget build(BuildContext context) {
    var size  =MediaQuery.of(context).size;
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
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Image.asset("assets/images/logo.png", height: 100, width: 100,),
                  SizedBox(height: 40,),
                  BigText(text: "Login"),
                  SizedBox(height: 10,),
                   Text("$errorString",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.red
                    ),
                  ),
                  SizedBox(height: 20,),
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
                    child: InkWell(
                      onTap: ()=>_login(),
                      child: Container(
                        width: 100, height: 50,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: isLoading
                            ? SpinKitWave(
                          color: Colors.white,
                          size: 20.0,
                        )
                            : Center(
                          child: Text("Login",
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ),
                    )
                  ),
                  SizedBox(height: 15,),
                  Center(
                    child: TextButton(
                      onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Offers())),
                      child: const Text("I Don't have an account. Signup."),
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

  bool isLoading = false;
  bool isFieldEmpty = false;
  String errorString = "";

  Future _login() async{
    setState(() =>isLoading=true);
    if(email.text.isNotEmpty && pass.text.isNotEmpty){
      var res = await LoginController.loginController(email: email.text, pass: pass.text);
      if(res.statusCode == 200){

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Login Success."),
          duration: Duration(milliseconds: 5000),
          backgroundColor: Colors.green,
        ));

        //store login information in local storage.
       LocalStorage.saveLoginData(loginModel: jsonDecode(res.body)!);

        Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage()));
      }else{
        setState(() =>errorString = "Invalid Credential.");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Invalid credential."),
          duration: Duration(milliseconds: 5000),
          backgroundColor: Colors.red,
        ));
      }
    }else{
      setState(() =>errorString = "Field must not be empty.");
    }
    setState(() =>isLoading=false);
  }

}
