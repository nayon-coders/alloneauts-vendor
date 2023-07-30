import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:vendor/view/main_pages.dart';
import 'package:vendor/view/ticketManagement/singleTicker.dart';
import 'package:vendor/view_controller/appButton.dart';
import 'package:vendor/view_controller/appInput.dart';

import '../../carImageJson.dart';
import '../../utility/app_color.dart';
import '../../view_controller/appIconButton.dart';
import '../../view_controller/bigText.dart';

class AllTicket extends StatefulWidget {
  const AllTicket({Key? key}) : super(key: key);

  @override
  State<AllTicket> createState() => _AllTicketState();
}

class _AllTicketState extends State<AllTicket> {
  bool isTicketPush = false;
  bool isTicketEmail = false;
  bool isTicketUpdateFinePush = false;
  bool isTicketUpdateFineEmail = false;

  final subEmail = TextEditingController();

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
              BigText(text: "Manage Your Ticket"),
              Row(
                children: [
                  SizedBox(
                    width: size.width*.20,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Search by plat no.",
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
                  ),
                  SizedBox(width: 10,),
                  Container(
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(onPressed: ()=>showSettingForTicket(), icon: Icon(Icons.settings,), color: AppColors.white,)),
                  SizedBox(width: 20,),
                ],
              ),
            ],
          ),
          SizedBox(height: 10,),
          Container(
            // width: size.width*.55,
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
              dividerThickness:0,
              sortAscending: false,
              columns: [
                DataColumn(label: Text(
                    'Car',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                )),
                DataColumn(label: Text(
                    'Plate No.',
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
                        DataCell(Text('#48TFJC79',
                          style: TextStyle(
                              fontWeight: FontWeight.w600
                          ),
                        )),
                        DataCell(Text('12 Ticket',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.red
                          ),
                        )),
                        DataCell(Text('\$650',
                          style: TextStyle(
                            fontSize: 12,
                              fontWeight: FontWeight.w600,
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
                                onClick: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage(pageIndex: 11, menuNumber: "6-1",))),//Single Ticket page
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
        ],
      ),
    );
  }

  showSettingForTicket() {
    var size = MediaQuery.of(context).size;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content:  StatefulBuilder(
            builder: (context, setState) {
              return Container(
                width: size.width*.30,
                child: SingleChildScrollView(
                  child: ListBody(
                    children:  <Widget>[
                      Text("Notification Setting",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text("We may send you important notification about Ticket for your notification setting.",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Divider(height: 1, color: Colors.grey,),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey.shade200
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("Ticket Notification",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text("We may send you important notification about Ticket for your notification setting.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              )
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      child: FlutterSwitch(
                                        width: 40.0,
                                        height: 20.0,
                                        valueFontSize: 7.0,
                                        toggleSize: 15.0,
                                        value: isTicketPush,
                                        borderRadius: 30.0,
                                        padding: 3.0,
                                        showOnOff: true,
                                        onToggle: (val) {
                                          setState(() {
                                            isTicketPush = val;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Text("Push",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 9
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Container(
                                      child: FlutterSwitch(
                                        width: 40.0,
                                        height: 20.0,
                                        valueFontSize: 7.0,
                                        toggleSize: 15.0,
                                        value: isTicketEmail,
                                        borderRadius: 30.0,
                                        padding: 3.0,
                                        showOnOff: true,
                                        onToggle: (val) {
                                          setState(() {
                                            isTicketEmail = val;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Text("Email",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 9
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey.shade200
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                                width: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text("Ticket update",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Text("We may send you important notification about Ticket Update for your notification setting.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      child: FlutterSwitch(
                                        width: 40.0,
                                        height: 20.0,
                                        valueFontSize: 7.0,
                                        toggleSize: 15.0,
                                        value: isTicketUpdateFinePush,
                                        borderRadius: 30.0,
                                        padding: 3.0,
                                        showOnOff: true,
                                        onToggle: (val) {
                                          setState(() {
                                            isTicketUpdateFinePush = val;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Text("Push",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 9
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Container(
                                      child: FlutterSwitch(
                                        width: 40.0,
                                        height: 20.0,
                                        valueFontSize: 7.0,
                                        toggleSize: 15.0,
                                        value: isTicketUpdateFineEmail,
                                        borderRadius: 30.0,
                                        padding: 3.0,
                                        showOnOff: true,
                                        onToggle: (val) {
                                          setState(() {
                                            isTicketUpdateFineEmail = val;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Text("Email",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 9
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Divider(height: 1, color: Colors.grey,),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey.shade200
                        ),
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("We've just relese a new update for Ticket.",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text("Check out the Ticket Management and Load Faster. Every update we send you email.",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                SizedBox(width: 250,
                                  child: TextFormField(
                                    controller: subEmail,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: "nayon.coders@gmail.com",
                                      contentPadding: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(5)
                                      )
                                    ),
                                  )
                                ),
                                SizedBox(width: 10,),
                                AppButton(
                                    onClick: (){}, text: "Submit", width: 70, height: 40,)
                              ],
                            )
                          ],
                        ),
                      )


                    ],
                  ),
                ),
              );
            }
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

  Row switchButton({required StateSetter setState, required   bool status, required String text} ) {
    return Row(
                                children: [
                                  Container(
                                    child: FlutterSwitch(
                                      width: 40.0,
                                      height: 20.0,
                                      valueFontSize: 7.0,
                                      toggleSize: 15.0,
                                      value: status,
                                      borderRadius: 30.0,
                                      padding: 3.0,
                                      showOnOff: true,
                                      onToggle: (val) {
                                        setState(() {
                                          status = val;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Text("$text",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 9
                                    ),
                                  )
                                ],
                              );
  }
}
