import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/view/auth/login.dart';
import 'package:vendor/view/main_pages.dart';
import 'package:vendor/view/globals.dart' as global;

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

    Future.delayed(Duration(milliseconds: 2000), () {
      getToken();
      // Do something
    });
  }

  String? token;
  bool isChecking = true;
  bool isAuth = true;
  //get token
  Future getToken() async {

    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('token');
    setState(() {
      token = value;
    });

    if(value != null){
      setState(() {
        global.isLoggedIn= true;
        global.token = value!;
      });
      Future.delayed(Duration(milliseconds: 1500), () {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainPage()), (route) => false);
        // Do something
      });
    }else{
      Future.delayed(Duration(milliseconds: 1500), () {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login()), (route) => false);
        // Do something
      });
    }
    print("value === $token");
    setState(() {
      isChecking = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Center(
        child: Container(
          width: 300,
          height: 200,
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            color: const Color(0xFFFFFF),
            borderRadius:
            new BorderRadius.all(new Radius.circular(32.0)),
          ),
          child: isChecking
              ?  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Checking authontication.',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20,),
              SpinKitWave(
                color: Colors.green,
                size: 30.0,
              )
            ],
          )
              : token != null
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(Icons.check_circle, size: 50, color: Colors.green,),
              SizedBox(height: 20,),
              Text('Redirecting to dashboard...',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          )
              :  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(Icons.cancel, size: 50, color: Colors.red,),
              SizedBox(height: 20,),
              Text('Authentication Failed.',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(' Redirecting to login...',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
