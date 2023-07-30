import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:vendor/view/main_pages.dart';

import '../../carImageJson.dart';
import '../../utility/app_color.dart';
import '../../view_controller/appButton.dart';
import '../../view_controller/appIconButton.dart';
import '../../view_controller/bigText.dart';
import '../../view_controller/richText.dart';

class ManageCar extends StatefulWidget {
  const ManageCar({Key? key}) : super(key: key);

  @override
  State<ManageCar> createState() => _ManageCarState();
}

class _ManageCarState extends State<ManageCar> {
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
              BigText(text: "Manage Car's"),
              SizedBox(
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
                      'Car',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                  )),
                  DataColumn(label: Text(
                      'Car Name',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                  )),
                  DataColumn(label: Text(
                      'Plate No.',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                  )),
                  DataColumn(label: Text(
                      'Price',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                  )),
                  DataColumn(label: Text(
                      'Ticket',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                  )),
                  DataColumn(label: Text(
                      'Fine',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                  )),
                  DataColumn(label: Text(
                      'TLC License',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                  )),
                  DataColumn(label: Text(
                      'TLC Status',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                  )),
                  DataColumn(label: Text(
                      'Action',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
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
                              Image.network("${CarImageJson.carImageList[i]["image"]}", height: 50, width: 50,)
                          ),
                          DataCell(Text('${CarImageJson.carImageList[i]["name"]}', style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500
                          ),)),
                          DataCell(Text('#48TFJC79',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600
                            ),
                          )),
                          DataCell(Text('\$450',style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500
                          ),)),
                          DataCell(Text('12 Ticket',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppColors.red
                            ),
                          )),
                          DataCell(Text('\$650',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                          DataCell(Text('437847823498',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
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
                          DataCell(
                            Row(
                              children: [
                                AppIconButton(
                                  icon: Icons.remove_red_eye,
                                  onClick: ()=>ShowSingleCar(CarImageJson.carImageList[i]),
                                ),
                                SizedBox(width: 5,),
                                AppIconButton(
                                  icon: Icons.edit,
                                  onClick: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage(pageIndex: 4,))),
                                  bgColor: Colors.amber,
                                ),
                                SizedBox(width: 5,),
                                AppIconButton(
                                  icon: Icons.report_gmailerrorred_rounded,
                                  onClick: (){},
                                  bgColor: AppColors.blue,
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

  Future<void> ShowSingleCar(carInfo) async {
    var size = MediaQuery.of(context).size;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content:  Container(
            width: size.width*.50,
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[

                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}

