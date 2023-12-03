import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../utility/app_color.dart';
import '../../view_controller/appButton.dart';
import '../../view_controller/appInput.dart';
import '../../view_controller/bigText.dart';


class MonthlyStatement extends StatefulWidget {
  const MonthlyStatement({Key? key}) : super(key: key);

  @override
  State<MonthlyStatement> createState() => _MonthlyStatementState();
}

class _MonthlyStatementState extends State<MonthlyStatement> {
  Map<String, double> dataMap = {
    "Total Hour": 5,
    "Hourly Rate": 3,
    "Total Payment": 2,
    "Due Payment": 2,
  };

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Row(
                 children: [
                   IconButton(onPressed:()=>Get.back(), icon: Icon(Icons.arrow_back,)),
                   BigText(text: "Johan - Monthly Salary Management"),
                 ],
               ),
               InkWell(
                 onTap: (){},
                 child: Container(

                   padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                   decoration: BoxDecoration(
                       color: AppColors.green,
                       borderRadius: BorderRadius.circular(10)
                   ),
                   child: Row(
                     children: [
                       Icon(Icons.print, color: Colors.white,),
                       Text("Print",
                         style: TextStyle(
                             fontSize: 15,
                             fontWeight: FontWeight.w400,
                             color: Colors.white
                         ),
                       )
                     ],
                   ),
                 ),
               ),
             ],
           ),

            SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Salary Banding for (Aug)",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text("\$480.00",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          // height: 370,
                          width: size.width*.50,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Text("History",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 20,),
                              buildDetailsTableText(
                                size: size,
                                leftText: "Employ Name",
                                rightTxt: "Nayon Talukder",
                              ),
                              buildDetailsTableText(
                                  size: size,
                                  leftText: "Employ Type",
                                  rightTxt: "Hourly",
                                  rightTextColor: Colors.red
                              ),
                              buildDetailsTableText(
                                  size: size,
                                  leftText: "Per Hour",
                                  rightTxt: "\$12",
                                  rightTextColor: Colors.black87
                              ),
                              buildDetailsTableText(
                                  size: size,
                                  leftText: "Total Working Time",
                                  rightTxt: "129 Hours",
                                  rightTextColor: Colors.black87,
                                  rightTextWeight: FontWeight.w500
                              ),
                              buildDetailsTableText(
                                  size: size,
                                  leftText: "Total Tax",
                                  rightTxt: "-120\$",
                                  rightTextColor: Colors.red,
                                  rightTextSize: 16,
                                  rightTextWeight: FontWeight.w400
                              ),
                              buildDetailsTableText(
                                  size: size,
                                  leftText: "Total pay for this month",
                                  rightTxt: "\$460",
                                  rightTextColor: Colors.indigo,
                                  rightTextSize: 16,
                                  rightTextWeight: FontWeight.bold
                              ),

                              buildDetailsTableText(
                                  size: size,
                                  leftText: "Total Due ",
                                  leftTextColor: Colors.blue,
                                  rightTxt: "200\$",
                                  rightTextColor: Colors.blue,
                              ),


                              SizedBox(height: 20,),
                              AppButton(onClick: ()=>_showMyDialog(size), text: "Pay Due & Clear", width: size.width*.10)


                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Container(
                            height: 370,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Text("Chart",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                PieChart(
                                  dataMap: dataMap,
                                  animationDuration: Duration(milliseconds: 800),
                                  chartLegendSpacing: 25,
                                  chartRadius: MediaQuery.of(context).size.width / 1,
                                  colorList: [
                                    Colors.red,
                                    Colors.green,
                                    Colors.indigo,
                                    Colors.pink
                                  ],
                                  initialAngleInDegree: 0,
                                  chartType: ChartType.ring,
                                  ringStrokeWidth: 15,
                                  centerText: "Chart",
                                  legendOptions: LegendOptions(
                                    showLegendsInRow: true,
                                    legendPosition: LegendPosition.bottom,
                                    showLegends: true,
                                    legendTextStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 8
                                    ),
                                  ),
                                  chartValuesOptions: ChartValuesOptions(
                                    showChartValueBackground: false,
                                    showChartValues: true,
                                    showChartValuesInPercentage: false,
                                    showChartValuesOutside: true,
                                    decimalPlaces: 1,
                                  ),
                                  // gradientList: ---To add gradient colors---
                                  // emptyColorGradient: ---Empty Color gradient---
                                ),
                              ],
                            )
                        ),
                      )
                    ],
                  )
                ],
              ),
            )

          ],
        ),
      ),
    );
  }



  Container buildDetailsTableText({
    required String leftText,
    required String rightTxt,
    Color leftTextColor = Colors.black,
    Color rightTextColor =  Colors.black,
    double rightTextSize = 14.00,
    double leftTextSize = 14.0,
    FontWeight leftTextWeight = FontWeight.w400,
    FontWeight rightTextWeight = FontWeight.w400,
    required Size size,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: size.width*.20,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(width: 1, color: AppColors.grey.withOpacity(0.5)),
                  )
              ),
              child:  Text("$leftText",
                style: TextStyle(
                    fontSize: leftTextSize,
                    fontWeight: leftTextWeight,
                    color: leftTextColor
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: size.width*.20,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(width: 1, color: AppColors.grey)
                  )
              ),
              child:  Text(": $rightTxt",
                style: TextStyle(
                    fontSize: rightTextSize,
                    fontWeight: rightTextWeight,
                    color: rightTextColor
                ),
              ),
            ),
          )
        ],
      ),
    );
  }



  ///show dilog
  final amount = TextEditingController();
  var paymentType;
  List<String> paymentTypeList = [
    "Check",
    "Cash"
  ];

  Future<void> _showMyDialog(size) async {
    amount.text = "400";

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
              builder: (context, setState) {
                return SingleChildScrollView(
                  child: ListBody(
                    children:  <Widget>[
                      Center(
                        child: Text("Salary Panding for Aug 13 - Aug 20",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Center(
                        child: Text("\$200.00",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      AppInput(controller: amount, prefixIcon: Icons.attach_money, title: "Amount", hintText: "Payment amount \$400"),
                      SizedBox(height: 20,),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text(
                            'Select payment type',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: paymentTypeList
                              .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                              .toList(),
                          value: paymentType,
                          onChanged: (String? value) {
                            setState(() {
                              paymentType = value;
                            });
                          },
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            height: 40,
                            width: 140,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      AppButton(onClick: ()=>Navigator.pop(context), text: "Pay Now", width: size.width*.10)

                    ],
                  ),
                );
              }
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
