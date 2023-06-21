import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view/main_pages.dart';
import 'package:vendor/view_controller/appButton.dart';
import 'package:vendor/view_controller/appInput.dart';
import 'package:vendor/view_controller/bigText.dart';
import 'dart:html' as html;
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final name = TextEditingController();
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
            width: size.width*.60,
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
                Text("Register your accout"),
                SizedBox(height: 40,),
                Text("Contact Information",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 10,),
                AppInput(
                    controller: name,
                    title: "Name",
                    prefixIcon: Icons.person,
                    hintText: "Nayon talukder"
                ),
                SizedBox(height: 20,),
                InkWell(
                  onTap:()=>startWebFilePicker(1),
                  child: Container(
                      height: 200,
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade200,
                      ),
                      child: idOrDrivingLicenseData != null
                          ? Image.memory(idOrDrivingLicenseData!, width: 200, height: 200)
                          : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Contact person photo ID or driving license. (JPG, PNG, JPEG ect)."),
                          SizedBox(height: 5,),
                          Icon(Icons.add, color: Colors.black,)
                        ],
                      )
                  ),
                ),
                SizedBox(height: 20,),
                AppInput(
                    controller: companyName,
                    title: "Company Name",
                    prefixIcon: Icons.house_siding_rounded,
                    hintText: "Type your Company Name"
                ),
                SizedBox(height: 20,),
                AppInput(
                    controller: mailingAddress,
                    title: "Company Name",
                    prefixIcon: Icons.location_city,
                    hintText: "Type your Mailing address"
                ),
                SizedBox(height: 20,),
                AppInput(
                    controller: email,
                    title: "Email",
                    readOnly: true,
                    prefixIcon: Icons.email_outlined,
                    hintText: "alloneautos@gmail.com"
                ),
                SizedBox(height: 20,),
                AppInput(
                    controller: email,
                    title: "Phone Number",
                    readOnly: true,
                    prefixIcon: Icons.phone_android,
                    hintText: "+928495893439"
                ),
                SizedBox(height: 40,),
                Text("Company Information",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 40,),

                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap:()=>startWebFilePicker(2),
                        child: Container(
                            height: 200,
                            width: size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade200,
                            ),
                            child: legaleBusnessNameData != null
                                ? Image.memory(legaleBusnessNameData!, width: 200, height: 200)
                                : Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(child: Text("Legal business name (store front picture)(JPG, PNG, JPEG ect).")),
                                  SizedBox(height: 10,),
                                  Icon(Icons.add, color: Colors.black,)
                                ],
                              ),
                            )
                        ),
                      ),
                    ),

                    SizedBox(width: 10,),

                    Expanded(
                      child: InkWell(
                        onTap:()=>startWebFilePicker(3),
                        child: Container(
                            height: 200,
                            width: size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade200,
                            ),
                            child: businessStructureData != null
                                ? Image.memory(businessStructureData!, width: 200, height: 200)
                                : Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(child: Text("Business structure (e.g., sole proprietorship, partnership, corporation)(JPG, PNG, JPEG ect).")),
                                  SizedBox(height: 10,),
                                  Icon(Icons.add, color: Colors.black,)
                                ],
                              ),
                            )
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20,),

                Row(
                  children: [
                    Expanded(
                      child:InkWell(
                        onTap:()=>startWebFilePicker(4),
                        child: Container(
                            height: 200,
                            width: size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade200,
                            ),
                            child: texIdentificationNumberData != null
                                ? Image.memory(texIdentificationNumberData!, width: 200, height: 200)
                                : Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(child: Text("Tax identification number (TIN)(JPG, PNG, JPEG ect).")),
                                  SizedBox(height: 10,),
                                  Icon(Icons.add, color: Colors.black,)
                                ],
                              ),
                            )
                        ),
                      ) ,
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child:    InkWell(
                        onTap:()=>startWebFilePicker(5),
                        child: Container(
                            height: 200,
                            width: size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade200,
                            ),
                            child: buinessLicenseData != null
                                ? Image.memory(buinessLicenseData!, width: 200, height: 200)
                                : Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(child: Text("Business registration/license number (if applicable) (JPG, PNG, JPEG ect).")),
                                  SizedBox(height: 10,),
                                  Icon(Icons.add, color: Colors.black,)
                                ],
                              ),
                            )
                        ),
                      ),
                    )
                  ],
                ),

                SizedBox(height: 20,),
                AppInput(
                    controller: yearsBusiness,
                    title: "Years in business (number input)",
                    prefixIcon: Icons.calendar_month,
                    hintText: "Years in business (number input)"
                ),
                SizedBox(height: 20,),
                AppInput(
                    maxLine: 4,
                    controller: yearsBusiness,
                    title: "Brief description of the company's products/services",
                    hintText: "Brief description of the company's products/services"
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
                    onPressed: (){},
                    child: Text("I have an accout. Login."),
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
