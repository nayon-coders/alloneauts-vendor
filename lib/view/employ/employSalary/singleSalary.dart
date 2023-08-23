import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:vendor/view_controller/appButton.dart';
import 'package:vendor/view_controller/appInput.dart';
import 'dart:math' as math;
import '../../../utility/app_color.dart';
import '../../../view_controller/bigText.dart';


class SingleEmploySalary extends StatefulWidget {
  const SingleEmploySalary({Key? key}) : super(key: key);

  @override
  State<SingleEmploySalary> createState() => _SingleEmploySalaryState();
}

class _SingleEmploySalaryState extends State<SingleEmploySalary> {
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
      height: size.height,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: ListView(
        children: [
         SizedBox(
           height: 100,
           child:  Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: const [
               BigText(text: "Johan - Employ Salary Management"),
             ],
           ),
         ),
          SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 6,
              itemBuilder: (_, index){
                return ExpandableNotifier(
                  child: ExpandableTheme(
                    data: ExpandableThemeData(
                        iconColor: Colors.red,
                        animationDuration: const Duration(milliseconds: 500)
                    ),
                    child: ExpandablePanel(
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToExpand: true,
                        tapBodyToCollapse: true,
                        hasIcon: false,
                      ),
                      header: Container(
                        color: Colors.indigoAccent,
                        margin: EdgeInsets.only(top: 20),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              ExpandableIcon(
                                theme: const ExpandableThemeData(
                                  expandIcon: Icons.arrow_right,
                                  collapseIcon: Icons.arrow_drop_down,
                                  iconColor: Colors.white,
                                  iconSize: 28.0,
                                  iconRotationAngle: math.pi / 2,
                                  iconPadding: EdgeInsets.only(right: 5),
                                  hasIcon: false,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "${index+1} st Week (Day 10-17) - March 2023",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      collapsed: Container(),
                      expanded: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Salary Banding for (Aug 13 - Aug 20)",
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
                                   height: 370,
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
                                           leftText: "Payment Status",
                                           rightTxt: "Pending",
                                           rightTextColor: Colors.blue,
                                         rightTextSize: 16,
                                         rightTextWeight: FontWeight.w600
                                       ),
                                       buildDetailsTableText(
                                           size: size,
                                           leftText: "Total day of week",
                                           rightTxt: "6 Days",
                                           rightTextColor: Colors.redAccent
                                       ),
                                       buildDetailsTableText(
                                           size: size,
                                           leftText: "Total pay for this week",
                                           rightTxt: "\$460",
                                           rightTextColor: Colors.indigo,
                                         rightTextSize: 16,
                                         rightTextWeight: FontWeight.bold
                                       ),

                                       SizedBox(height: 20,),
                                       AppButton(onClick: ()=>_showMyDialog(size), text: "Pay Now", width: size.width*.10)


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
                    ),
                  ),
                );
              },
            ),
          )

        ],
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
                      child: Text("\$480.00",
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
