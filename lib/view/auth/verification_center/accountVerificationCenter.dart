import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vendor/firebase/controller/auth_controller.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/utility/app_const.dart';
import 'package:vendor/view/auth/congratulation.dart';
import '../../../view_controller/appButton.dart';
import '../../../view_controller/bigText.dart';

class AccountVerificationCenter extends StatefulWidget {
  final String user_id;
  const AccountVerificationCenter({Key? key, required this.user_id}) : super(key: key);

  @override
  State<AccountVerificationCenter> createState() => _AccountVerificationCenterState();
}

class _AccountVerificationCenterState extends State<AccountVerificationCenter> {

  final email = TextEditingController();

  File? idProveFile;
  File? businessProveFile;
  Uint8List? idProveUint8List;
  Uint8List? businessProveUint8List;

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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: ()=>Navigator.pushNamed(context, "/dashboard"),
                          icon: Icon(Icons.arrow_back, color: Colors.green,),
                        ),
                        SizedBox(width: 10,),
                        Text("Go back",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.green
                          ),
                        ),
                      ],
                    ),
                  ),
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

                  ///============business verification =========//
                  Column(
                    children: [
                      const Text("Business Verification",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap:()async{
                                startWebFilePicker(1);

                              },
                              child: Column(
                                children: [
                                  RichText(text: const TextSpan(
                                      children: [
                                        TextSpan(
                                            text: "Personal Verification",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: Colors.black
                                            )
                                        ),
                                        TextSpan(
                                            text: " (Upload Passport, Driving Licence)",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                                color: Colors.green
                                            )
                                        )
                                      ]
                                  )),
                                  SizedBox(height: 10,),
                                  DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(12),
                                    // padding: EdgeInsets.all(6),
                                    child: Container(
                                        height: 200,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.white
                                        ),
                                        child: idOrDrivingLicenseData != null
                                            ? Image.memory(idOrDrivingLicenseData!, width: 200, height: 200)
                                            : Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.upload_file_rounded, size: 40, color: Colors.green,),
                                            SizedBox(height: 10,),
                                            Text("JPG, PNG, JPEG Format",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10,
                                                    color: Colors.green
                                                )
                                            )
                                          ],
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 20,),
                          Expanded(
                            child: InkWell(
                              onTap:()async{
                                startWebFilePicker(2);
                              },
                              child: Column(
                                children: [
                                  RichText(text: const TextSpan(
                                      children: [
                                        TextSpan(
                                            text: "Business Verification ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: Colors.black
                                            )
                                        ),
                                        TextSpan(
                                            text: " (Upload Registration / License)",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                                color: Colors.green
                                            )
                                        )
                                      ]
                                  )),
                                  SizedBox(height: 10,),
                                  DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(12),
                                    // padding: EdgeInsets.all(6),
                                    child: Container(
                                        height: 200,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.white
                                        ),
                                        child: businessProveUint8List != null
                                            ? Image.memory(businessProveUint8List!, width: 200, height: 200)
                                            : Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.upload_file_rounded, size: 40, color: Colors.green,),
                                            SizedBox(height: 10,),
                                            Text("JPG, PNG, JPEG Format",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10,
                                                    color: Colors.green
                                                )
                                            )
                                          ],
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ///============business verification =========//


                  SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppButton(
                        isLoading: isLoading,
                        onClick: (){
                        setState(()=> isLoading = true);
                          FirebaseAuthController.accountVefiry(docId: widget.user_id, idProveUrl: idOrDrivingLicenseData!, businessProveUrl: buinessLicenseData!, context: context);
                        setState(()=> isLoading = false);
                      }, bgColor: AppColors.green, text: "Submit for Review", width: 200, ),
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
  List<int>? buinessLicense; // index - 2


  Uint8List? idOrDrivingLicenseData;
  Uint8List? buinessLicenseData;
  var businessLicense;
  startWebFilePicker(index) async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((event) async{
      final files = uploadInput.files;
      print("this is files === ${files![0].name}");
      final file = files![0];

      final reader = html.FileReader();
      reader.onLoadEnd.listen((event) {
        setState(() {
          if(index == 1){

            idOrDrivingLicenseData = Base64Decoder().convert(reader.result.toString().split(",").last);
            idOrDrivingLicense = idOrDrivingLicenseData;

          }
          if(index == 2){
            buinessLicenseData = Base64Decoder().convert(reader.result.toString().split(",").last);
            businessProveUint8List = buinessLicenseData;
          }

        });
      });
      reader.readAsDataUrl(file);
    });
  }



  ///============ this is for verify documents ===================///
  bool isLoading = false;







}
