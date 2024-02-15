import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/controller/authController/authController.dart';
import 'package:vendor/firebase/controller/auth_controller.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view/auth/login.dart';
import 'package:vendor/view/auth/verification_center/accountVerificationCenter.dart';
import 'package:vendor/view/auth/verification_center/emialVerification.dart';
import 'package:vendor/view_controller/appButton.dart';
import 'package:vendor/view_controller/appInput.dart';
import 'package:vendor/view_controller/appNetworkImage.dart';
import 'package:vendor/view_controller/app_snackbar.dart';
import 'package:vendor/view_controller/loadingWidget.dart';

import '../../view_controller/bigText.dart';
import '../auth/verification_center/phoneVerification.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final name = TextEditingController();
  final companyName = TextEditingController();
  final mailingAddress = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final emargancy_PhoneNumber = TextEditingController();
  final secoundryName = TextEditingController();
  final secoundryPhone = TextEditingController();
  final website = TextEditingController();


  final yearsBusiness = TextEditingController();
  final brefDescribe = TextEditingController();


  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection("vendor").doc("vendor_${_auth.currentUser!.email}").collection("profile").doc("profile").snapshots(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return SizedBox(height: 400, child: Center(child: LoadingWidget(title: "Profile Loading...",),),);
        }else if(snapshot.hasData){
          var data = snapshot.data!.data();
          ///
          /// ======== Now assign data in to text editing controller
          name.text = "${data!["f_name"]} ${data!["f_name"]}";
          companyName.text = data!["company_name"];
          email.text = data!["email"];
          yearsBusiness.text = data!["years_in_business"] ?? "";
          brefDescribe.text = data!["brief_company"] ?? "";
          return Container(
            height: size.height,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: ()=>Navigator.pop(context),
                          icon: Icon(Icons.arrow_back),
                        ),
                        SizedBox(width: 10,),
                        BigText(text: "My Profile"),
                      ],
                    ),
                    AppButton(onClick: ()=>LoginController.logout(context),
                        text: "Logout", width: 100)
                  ],
                ),
                SizedBox(height: 20,),

                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(text: "Contact Information"),
                                SizedBox(height: 10,),
                                AppInput(
                                    controller: name,
                                    title: "Name",
                                    prefixIcon: Icons.person,
                                    hintText: "Nayon talukder"
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
                                    controller: email,
                                    title: "Email",
                                    readOnly: true,
                                    prefixIcon: Icons.email_outlined,
                                    suffixIcon: data!["verify_email"]
                                        ? Icon(Icons.check_circle, color: AppColors.green,)
                                        : TextButton(
                                            onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>EmailVerification(email: email.text, user_id: "vendor_${_auth!.currentUser!.email}"))),
                                            child: Text("Verify Email", style: TextStyle(color: Colors.red),),
                                    ),
                                    hintText: "alloneautos@gmail.com"
                                ),
                                SizedBox(height: 20,),
                                AppInput(
                                    controller: phoneNumber,
                                    title: "Phone Number",
                                    readOnly: true,
                                    prefixIcon: Icons.phone_android,
                                    hintText: "+928495893439",
                                  suffixIcon: data!["verify_phone"]
                                      ? Icon(Icons.check_circle, color: AppColors.green,)
                                      : TextButton(
                                    onPressed: (){
                                      AppSnackBar.appSnackBar("Wait..... We will make it in future.. Working with that.", AppColors.blue, context);
                                    },
                                    //onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>PhoneVerification(number: phoneNumber.text, user_id: "vendor_${_auth!.currentUser!.email}"))),
                                    child: Text("Verify Number", style: TextStyle(color: Colors.red),),
                                  ),
                                ),
                                SizedBox(height: 20,),

                              ],
                            ),
                          ),

                          SizedBox(width: 30,),

                          Expanded(
                            child: SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const BigText(text: "Company Information"),

                                  SizedBox(height: 20,),

                                  SizedBox(height: 20,),
                                  AppInput(
                                      controller: yearsBusiness,
                                      title: "Years in business (number input)",
                                      prefixIcon: Icons.calendar_month,
                                      hintText: "Years in business (number input)"
                                  ),
                                  SizedBox(height: 17,),
                                  AppInput(
                                      maxLine: 5,
                                      controller: brefDescribe,
                                      title: "Brief description of the company's products/services",
                                      hintText: "Brief description of the company's products/services"
                                  ),
                                  SizedBox(height: 20,),
                                  AppInput(
                                      controller: emargancy_PhoneNumber,
                                      title: "Emergency Phone Number",
                                      readOnly: true,
                                      prefixIcon: Icons.phone_android,
                                      hintText: "Emergency Pesone Phone Number"
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      SizedBox(
                        height: 210,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text("Business Lisence",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    width: double.infinity,
                                    height: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(width: 1, color: AppColors.green)
                                      ),
                                      child: data!["business_license"] == null
                                          ? IconButton(
                                        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountVerificationCenter(user_id: "vendor_${_auth!.currentUser!.email}",))),
                                        icon: Icon(Icons.cloud_upload_rounded, color: AppColors.green, size: 100,),
                                      )
                                          : AppNetworkImage(url: data!["business_license"],height: 150, boxFit: BoxFit.contain,)
                                  ),
                                  SizedBox(height: 5,),
                                  Text("You cont change it. If you want to update it, then contact with admin.",
                                    style: TextStyle(
                                        fontSize: 9,
                                        fontStyle:FontStyle.italic,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w400
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 20,),
                            Expanded(
                              child: Column(
                                children: [
                                  Text("ID Prove",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                      height: 150,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(width: 1, color: AppColors.green)
                                      ),
                                      child: data!["id_prove"] == null
                                          ? IconButton(
                                        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountVerificationCenter(user_id: "vendor_${_auth!.currentUser!.email}",))),
                                        icon: Icon(Icons.cloud_upload_rounded, color: AppColors.green, size: 100,),
                                      )
                                          : AppNetworkImage(url: data!["id_prove"],height: 150, boxFit: BoxFit.contain,)
                                  ),
                                  SizedBox(height: 5,),
                                  Text("You cont change it. If you want to update it, then contact with admin.",
                                    style: TextStyle(
                                        fontSize: 9,
                                        fontStyle:FontStyle.italic,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w400
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30,),
                      Align(
                        alignment: Alignment.center,
                        child: AppButton(
                            onClick: (){},
                            text: "Edit Profile",
                            width: 200
                        ),
                      ),
                      SizedBox(height: 30,),
                    ],
                  ),
                )

              ],
            ),
          );
        }else{
          return Center(child: Text("Something went wrong. Please try again."),);
        }

      }
    );
  }
}
