import 'dart:convert';
import 'dart:typed_data';
import 'package:vendor/utility/app_const.dart';
import 'package:vendor/view/auth/set_password.dart';
import 'package:vendor/view_controller/richText.dart';

import '../../firebase/model/pricing_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view/auth/login.dart';
import 'package:vendor/view_controller/appButton.dart';
import 'package:vendor/view_controller/appInput.dart';
import 'package:vendor/view_controller/bigText.dart';
import 'dart:html' as html;

class SignUp extends StatefulWidget {
  final Monthly? pricingModel;
  const SignUp({Key? key, this.pricingModel}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final fname = TextEditingController();
  final lname = TextEditingController();
  final companyName = TextEditingController();
  final mailingAddress = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final website = TextEditingController();


  final yearsBusiness = TextEditingController();
  final brefDescribe = TextEditingController();



  List<int>? idOrDrivingLicense; //index - 1
  List<int>? legaleBusnessName; // index - 2
  List<int>? businessStructure; // index - 3
  List<int>? texIdentificationNumber; //index - 4
  List<int>? buinessLicense; // index - 5


  Uint8List? idOrDrivingLicenseData;
  Uint8List? legaleBusnessNameData;
  Uint8List? businessStructureData;
  Uint8List? texIdentificationNumberData;
  Uint8List? buinessLicenseData;

  //lsit of pricing car
  List carsListForPricing = [
    "5-10", "10-20", "20-30", "30-50"
  ];
  List selectCarListForPricing = []; //this is initially empty

  startWebFilePicker(index) async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      print("this is files === $files");
      final file = files![0];
      final reader = html.FileReader();
      reader.onLoadEnd.listen((event) {
        setState(() {
          if(index == 1){
            idOrDrivingLicenseData = Base64Decoder().convert(reader.result.toString().split(",").last);
            idOrDrivingLicense = idOrDrivingLicenseData;
          }else if(index == 2){
            legaleBusnessNameData = Base64Decoder().convert(reader.result.toString().split(",").last);
            legaleBusnessName = legaleBusnessNameData;
          }else if(index == 3){
            businessStructureData = Base64Decoder().convert(reader.result.toString().split(",").last);
            businessStructure = businessStructureData;
          }else if(index == 4){
            texIdentificationNumberData = Base64Decoder().convert(reader.result.toString().split(",").last);
            texIdentificationNumber = texIdentificationNumberData;
          }else{
            buinessLicenseData = Base64Decoder().convert(reader.result.toString().split(",").last);
            buinessLicense = buinessLicenseData;
          }

        });
      });
      reader.readAsDataUrl(file);
    });
  }


  var _value = 0.00;

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
              width: size.width*.40,
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
                  const BigText(text: "Welcome to AllOneAutos"),
                  SizedBox(height: 10,),
                  const Text("Register your account"),
                  SizedBox(height: 10,),
                  const Text("Plan",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10,),
                   Text("${widget.pricingModel!.planName}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green
                    ),
                  ),
                  const SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width*.16,
                        child: AppInput(
                            controller: fname,
                            title: "First Name",
                            prefixIcon: Icons.person,
                            hintText: "First Name"
                        ),
                      )  ,
                      SizedBox(
                        width: size.width*.16,
                        child: AppInput(
                            controller: lname,
                            title: "Last Name",
                            prefixIcon: Icons.person,
                            hintText: "Last Name"
                        ),
                      )
                    ],
                  ),

                  // SizedBox(height: 20,),

                  SizedBox(height: 20,),
                  AppInput(
                      controller: companyName,
                      title: "Company Name",
                      prefixIcon: Icons.house_siding_rounded,
                      hintText: "Type your Company Name"
                  ),
                  SizedBox(height: 20,),
                  AppInput(
                      controller: email,
                      title: "Email",
                      prefixIcon: Icons.email_outlined,
                      hintText: "johon@gmail.com"
                  ),
                  SizedBox(height: 20,),
                  AppInput(
                      controller: phoneNumber,
                      title: "Phone Number",
                      prefixIcon: Icons.phone_android,
                      hintText: "+1 **** **** **"
                  ),


                  SizedBox(height: 20,),
                  AppInput(
                      controller: yearsBusiness,
                      title: "Years in business (number input)",
                      prefixIcon: Icons.calendar_month,
                      hintText: "Years in business (number input)"
                  ),
                  SizedBox(height: 20,),
                 Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     const Text("Brief of the company's products/services",
                       style: TextStyle(
                           fontWeight: FontWeight.w600,
                           fontSize: 15,
                           color: AppColors.black
                       ),
                     ),
                     SizedBox(height: 10,),
                     TextFormField(
                       maxLines: 8,
                       controller: brefDescribe,
                       decoration: InputDecoration(
                         hintText: "Brief description of the company's products/services",
                         border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(5),
                             borderSide: BorderSide(width: 1, color: AppColors.green.withOpacity(0.3))
                         ),
                         enabledBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(5),
                             borderSide: BorderSide(width: 1, color: AppColors.green.withOpacity(0.3))
                         ),
                         focusedBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(5),
                             borderSide: BorderSide(width: 1, color: AppColors.green.withOpacity(0.8))
                         ),
                       ),
                     ),
                   ],
                 ),
                  SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("How many car you have?",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: AppColors.black
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: RichTextWidget(leftText: "You can add ", rightText: "${widget.pricingModel!.maxCar}")),
                 Align(
                   alignment: Alignment.centerLeft,
                   child: TextButton(
                     onPressed: ()=>Navigator.pushNamed(context, "/pricing"),
                    child:  Text("I you want to add more car, then upgrade your plan.",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10
                      ),
                    )
                   ),
                 ),
                 //  SizedBox(height: 20,),
                 // selectCarListForPricing.isNotEmpty ? Container(
                 //    padding: EdgeInsets.all(20),
                 //    decoration: BoxDecoration(
                 //      color: Colors.transparent,
                 //      border: Border.all(width: 1, color: AppColors.green.withOpacity(0.3))
                 //    ),
                 //    child:Column(
                 //      children: [
                 //        Text("\$$_value",
                 //          style: TextStyle(
                 //            fontWeight: FontWeight.bold,
                 //            fontSize: 50,
                 //          ),
                 //        ),
                 //        SizedBox(height: 5,),
                 //        Text("USD per month",
                 //          style: TextStyle(
                 //            fontWeight: FontWeight.w600,
                 //            fontSize: 13,
                 //          ),
                 //        ),
                 //        SizedBox(height: 8,),
                 //        Text("Additional charges: 4.5% transaction fee. 12 months minimum contract period.",
                 //          style: TextStyle(
                 //            fontWeight: FontWeight.w400,
                 //            fontSize: 13,
                 //          ),
                 //        ),
                 //        SizedBox(height: 8,),
                 //        TextButton(
                 //          onPressed: (){},
                 //          child: Text("Learn More...",
                 //            style: TextStyle(
                 //              fontSize: 10,
                 //              color: AppColors.blue
                 //            ),
                 //          ),
                 //        )
                 //      ],
                 //    ),
                 //  ) : SizedBox(),



                  SizedBox(height: 30,),
                  Align(
                    alignment: Alignment.center,
                    child: AppButton(
                      width: size.width*.30,
                      text: "Continue",
                      onClick: ()=> _signupMethod()
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

  Expanded buildHowManyCars({required VoidCallback onClick,required String value,  Color color = Colors.transparent, Color textColor = AppColors.green, }) {
    return Expanded(
                    child: InkWell(
                      onTap: onClick,
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: color,
                          border: Border.all(width: 1, color: AppColors.green)
                        ),
                        child: Center(
                          child: Text("$value",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: textColor
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
  }

  void _signupMethod() {
    var data = {
      "f_name" : fname.text,
      "l_name" : lname.text,
      "email" : email.text,
      "company_name" : companyName.text,
      "years_in_business" : yearsBusiness.text,
      "brief_company" : brefDescribe.text,
      "max_car": widget.pricingModel!.maxCar,
      "selected_plan" : {
        "max_car" :  widget.pricingModel?.maxCar,
        "plan_name" :  widget.pricingModel?.planName,
        "price" :  widget.pricingModel?.price,
      },
    };
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SetPassword(signUpData: data)));
  }
}
