import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../utility/app_color.dart';
import 'appButton.dart';

class PlaingCarManageLimite extends StatelessWidget {
   PlaingCarManageLimite({
    Key? key,
  }) : super(key: key);

  //avality
  Map<String, double> carRentAbility = {
    "Remaining": 6,
    "Added": 4,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("You can added 5-10 car on this plan. You already added 6 Car. You have remining 4 car. ",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.green
            ),
          ),
          Row(
            children: [
              PieChart(
                dataMap: carRentAbility,
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 10,
                chartRadius: 30,
                colorList: [
                  Colors.red,
                  Colors.blue
                ],
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                ringStrokeWidth: 5,
                legendOptions: LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.bottom,
                  showLegends: false,
                  legendShape: BoxShape.circle,
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: false,
                  showChartValues: false,
                  showChartValuesInPercentage: false,
                  showChartValuesOutside: false,
                  decimalPlaces: 1,
                ),
                // gradientList: ---To add gradient colors---
                // emptyColorGradient: ---Empty Color gradient---
              ),
              SizedBox(width: 20,),
              AppButton(onClick: (){}, text: "Upgrade Plan", width: 100, bgColor: AppColors.blue,),
              SizedBox(width: 20,),
            ],
          )
        ],
      ),
    );
  }
}
