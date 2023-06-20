import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

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
                    'Make',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                )),
                DataColumn(label: Text(
                    'Model',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                )),
                DataColumn(label: Text(
                    'Year',
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
                        DataCell(Text('${CarImageJson.carImageList[i]["name"]}')),
                        DataCell(Text('#48TFJC79',
                          style: TextStyle(
                            fontWeight: FontWeight.w600
                          ),
                        )),
                        DataCell(Text('\$450')),
                        DataCell(Text('${CarImageJson.carImageList[i]["make"]}')),
                        DataCell(Text('${CarImageJson.carImageList[i]["model"]}')),
                        DataCell(Text('${CarImageJson.carImageList[i]["year"]}')),
                        DataCell(
                            Row(
                              children: [
                                AppIconButton(
                                  icon: Icons.remove_red_eye,
                                  onClick: (){},
                                ),
                                SizedBox(width: 5,),
                                AppIconButton(
                                  icon: Icons.edit,
                                  onClick: (){},
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
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment:MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(carInfo["image"], height: 100, width: 100,),
                              RichTextWidget(
                                leftText: "Car Name: ",
                                rightText: "${carInfo["name"]}",
                              ),
                              SizedBox(height: 7,),
                              RichTextWidget(
                                leftText: "Plate No: ",
                                rightText: "TC56YU7IU90",
                              ),
                              SizedBox(height: 7,),
                              RichTextWidget(
                                leftText: "Model No: ",
                                rightText: "${carInfo["model"]}",
                              ),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment:MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network("https://newprofilepic2.photo-cdn.net//assets/images/article/profile.jpg", height: 100, width: 100, fit: BoxFit.cover,)),
                              SizedBox(height: 10,),
                              RichTextWidget(
                                leftText: "Driver Name: ",
                                rightText: "Nayon Talukder",
                              ),
                              SizedBox(height: 7,),
                              RichTextWidget(
                                leftText: "Phone Number: ",
                                rightText: "+8801814569747",
                              ),
                              SizedBox(height: 7,),
                              RichTextWidget(
                                leftText: "Email Address:",
                                rightText: "nayon.coders@gmail.com",
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  BigText(text: "Messages"),
                  SizedBox(height: 8,),
                  Html(
                      data: """
                      <p>Hello, My Name is <b>Nayon Talukder</b> and i am interested to the <b>2017 Toyota Camry SE</b>. You can reach me by <b>Email: nayon@gmail.com</b> or phone Number <b>+8801814569747</b>.<br><br>Thank You</p>
                    """
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      AppButton(
                        onClick: (){},
                        width: 100,
                        text: "Approve",
                      ),
                      SizedBox(width: 10,),
                      AppButton(
                        onClick: (){},
                        width: 100,
                        bgColor: Colors.transparent,
                        text: "Reject",
                        textColor: AppColors.red,
                        borderColor: AppColors.red,
                      ),
                    ],
                  )
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

