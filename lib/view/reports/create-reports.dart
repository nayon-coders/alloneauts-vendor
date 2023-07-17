import 'package:flutter/material.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view_controller/appButton.dart';
import 'package:vendor/view_controller/appInput.dart';
import 'package:vendor/view_controller/bigText.dart';

class CreateReports extends StatefulWidget {
  const CreateReports({Key? key}) : super(key: key);

  @override
  State<CreateReports> createState() => _CreateReportsState();
}

class _CreateReportsState extends State<CreateReports> {
  final expance = TextEditingController();
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
                      onPressed: (){},
                      icon: Icon(Icons.arrow_back, color: AppColors.green,),
                    ),
                    Container(
                      width: 10,
                      height: 25,
                      color: AppColors.green,
                    ),
                    SizedBox(width: 5,),
                    BigText(text: "Create Report's : #TCG73758FH84"),
                  ],
                ),
                AppButton(
                    onClick: (){},
                    text: "View Report",
                    width: 100,
                    height: 35,
                    textSize: 12,
                )
              ],
            ),
            SizedBox(height: 20,),
            Container(
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
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Image.asset("assets/images/car1.png",
                              height: 300,
                            ),
                            SizedBox(height: 20,),
                            Text("2022 RVR ",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.black
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text("#TC7847JFHI8",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color:Colors.black
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: AppInput(
                                    controller: expance,
                                    title: "Car Expanse",
                                    prefixIcon: Icons.taxi_alert,
                                    hintText: "Car Expanse",
                                    readOnly: true,
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
                                onClick: (){},
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
            SizedBox(height: 50,),
            Container(
              width: size.width * 0.80,
              padding: EdgeInsets.only(top: 100, bottom: 80, left: 20, right: 20),
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
                  BigText(text: "Car not assign!"),
                  SizedBox(height: 20,),
                  Image.asset("assets/images/not-found.jpeg",
                    height: 100,
                    width: 100,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
