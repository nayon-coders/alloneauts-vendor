import 'package:flutter/material.dart';
import 'package:vendor/view/main_pages.dart';

import '../../utility/app_color.dart';
import '../../view_controller/appIconButton.dart';
import '../../view_controller/bigText.dart';


class EmploySalaryShit extends StatefulWidget {
  const EmploySalaryShit({Key? key}) : super(key: key);

  @override
  State<EmploySalaryShit> createState() => _EmploySalaryShitState();
}

class _EmploySalaryShitState extends State<EmploySalaryShit> {
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
              BigText(text: "Employ Salary Shit"),
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
                      offset: const Offset(0,2)
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
                    'Employ Type',
                  )),
                  DataColumn(label: Text(
                    'Status',
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

                          DataCell(Container(
                              padding: EdgeInsets.only(left: 7, right: 7, bottom: 3,top: 3),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: const Text('Hourly',
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
                              child: Text('Active',
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
                                  icon: Icons.arrow_forward,
                                  onClick: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage(pageIndex: 14,))),
                                  bgColor: Colors.amber,
                                ),
                                
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
