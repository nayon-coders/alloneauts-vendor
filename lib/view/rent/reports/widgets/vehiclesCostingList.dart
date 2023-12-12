import 'package:flutter/material.dart';
import 'package:vendor/model/rentModels/car_repots_list_model.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view_controller/appIconButton.dart';

class VehiclesCostingList extends StatelessWidget {
  final AssignedCarDetails? carDetails;
  const VehiclesCostingList({
    super.key,
    required this.size, this.carDetails,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.32,
      height: 650,
      decoration: BoxDecoration(
          color: AppColors.white,
          //borderRadius: BorderRadius.circular(10),

          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 2, blurRadius: 3,
                offset: Offset(0,2)
            )
          ]
      ),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Vehicle's Costing Report",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: DataTable(
              border: const TableBorder(left: BorderSide(width: 1, color: AppColors.grey), right: BorderSide(width: 1, color: AppColors.grey),),
              dividerThickness:0,
              sortAscending: false,
              headingRowColor: MaterialStateProperty.all(Colors.green) ,
              headingTextStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white
              ),
              columns: const [
                DataColumn(label: Text(
                    'Date',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                )),
                DataColumn(label: Text(
                    'Cost/Income',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                )),
                DataColumn(label: Text(
                    'View Details',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                )),

              ],
              rows: [
                for(var i=0;i<10; i++)
                  DataRow(
                      color: MaterialStateColor.resolveWith((states) {
                        return i.isOdd? Colors.grey.shade200 : Colors.white; //make tha magic!
                      }),
                      cells: [
                        DataCell(Text('25 Janu, 2023', style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                        ),)),
                        DataCell(Text('\$1200.00',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                          ),
                        )),
                        DataCell(
                          AppIconButton(
                              icon: Icons.visibility,
                              onClick: (){}
                          ),
                        ),
                      ]
                  ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){},
                child: Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 30,
                    height: 30,
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: AppColors.green,
                    ),
                    child: Icon(Icons.arrow_back_ios, size: 12, color: Colors.white,)
                ),
              ),
              InkWell(
                onTap: (){},
                child: Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 30,
                    height: 30,
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.blue
                    ),
                    child: Center(
                      child: Text("1",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white
                        ),
                      ),
                    )
                ),
              ),
              InkWell(
                onTap: (){},
                child: Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 30,
                    height: 30,
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.white,
                        border: Border.all(width: 1, color: AppColors.blue)
                    ),
                    child: Center(
                      child: Text("2",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue
                        ),
                      ),
                    )
                ),
              ),
              InkWell(
                onTap: (){},
                child: Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 30,
                    height: 30,
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.white,
                        border: Border.all(width: 1, color: AppColors.blue)
                    ),
                    child: Center(
                      child: Text("3",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue
                        ),
                      ),
                    )
                ),
              ),
              InkWell(
                onTap: (){},
                child: Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 30,
                    height: 30,
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.white,
                        border: Border.all(width: 1, color: AppColors.blue)
                    ),
                    child: Center(
                      child: Text("4",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue
                        ),
                      ),
                    )
                ),
              ),
              Text("........"),
              InkWell(
                onTap: (){},
                child: Container(
                    margin: EdgeInsets.only(right: 10, left: 10),
                    width: 30,
                    height: 30,
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.white,
                        border: Border.all(width: 1, color: AppColors.blue)
                    ),
                    child: Center(
                      child: Text("4",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue
                        ),
                      ),
                    )
                ),
              ),
              InkWell(
                onTap: (){},
                child: Container(

                    width: 30,
                    height: 30,
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: AppColors.green,
                    ),
                    child: Icon(Icons.arrow_forward_ios, size: 12, color: Colors.white,)
                ),
              ),
            ],
          )
        ],
      ),
      // child: Column(
      //   children: [
      //     // ListTile(
      //     //   leading: Container(
      //     //     height: 50,
      //     //     width: 50,
      //     //     decoration: BoxDecoration(
      //     //       color: Colors.blue,
      //     //       borderRadius: BorderRadius.circular(100)
      //     //     ),
      //     //     child: Column(
      //     //       mainAxisAlignment: MainAxisAlignment.center,
      //     //       crossAxisAlignment: CrossAxisAlignment.center,
      //     //       children: [
      //     //         Text("25",
      //     //           style: TextStyle(
      //     //             fontWeight: FontWeight.w600,
      //     //             fontSize: 15,
      //     //             color: Colors.white
      //     //           ),
      //     //         ),
      //     //         Text("Jan",
      //     //           style: TextStyle(
      //     //               fontWeight: FontWeight.w500,
      //     //               fontSize: 10,
      //     //               color: Colors.white
      //     //           ),
      //     //         )
      //     //       ],
      //     //     )
      //     //   ),
      //     //   title: SizedBox(
      //     //     width: 200,
      //     //     child: Row(
      //     //       children: [
      //     //
      //     //       ],
      //     //     ),
      //     //   ),
      //     // )
      //   ],
      // ),
    );
  }
}
