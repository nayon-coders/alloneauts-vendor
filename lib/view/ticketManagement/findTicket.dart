import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vendor/app_config.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view_controller/appButton.dart';
import 'package:vendor/view_controller/appInput.dart';
import 'package:http/http.dart' as http;
import 'package:vendor/view_controller/bigText.dart';

import '../../model/cameraVoilationModel.dart';
import '../../view_controller/richText.dart';



class FindTicket extends StatefulWidget {
  const FindTicket({Key? key}) : super(key: key);

  @override
  State<FindTicket> createState() => _FindTicketState();
}

class _FindTicketState extends State<FindTicket> {
  final platNo = TextEditingController();
  final platState = TextEditingController();
  final platType = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    platNo.text = "T684813C";
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back, color: AppColors.green,)),
                  Text("Find Ticket",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.green
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              BigText(text: "NYC Department of Finance Parking and Camera Violations"),
              SizedBox(height: 30,),
              Row(
                children: [
                  SizedBox(
                    width: size.width*.70,
                    child: TextFormField(
                      controller: platNo,
                      decoration: InputDecoration(
                        fillColor: AppColors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            topLeft: Radius.circular(5),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Plate no.",
                        prefixIcon: Icon(Icons.search, color: AppColors.green,),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: ()=>searchTicket(),
                    child: Container(
                      width: size.width*.10,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                        color: AppColors.green,
                      ),
                      child: Center(
                        child: Text("Search",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.white,

                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
               nycCameraViolationList.isNotEmpty
                 ? SizedBox(
                   child: ListView.builder(
                     shrinkWrap: true,
                    itemCount: nycCameraViolationList.length,
                    itemBuilder: (_, index){
                       var data = nycCameraViolationList[index];
                        return Container(
                          width: size.width,
                          child: buildSingleTicket(data),
                        );
                    },
                  ),
                 )
                 : isSearch ? CircularProgressIndicator() : Center(child: Text("No data found"),)




            ],
          ),
        ),
      ),
    );
  }

  Column searchByVoilation() {
    return Column(
      children: [
        AppInput(controller: platNo, title: "Plate No", hintText: "Enter 10 digit violation number"),
        SizedBox(height: 20,),
        AppButton(onClick: (){}, text: "Search", width: 200)
      ],
    );
  }

  //buildSingleTicket
  Container buildSingleTicket(data) {
    return Container(
      // width: size.width*.55,
        padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
        margin: EdgeInsets.only(bottom: 20),
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigText(text: "${data["violation"]}"),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichTextWidget(leftText: "Plate No.: ", rightText: "#${data["plate"]}"),
                    SizedBox(height: 9,),
                    RichTextWidget(leftText: "Issues Date: ", rightText: "${data["issue_date"]}"),
                    SizedBox(height: 9,),
                    RichTextWidget(leftText: "Fine Amount: ", rightText: "\$${data["fine_amount"]}"),
                    SizedBox(height: 7,),
                    RichTextWidget(leftText: "Due Amount: ", rightText: "\$${data["amount_due"]}"),
                    SizedBox(height: 7,),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        AppButton( onClick: (){}, text: "Ticket Image", width: 120, bgColor: Colors.transparent, borderColor: AppColors.green, textColor: AppColors.green,),
                        SizedBox(width: 10,),
                        AppButton(onClick: (){}, text: "Ticket Details", width: 120),
                      ],
                    ),
                    SizedBox(height: 30,),
                    Row(
                      children: [
                        SizedBox(width: 200,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                                  hintText: "\$120",
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        bottomLeft: Radius.circular(5),
                                      ),
                                      borderSide: BorderSide(width: 1, color: AppColors.green)
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        bottomLeft: Radius.circular(5),
                                      ),
                                      borderSide: BorderSide(width: 1, color: AppColors.green)
                                  )
                              ),
                            )
                        ),
                        Container(
                          height:48,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                            color: AppColors.green,
                          ),
                          child: Center(
                            child: Text("Pay",
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Image.asset("assets/images/car1.png", height: 100, width: 100,),
                // PieChart(
                //   dataMap: paiRentRequestReportData,
                //   animationDuration: Duration(milliseconds: 800),
                //   chartLegendSpacing: 15,
                //   chartRadius: 100,
                //   colorList: [
                //     Colors.amber,
                //     Colors.green,
                //     Colors.blue
                //   ],
                //   initialAngleInDegree: 0,
                //   chartType: ChartType.ring,
                //   ringStrokeWidth: 15,
                //   legendOptions: LegendOptions(
                //     showLegendsInRow: true,
                //     legendPosition: LegendPosition.bottom,
                //     showLegends: true,
                //     legendShape: BoxShape.circle,
                //     legendTextStyle: TextStyle(
                //       fontWeight: FontWeight.w400,
                //       fontSize: 10
                //     ),
                //   ),
                //   chartValuesOptions: const ChartValuesOptions(
                //     showChartValueBackground: true,
                //     showChartValues: true,
                //     showChartValuesInPercentage: false,
                //     showChartValuesOutside: false,
                //     decimalPlaces: 1,
                //   ),
                //   // gradientList: ---To add gradient colors---
                //   // emptyColorGradient: ---Empty Color gradient---
                // )
              ],
            )
          ],
        )
    );
  }



  bool isSearch = false;
   List nycCameraViolationList = [];
  Future searchTicket() async{
    setState(() =>isSearch = true);
    var response = await http.get(Uri.parse("${AppConfig.NYC_POEN_CAMERA_VOILATION}${platNo.text}"));
    print("response.body ${response.body}");
    print("response.body ${response.statusCode}");
    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      setState(() =>isSearch = false);

       setState(() {
         nycCameraViolationList.addAll(data);
       });
      print("nycCameraViolationList.length === ${nycCameraViolationList}");
      print("nycCameraViolationList.length === ${nycCameraViolationList.length}");
    }
    setState(() =>isSearch = false);

  }
}

