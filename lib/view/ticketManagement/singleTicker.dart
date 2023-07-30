import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view_controller/appButton.dart';
import 'package:vendor/view_controller/appInput.dart';
import 'package:vendor/view_controller/richText.dart';

import '../../carImageJson.dart';
import '../../view_controller/appIconButton.dart';
import '../../view_controller/bigText.dart';

class SingleTicket extends StatefulWidget {
  const SingleTicket({Key? key}) : super(key: key);

  @override
  State<SingleTicket> createState() => _SingleTicketState();
}

class _SingleTicketState extends State<SingleTicket> {
  final singlePay = TextEditingController();

  Map<String, double> paiRentRequestReportData = {
    "Pay Amount": 120,
    "Due Amount": 120,
    "Amount Balance": 120,
  };

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: EdgeInsets.only(left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.arrow_back), iconSize: 20,),
                      SizedBox(width: 20,),
                      Image.asset("assets/images/car1.png", height: 100, width: 100,),
                    ],
                  ),
                  SizedBox(width: 10,),
                  Column(
                    children: [
                      Text("Car Name here",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text("Plate No. #TC7367394",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: size.width,
              padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("Total Ticket",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.white
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text("20",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: AppColors.white
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Total Pay",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: AppColors.white
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text("\$500",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: AppColors.white
                        ),
                      ),
                    ],
                  ),
                  AppButton(
                      onClick: (){},
                      text: "Pay All",
                      width: 100,
                      bgColor: Colors.white,
                      textColor:AppColors.green,
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
            for(var i=0;i<13; i++)
              buildSingleTicket(),
          ],
        ),
      ),
    );
  }

  Container buildSingleTicket() {
    return Container(
            // width: size.width*.55,
            padding: EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
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
                BigText(text: "40-Fire Hydent"),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       RichTextWidget(leftText: "Ticket Id: ", rightText: "#847573839"),
                       SizedBox(height: 7,),
                       RichTextWidget(leftText: "Plate No.: ", rightText: "#TC74657JH74"),
                       SizedBox(height: 7,),
                       RichTextWidget(leftText: "Issus Date: ", rightText: "23-12-2023"),
                       SizedBox(height: 7,),
                       RichTextWidget(leftText: "Amount Due: ", rightText: "\$120"),
                       SizedBox(height: 7,),
                       RichTextWidget(leftText: "Amount Blance: ", rightText: "\$120"),
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
}
