import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view_controller/richText.dart';

class TotalCostIncomeWidget extends StatelessWidget {
  const TotalCostIncomeWidget({
    super.key,
    required this.dataMap,
  });

  final Map<String, double> dataMap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
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
            const Text("Short Summary: ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900
              ),
            ),
            SizedBox(height: 20,),
            PieChart(
              dataMap: dataMap,
              animationDuration: Duration(milliseconds: 800),
              chartLegendSpacing: 20,
              chartRadius: 150,
              colorList: [
                Colors.red,
                Colors.blue,
                Colors.green,
              ],
              initialAngleInDegree: 0,
              chartType: ChartType.ring,
              ringStrokeWidth: 15,
              centerText: "Summary",
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
            SizedBox(height: 20,),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Text("Total Income",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
              trailing: Text("\$${dataMap["Income"]}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: AppColors.blue
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Text("Total Cost",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
              trailing: Text("(-) \$${dataMap["Cost"]}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Colors.red
                ),
              ),
            ),
            Divider(height: 1, color: AppColors.grey,),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Text("Total Revenue",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
              trailing: Text("\$${dataMap["Revenue"]}",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  color: Colors.green
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
