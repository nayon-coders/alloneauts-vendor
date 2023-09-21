import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/response.dart';
import 'package:vendor/view_controller/appButton.dart';

import '../../utility/app_color.dart';
import '../../view/auth/accountVerificationCenter.dart';
class AccountVerificationWorning extends StatelessWidget {
  const AccountVerificationWorning({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.isDesktop(context) ? size.width*.80 : size.width,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(5)
      ),
      child:  Responsive.isMobile(context)
          ? Column(
        children: [
          WorkingContant(size: size),
          SizedBox(height: 10,),
          AppButton(
            onClick: ()=>Get.to(AccountVerificationCenter()),
            bgColor: AppColors.red,
            text: "Verification",
            textSize: 10,
            width: size.width,
          )
        ],
      )
          : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WorkingContant(size: size),
              AppButton(
                onClick: ()=>Get.to(AccountVerificationCenter()),
                bgColor: AppColors.red,
                text: "Verification",
                textSize: 10,
                width: size.width*.15,
              )
            ],
          ),
    );
  }
}

class WorkingContant extends StatelessWidget {
  const WorkingContant({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.isMobile(context) ? size.width : size.width*.60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Account verification is required.',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.red
            ),
          ),
          Text('You need verify your account by submit some documents. Click Verification Center to verify your account.',
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

