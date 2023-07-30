import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view/auth/congratulation.dart';

import '../../view_controller/appButton.dart';
import '../../view_controller/bigText.dart';

class AccountVerificationCenter extends StatefulWidget {
  const AccountVerificationCenter({Key? key}) : super(key: key);

  @override
  State<AccountVerificationCenter> createState() => _AccountVerificationCenterState();
}

class _AccountVerificationCenterState extends State<AccountVerificationCenter> {
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
              width: size.width*.50,
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
                  SizedBox(height: 30,),
                  BigText(text: "Account Verification Center"),
                  SizedBox(height: 10,),
                  Text("You need to upload following Document for verification.",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Divider(height: 1, color: Colors.grey,),
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
                            Text("Contact person photo ID or driving license. (JPG, PNG, JPEG ect).",

                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(height: 10,),
                            Icon(Icons.add, size: 15, color: Colors.black,)
                          ],
                        )
                    ),
                  ),

                  SizedBox(height: 20,),

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
                                    Center(child: Text("Legal business name (store front picture)(JPG, PNG, JPEG ect).",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400
                                      ),
                                    )),
                                    SizedBox(height: 10,),
                                    Icon(Icons.add, size: 15, color: Colors.black,)
                                  ],
                                ),
                              )
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
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
                                    Center(child: Text("Business structure (e.g., sole proprietorship, partnership, corporation)(JPG, PNG, JPEG ect).",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400
                                      ),
                                    )),
                                    SizedBox(height: 10,),
                                    Icon(Icons.add, size: 15, color: Colors.black,)
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
                                    Center(child: Text("Tax identification number (TIN)(JPG, PNG, JPEG ect).",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400
                                      ),
                                    )),
                                    SizedBox(height: 10,),
                                    Icon(Icons.add, size: 15, color: Colors.black,)
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
                                    Center(child: Text("Business registration/license number (if applicable) (JPG, PNG, JPEG ect).",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400
                                      ),
                                    )),
                                    SizedBox(height: 10,),
                                    Icon(Icons.add, size: 15, color: Colors.black,)
                                  ],
                                ),
                              )
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppButton(onClick: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const Congratulation(title: "You account has been under review."))), bgColor: AppColors.green, text: "Submit for Review", width: 200),
                      SizedBox(width: 10,),
                      AppButton(onClick: ()=>Navigator.pop(context), bgColor: AppColors.red, text: "Later", width: 100),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



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

}
