import 'package:flutter/material.dart';
import 'package:vendor/view_controller/appIconButton.dart';
import 'package:vendor/view_controller/appNetworkImage.dart';

import '../../../utility/app_color.dart';


class DriverList extends StatefulWidget {
  const DriverList({Key? key}) : super(key: key);

  @override
  State<DriverList> createState() => _DriverListState();
}

class _DriverListState extends State<DriverList> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Drivers Lists",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),

          SizedBox(height: 10,),
          Expanded(
            child: Container(
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
              child: DataTable(
                dataTextStyle: TextStyle(
                  fontSize: 12
                ),
                dividerThickness:0,
                sortAscending: true,
                columns: const [
                  DataColumn(label:
                  SizedBox(
                    width: 20,
                    child: Text(
                        'ID',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                    ),
                  )),
                  DataColumn(label:
                  SizedBox(
                    width: 40,
                    child: Text(
                        'Name',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                    ),
                  )),
                  DataColumn(label: SizedBox(
                    width: 30,
                    child: Text(
                        'Profile',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                    ),
                  )),
                  DataColumn(label: SizedBox(
                    width: 70,
                    child: Text(
                        'Address',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                    ),
                  )),
                  DataColumn(label: SizedBox(
                    width: 40,
                    child: Text(
                        'Phone',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                    ),
                  )),
                  DataColumn(label: SizedBox(
                    width: 50,
                    child: Text(
                        'Licence No.',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                    ),
                  )),
                  DataColumn(label: SizedBox(
                    width: 50,
                    child: Text(
                        'TLC \nLicence No',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                    ),
                  )),
                  DataColumn(label: SizedBox(
                    width: 50,
                    child: Text(
                        'Assign \nVehicles',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                    ),
                  )),
                  DataColumn(label: SizedBox(
                    width: 40,
                    child: Text(
                        'Status',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                    ),
                  )),
                  DataColumn(label: SizedBox(
                    width: 50,
                    child: Text(
                        'Return \nDate',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                    ),
                  )),
                  DataColumn(label: SizedBox(
                    width: 50,
                    child: Text(
                        'Action',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                    ),
                  )),
                ],
                rows: [
                  for(var i=0;i<10; i++)
                    DataRow(
                        color: MaterialStateColor.resolveWith((states) {
                          return i.isOdd? Colors.grey.shade200 : Colors.white; //make tha magic!
                        }),
                        cells: [
                          DataCell(
                              SizedBox(
                                child: Text('${i+1}',  style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600
                          ),),
                              )),
                          DataCell(Text('MR Driver',  style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600
                          ),)),
                          const DataCell(
                            SizedBox(
                              width: 50, height: 50,
                              child: AppNetworkImage(
                                url: "https://st.depositphotos.com/1017228/4720/i/450/depositphotos_47201743-stock-photo-handsome-african-man.jpg",
                                width: 50, height: 50, boxFit: BoxFit.contain,
                              ),
                            ),
                          ),

                          DataCell(Text('Dhaka Moteejhile, Dhaka, Bangladesh',  style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600
                          ),)),
                          DataCell(
                              TextButton(
                                onPressed: (){},
                                child: Text('+880 13424857839',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              )),
                          DataCell(Text('2398920',  style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600
                          ),)),
                          DataCell(Text('TLC3242342',  style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600
                          ),)),
                          DataCell(
                              TextButton(
                                onPressed: (){},
                                child: Text('Toyta SE 2022',
                            style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600
                            ),
                          ),
                              )),
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
                          DataCell(Text('Dec 12, 2024',  style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600
                          ),)),
                          DataCell(
                            AppIconButton(
                              icon: Icons.edit,
                              onClick: (){},
                              bgColor: Colors.amber,
                            ),
                          ),
                        ]
                    ),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}



