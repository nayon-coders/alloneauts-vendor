import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:vendor/view_controller/appInput.dart';
import 'package:vendor/view_controller/appPoup.dart';

import '../../../utility/app_color.dart';
import '../../../view_controller/appButton.dart';
import '../../../view_controller/bigText.dart';

class TaxManagement extends StatefulWidget {
  const TaxManagement({Key? key}) : super(key: key);

  @override
  State<TaxManagement> createState() => _TaxManagementState();
}

class _TaxManagementState extends State<TaxManagement> {
  final federalIncomeTax = TextEditingController();
  final stateIncomeTax = TextEditingController();
  final medicareTax = TextEditingController();
  final country = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      margin: EdgeInsets.only(left: 150, right: 150, bottom: 10),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BigText(text: "Text Management"),
            ],
          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width*.50, //to get the width of screen
            padding: EdgeInsets.only(left: 150, right: 150, top: 30, bottom: 20),

            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 2, blurRadius: 3,
                      offset: Offset(0,2)
                  )
                ]
            ),
            child: Column(
              children: [
                Text("Setup Payroll tax for your complay policy",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20,),
                Form(
                  child: Column(
                    children: [
                      AppInput(controller: federalIncomeTax, title: "Federal Income Tax", hintText: "10%", prefixIcon: Icons.percent,),
                      SizedBox(height: 15,),
                      AppInput(controller: stateIncomeTax, title: "State Income Tax", hintText: "10%", prefixIcon: Icons.percent,),
                      SizedBox(height: 15,),
                      AppInput(controller: medicareTax, title: "Medicare Tax", hintText: "10%", prefixIcon: Icons.percent,),
                      SizedBox(height: 15,),
                      AppInput(controller: country, title: "Country", hintText: "10%", prefixIcon: Icons.percent,),
                      SizedBox(height: 30,),
                      AppButton(onClick: (){
                        AppPopup.appPopup(context: context, title: "Save Changes", body: "Data successfully Saved", dialogType: DialogType.success, onOkBtn: (){});
                      }, text: "Save Changes", width: 200),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }





}
