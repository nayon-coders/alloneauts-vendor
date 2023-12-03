import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/view/main_pages.dart';

import '../../controller/EmployeeController/employeeController.dart';
import '../../model/employeeModel/employeeModel.dart';
import '../../utility/app_color.dart';
import '../../view_controller/appIconButton.dart';
import '../../view_controller/appNetworkImage.dart';
import '../../view_controller/bigText.dart';
import '../../view_controller/dataLoading.dart';


class EmploySalaryShit extends StatefulWidget {
  const EmploySalaryShit({Key? key}) : super(key: key);

  @override
  State<EmploySalaryShit> createState() => _EmploySalaryShitState();
}

class _EmploySalaryShitState extends State<EmploySalaryShit> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDataFuture = EmployeeController.employeeList();
  }
  Future<EmployeeListModel>? _getDataFuture;


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
            child:FutureBuilder<EmployeeListModel>(
              future: _getDataFuture,
              builder: (BuildContext context, AsyncSnapshot<EmployeeListModel> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return DataLoading(text: "Locading...");
                }else if(snapshot.hasData){
                  return FittedBox(
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
                          'Status',
                        )),
                        DataColumn(label: Text(
                          'Action',
                        )),
                      ],
                      rows: [
                        for(var i=0;i<snapshot!.data!.data!.length;i++)
                          DataRow(
                              color: MaterialStateColor.resolveWith((states) {
                                return i.isOdd? Colors.grey.shade200 : Colors.white; //make tha magic!
                              }),
                              cells: [
                                DataCell(
                                    AppNetworkImage(
                                      url: 'https://alloneautos.com/documents/230923222807_nayon_document.jpg',
                                      width: 50,
                                      height: 50,

                                    )

                                ),
                                DataCell(Text('${snapshot.data!.data![i].details!.firstName} ${snapshot.data!.data![i].details!.lastName}', style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                ),)),
                                DataCell(Text('${snapshot.data!.data![i].details!.email}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600
                                  ),
                                )),
                                DataCell(Text('${snapshot.data!.data![i].details!.phone}',style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                ),)),

                                DataCell(Container(
                                    padding: EdgeInsets.only(left: 7, right: 7, bottom: 3,top: 3),
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Text('${snapshot.data!.data![i].status == 1 ? "Active" : "Deactive"}',
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
                                        onClick: ()=>Get.to(MainPage(pageIndex: 14,)),
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
                }else{
                  return Text("something web wrong");
                }
              },

            )
          ),
        ],
      ),
    );
  }
}
