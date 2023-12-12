import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:vendor/model/rentModels/car_repots_list_model.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view/rent/reports/widgets/add_vehicles_cost.dart';
import 'package:vendor/view_controller/appButton.dart';
import 'package:vendor/view_controller/appIconButton.dart';
import 'package:vendor/view_controller/appInput.dart';
import 'package:vendor/view_controller/bigText.dart';

import 'widgets/total_cost_income.dart';
import 'widgets/vehiclesCostingList.dart';
import 'widgets/vehiclesPaymentDriver.dart';

class CreateReports extends StatefulWidget {
  final AssignedCarDetails? carDetails;
  final String? carImage;
  final String? carId;
  const CreateReports({Key? key, this.carDetails,  this.carImage,  this.carId}) : super(key: key);

  @override
  State<CreateReports> createState() => _CreateReportsState();
}

class _CreateReportsState extends State<CreateReports> {


  Map<String, double> dataMap = {
    "Cost": 14600,
    "Income": 20000,
    "Revenue": 6400,
  };




  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: ()=>Get.back(),
                      icon: Icon(Icons.arrow_back, color: AppColors.green,),
                    ),
                    Container(
                      width: 10,
                      height: 25,
                      color: AppColors.green,
                    ),
                    SizedBox(width: 5,),
                    BigText(text: "Create Report's : #${widget.carDetails!.plateNo}"),
                  ],
                ),
                // AppButton(
                //     onClick: (){},
                //     text: "View Report",
                //     width: 100,
                //     height: 35,
                //     textSize: 12,
                // )
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                AddVehiclesCost(carDetails: widget!.carDetails, carImage: widget.carImage!, carId: widget.carId!,),
                SizedBox(width: 20,),
                TotalCostIncomeWidget(dataMap: dataMap),
              ],
            ),
            SizedBox(height: 50,),
            Row(
              children: [
                //estimate cost
                VehiclesCostingList(size: size),
                SizedBox(width: 20,),
                VehiclesPaymentFromDriver(),
              ],
            )
          ],
        ),
      ),
    );
  }
}




