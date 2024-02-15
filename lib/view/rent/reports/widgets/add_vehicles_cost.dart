import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vendor/app_config.dart';
import 'package:vendor/controller/rentCarController/rentCarController.dart';
import 'package:vendor/model/rentModels/car_repots_list_model.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view_controller/appButton.dart';
import 'package:vendor/view_controller/appInput.dart';
import 'package:vendor/view_controller/appNetworkImage.dart';
import 'package:vendor/view_controller/appPoup.dart';
import 'package:vendor/view_controller/loadingWidget.dart';

import 'vehiclesCostingList.dart';

class AddVehiclesCost extends StatefulWidget {
  final AssignedCarDetails? carDetails;
  final String carImage;
  final String carId;

  AddVehiclesCost({
    super.key,  this.carDetails, required this.carImage, required this.carId
  });

  @override
  State<AddVehiclesCost> createState() => _AddVehiclesCostState();
}

class _AddVehiclesCostState extends State<AddVehiclesCost> {
  final expance = TextEditingController();

  final shopName = TextEditingController();

  final amount = TextEditingController();

  final date = TextEditingController();

  final details = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    expance.text = "Car Expanse";
  }

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      flex: 3,
      child: Container(
        padding: EdgeInsets.all(20),
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
            Row(
              children: [
                Container(
                  width: 250,
                  child: Column(
                    children: [
                      AppNetworkImage(url: "${AppConfig.DOMAIN}/${widget.carImage!}", width: 250, height: 250),
                      SizedBox(height: 10,),
                      Text("${widget.carDetails!.name}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text("#${widget.carDetails!.plateNo!}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color:Colors.black
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1, 
                            child: AppInput(
                              controller: shopName,
                              title: "Repair Shop",
                              prefixIcon: Icons.taxi_alert,
                              hintText: "Repair shop name",
                            ),
                          ),
                          SizedBox(width: 8,),
                          Expanded(
                            child: AppInput(
                              controller: amount,
                              title: "Amount",
                              prefixIcon: Icons.monetization_on_outlined,
                              hintText: "\$50",
                            ),
                          ),
                          SizedBox(width: 8,),
                          Expanded(
                            child: AppInput(
                              onClick: ()=>_selectDate(context),
                              readOnly: true,
                              controller: date,
                              title: "Date",
                              prefixIcon: Icons.date_range_sharp,
                              hintText: "Date",
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Details",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: AppColors.black
                            ),
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            maxLines: 7,
                            controller: details,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(width: 1, color: AppColors.green.withOpacity(0.3))
                              ),
                              hintText: "Type your expanse details...",
                            ),

                          )
                        ],
                      ),
                      SizedBox(height: 30,),
                      AppButton(
                          isLoading: isLoading,
                          onClick: ()=>_createExpanse(),
                          text: "Save Expanse",
                          width: 150
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }


  //select date
   Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      date.text = DateFormat('yyyy-MM-dd').format(picked);

    }
  }


  bool isLoading = false; 
  _createExpanse() async{
    setState(() =>isLoading = true);
    var res = await RentCarController.addCarExpance(
        carId: widget.carId!,
        amount: amount.text,
        date: date.text,
        details: details.text);
    print("status ==${res.statusCode}");
    print("status ==${res.body}");

    if(res.statusCode == 200){
      setState(() {});
    AppPopup.appPopup(context: context, title: "Expanse Added Success", body: "Expanse added for ${widget.carDetails!.name} Car.", dialogType: DialogType.success, onOkBtn: (){});
    }else{
      AppPopup.appPopup(context: context, title: "Error", body: "Something went wrong", dialogType: DialogType.error, onOkBtn: (){});
    }
    setState(() =>isLoading = false);
  }
}
