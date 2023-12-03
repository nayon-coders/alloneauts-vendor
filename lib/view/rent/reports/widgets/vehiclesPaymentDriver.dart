import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view_controller/appIconButton.dart';
import 'package:vendor/view_controller/appNetworkImage.dart';

class VehiclesPaymentFromDriver extends StatelessWidget {
  const VehiclesPaymentFromDriver({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:  Container(
        //width: size.width * 0.32,
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
                  Text("Payment from Driver",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: (){},
                        child: const Text("Upcoming",
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.blue
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: (){},
                        child: const Text("Deu",
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.red
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: (){},
                        child: const Text("Complete",
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.green
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: DataTable(
                border: const TableBorder(left: BorderSide(width: 1, color: AppColors.grey), right: BorderSide(width: 1, color: AppColors.grey),),
                dividerThickness:0,
                sortAscending: true,
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
                      'Pay Amount',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                  )),
                  DataColumn(label: Text(
                      'Status',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                  )),
                  DataColumn(label: Text(
                      'Driver Info',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                  )),
                  DataColumn(label: Text(
                      'Action',
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
                              fontSize: 12,
                              fontWeight: FontWeight.w500
                          ),)),
                          DataCell(Text('\450.00',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                            ),
                          )),
                          const DataCell(Text('Pending',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                            ),
                          )),
                          DataCell(
                            AppIconButton(
                                icon: Icons.info_outline,
                                onClick: ()=>showDriverInfo(),
                               bgColor: Colors.amber,
                            ),
                          ),
                          DataCell(
                            Row(
                              children: [
                                AppIconButton(
                                    icon: Icons.check,
                                    onClick: (){}
                                ),
                              ],
                            )
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
      ),
    );
  }

  void showDriverInfo() async{
    Get.defaultDialog(
      title: "Driver Info",
      contentPadding: EdgeInsets.all(10),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          AppNetworkImage(url: "https://newprofilepic.photo-cdn.net//assets/images/article/profile.jpg?90af0c8", width: 100, height: 100),
          SizedBox(height: 20,),
          Text("Name: Nayon Talukder",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10,),
          Text("Email: nayon.coders@gmail.com",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10,),
          Text("Phone: +8801823746274",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10,),
          Text("Assigning Date: 12 Dec, 2022",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10,),
          Text("Document's: ",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10,),
          AppNetworkImage(url: "https://online.visual-paradigm.com/res/document/template/thumbnails/letter/appreciation-letter/thank-someone-for-volunteer-work.jpg", width: 100, height: 100, boxFit: BoxFit.contain,)
        ],
      )
    );
  }
}
