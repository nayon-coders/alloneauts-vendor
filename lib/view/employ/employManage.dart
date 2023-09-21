import 'dart:convert';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:vendor/controller/EmployeeController/employeeController.dart';
import 'package:vendor/view/dashboard/dashboard.dart';
import 'package:vendor/view/main_pages.dart';
import 'package:vendor/view_controller/appButton.dart';
import 'package:vendor/view_controller/appInput.dart';
import 'package:vendor/view_controller/appPoup.dart';
import 'dart:html' as html;
import '../../utility/app_color.dart';
import '../../view_controller/appIconButton.dart';
import '../../view_controller/bigText.dart';

class EmployManagement extends StatefulWidget {
  const EmployManagement({Key? key}) : super(key: key);

  @override
  State<EmployManagement> createState() => _EmployManagementState();
}

class _EmployManagementState extends State<EmployManagement> {


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BigText(text: "Employ Management"),
              SizedBox(
                width: size.width*.20,
                child: AppButton(
                  onClick: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage(pageIndex: 16,))),
                  text: "Add Employ",
                  bgColor: AppColors.green,
                  width: 100,
                )
              )
            ],
          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width, //to get the width of screen
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
            child: FittedBox(
              child: DataTable(
                dividerThickness:0,
                sortAscending: false,
                columns: const [
                  DataColumn(label: Text(
                      'Profile',
                  )),

                  DataColumn(label: Text(
                      'Employ Name',
                  )),
                  DataColumn(label: Text(
                      'Email',
                  )),
                  DataColumn(label: Text(
                      'Phone',
                  )),
                  DataColumn(label: Text(
                      'Documents',
                  )),
                  DataColumn(label: Text(
                    'Staus',
                  )),
                  DataColumn(label: Text(
                      'Action',
                  )),
                ],
                rows: [
                  for(var i=0;i<5;i++)
                    DataRow(
                        color: MaterialStateColor.resolveWith((states) {
                          return i.isOdd? Colors.grey.shade200 : Colors.white; //make tha magic!
                        }),
                        cells: [
                          DataCell(
                              Image.network("https://newprofilepic.photo-cdn.net//assets/images/article/profile.jpg?4d355bd", height: 50, width: 50,)
                          ),
                          DataCell(Text('Johan Due', style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),)),
                          DataCell(Text('jhona@gmail.com',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                            ),
                          )),
                          DataCell(Text('+1 9840 ******',style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),)),

                          DataCell(Container(
                              padding: EdgeInsets.only(left: 7, right: 7, bottom: 3,top: 3),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Text('Active',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ))),
                          DataCell(Container(
                              padding: EdgeInsets.only(left: 7, right: 7, bottom: 3,top: 3),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Text('View Documnets',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ))),
                          DataCell(
                            Row(
                              children: [
                                SizedBox(width: 5,),
                                AppIconButton(
                                  icon: Icons.edit,
                                  onClick: (){},
                                  bgColor: Colors.amber,
                                ),
                                SizedBox(width: 5,),
                                AppIconButton(
                                  icon: Icons.delete_outline_outlined,
                                  onClick: (){},
                                  bgColor: AppColors.red,
                                ),
                                SizedBox(width: 5,),
                              ],
                            ),

                          ),
                        ]
                    ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }





}
