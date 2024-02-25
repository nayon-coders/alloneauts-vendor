import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/firebase/controller/auth_controller.dart';
import 'package:vendor/response.dart';
import 'package:vendor/view/auth/verification_center/emialVerification.dart';
import 'package:vendor/view_controller/appButton.dart';

import '../../utility/app_color.dart';
import '../../view/auth/verification_center/accountVerificationCenter.dart';
class AccountVerificationWorning extends StatefulWidget {
  const AccountVerificationWorning({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<AccountVerificationWorning> createState() => _AccountVerificationWorningState();
}

class _AccountVerificationWorningState extends State<AccountVerificationWorning> {

  ///========= get user id ========//

  ///========= get user id ========//

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuthController.getVendorProfile(),
      builder: (_,  snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center();
        }else if(snapshot.hasData){
          //find current user informaton from snapshot
          List<QueryDocumentSnapshot<Map<String, dynamic>>> data =[];


          snapshot.data!.docs.forEach((doc) {
            if(doc.data()["email"] == FirebaseAuth.instance.currentUser?.email){
              data.add(doc);
            }
          });

          if(data[0]["verify_email"] != true){
            return  Container(
              width: Responsive.isDesktop(context) ? widget.size.width*.80 : widget.size.width,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color:  AppColors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5)
              ),
              child:  Responsive.isMobile(context)
                  ? Column(
                children: [
                  WorkingContant(size: widget.size, title: "Email verification is required.", text: "You need verify your Email. Click Verification Center to verify your account.",),
                  SizedBox(height: 10,),
                  AppButton(
                    onClick: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> EmailVerification(email: data[0]["email"], user_id: data[0].id))),
                    bgColor: AppColors.red,
                    text: "Verify Email",
                    textSize: 10,
                    width: widget.size.width,
                  )
                ],
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WorkingContant(size: widget.size, title: "Email verification is required.", text: "You need verify your Email. Click Verification Center to verify your account.",),
                  AppButton(
                    onClick: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> EmailVerification(email: data[0]["email"], user_id: data[0].id))),
                    bgColor: AppColors.red,
                    text: "Verify Email",
                    textSize: 10,
                    width: widget.size.width*.15,
                  )
                ],
              ),
            );
          }else if(data[0]["verify_account"] != true){
            return  Container(
              width: Responsive.isDesktop(context) ? widget.size.width*.80 : widget.size.width,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color:  AppColors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5)
              ),
              child:  Responsive.isMobile(context)
                  ? Column(
                children: [
                  WorkingContant(size: widget.size, title: "Account verification is required.", text: "You need verify your account by submit some documents. Click Verification Center to verify your account.",),
                  SizedBox(height: 10,),
                  AppButton(
                    onClick: ()=>Get.to(AccountVerificationCenter(user_id: data[0].id,)),
                    bgColor: AppColors.red,
                    text: "Account Verify",
                    textSize: 10,
                    width: widget.size.width,
                  )
                ],
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WorkingContant(size: widget.size, title: "Account verification is required.", text: "You need verify your account by submit some documents. Click Verification Center to verify your account.",),
                  AppButton(
                    onClick: ()=>Get.to(AccountVerificationCenter(user_id: data[0].id,)),
                    bgColor: AppColors.red,
                    text: "Account Verify",
                    textSize: 10,
                    width: widget.size.width*.15,
                  )
                ],
              ),
            );
          }else{
            return Center();
          }
        }else{
          return Center(child: Text("Someting went wrong with server."),);
        }

      },
    );
  }
}

class WorkingContant extends StatelessWidget {
  const WorkingContant({
    Key? key,
    required this.size,
    required this.text,
    required this.title
  }) : super(key: key);

  final Size size;
  final String text;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.isMobile(context) ? size.width : size.width*.60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Text('$title',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.red
            ),
          ),
          Text('$text',
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Colors.grey
            ),
          ),
        ],
      ),
    );
  }
}

