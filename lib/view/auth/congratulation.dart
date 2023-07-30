import 'package:flutter/material.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view/main_pages.dart';
import '../../view_controller/appButton.dart';
import '../../view_controller/bigText.dart';

class Congratulation extends StatefulWidget {
  final String title;const Congratulation({Key? key, required this.title,}) : super(key: key);

  @override
  State<Congratulation> createState() => _CongratulationState();
}

class _CongratulationState extends State<Congratulation> {
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
                  const SizedBox(height: 40,),
                   Center(child: BigText(text: "${widget.title}")),
                  const SizedBox(height: 40,),
                  const Icon(Icons.check_circle, size: 120, color: AppColors.green,),
                  const SizedBox(height: 30,),
                  Align(
                    alignment: Alignment.center,
                    child: AppButton(
                      width: size.width*.30,
                      text: "Go to Dashboard",
                      onClick: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage())),
                    ),
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
