import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/response.dart';
import 'package:vendor/view_controller/appButton.dart';
import 'package:vendor/view_controller/bigText.dart';

import '../../carImageJson.dart';
import '../../utility/app_color.dart';
import '../../view_controller/appIconButton.dart';
import '../main_pages.dart';

class CarReports extends StatefulWidget {
  const CarReports({Key? key}) : super(key: key);

  @override
  State<CarReports> createState() => _CarReportsState();
}

class _CarReportsState extends State<CarReports> {
  bool isAllCar = true;
  bool isAssignCar = false;
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
                const BigText(text: "Car Report's"),
                Row(
                  children: [
                    AppButton(
                        onClick: (){
                          setState(() {
                            isAllCar = true;
                            isAssignCar = false;
                          });
                        },
                      bgColor: isAllCar ? AppColors.blue : Colors.transparent,
                        text: "All",
                        width: 40,
                        height: 20,
                        textSize: 12,
                      textColor: isAllCar ? AppColors.white : AppColors.blue,
                      borderColor: AppColors.blue,
                    ),
                    SizedBox(width: 10,),
                    AppButton(
                        onClick: (){
                          setState(() {
                            isAllCar = false;
                            isAssignCar = true;
                          });
                        },
                        text: "Assign Car",
                        width: 80,
                      bgColor: isAssignCar ? AppColors.blue : Colors.transparent,
                      textColor: isAssignCar ? AppColors.white : AppColors.blue,
                        height: 20,
                        textSize: 12,
                      borderColor: AppColors.blue,
                    ),
                  ],
                ),
               Responsive.isDesktop(context) ?  SizedBox(
                  width: size.width*.20,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Search...",
                        fillColor: AppColors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: AppColors.green.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        contentPadding: EdgeInsets.only(left: 20,right: 20, top: 7, bottom: 7),
                        prefixIcon: Icon(Icons.search)
                    ),
                  ),
                ) : Center(),
              ],
            ),
            SizedBox(height: 20,),
            Container(
              width: size.width,
              padding: EdgeInsets.all(15),
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
              child: isAllCar ? allCarMethod() : assignCarMethod(),
            ),

          ],
        ),
      ),
    );
  }

  FittedBox allCarMethod() {
    return FittedBox(
      child: DataTable(
                dividerThickness:0,
                sortAscending: false,
                columns: const [
                  DataColumn(
                      label: Text(
                      'Car',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
                  )),
                  DataColumn(label: Text(
                      'Car Name',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
                  )),
                  DataColumn(label: Text(
                      'Plate No.',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
                  )),

                  DataColumn(label: Text(
                      'Action',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
                  )),
                ],
                rows: [
                  for(var i=0;i<CarImageJson.carImageList.length;i++)
                    DataRow(
                        color: MaterialStateColor.resolveWith((states) {
                          return i.isOdd? Colors.grey.shade200 : Colors.white; //make tha magic!
                        }),
                        cells: [
                          DataCell(
                              Image.network("${CarImageJson.carImageList[i]["image"]}",height: 60, width: 60,)
                          ),
                          DataCell(Text('${CarImageJson.carImageList[i]["name"]}')),
                          DataCell(Text('#48TFJC79',
                            style: TextStyle(
                                fontWeight: FontWeight.w600
                            ),
                          )),

                          DataCell(
                            Row(
                              children: [
                                AppIconButton(
                                  icon: Icons.remove_red_eye,
                                  onClick: ()=>Get.to(MainPage(pageIndex: 5,), transition: Transition.fadeIn),
                                ),
                                SizedBox(width: 5,),
                                AppIconButton(
                                  icon: Icons.edit,
                                  onClick: ()=>Get.to(MainPage(pageIndex: 8,), transition: Transition.fadeIn),
                                  bgColor: Colors.amber,
                                ),
                                SizedBox(width: 5,),

                              ],
                            ),

                          ),
                        ]
                    ),
                ],
              ),
    );
  }

  FittedBox assignCarMethod() {
    return FittedBox(
      child: DataTable(
        dividerThickness:0,
        sortAscending: false,
        columns: const [
          DataColumn(
              label: Text(
                  'Car',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
              )),
          DataColumn(label: Text(
              'Car Name',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
          )),
          DataColumn(label: Text(
              'Plate No.',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
          )),

          DataColumn(label: Text(
              'Action',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
          )),
        ],
        rows: [
          for(var i=0;i<3;i++)
            DataRow(
                color: MaterialStateColor.resolveWith((states) {
                  return i.isOdd? Colors.grey.shade200 : Colors.white; //make tha magic!
                }),
                cells: [
                  DataCell(
                      Image.network("${CarImageJson.carImageList[i]["image"]}",height: 60, width: 60,)
                  ),
                  DataCell(Text('${CarImageJson.carImageList[i]["name"]}')),
                  DataCell(Text('#48TFJC79',
                    style: TextStyle(
                        fontWeight: FontWeight.w600
                    ),
                  )),

                  DataCell(
                    Row(
                      children: [
                        AppIconButton(
                          icon: Icons.remove_red_eye,
                          onClick: ()=>Get.to(MainPage(pageIndex: 5,), transition: Transition.fadeIn),
                        ),
                        SizedBox(width: 5,),
                        AppIconButton(
                          icon: Icons.create_outlined,
                          onClick: ()=>Get.to(MainPage(pageIndex: 5,), transition: Transition.fadeIn),
                          bgColor: Colors.amber,
                        ),
                        SizedBox(width: 5,),

                      ],
                    ),

                  ),
                ]
            ),
        ],
      ),
    );
  }

}
