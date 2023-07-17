import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:vendor/carImageJson.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view/main_pages.dart';
import 'package:vendor/view_controller/bigText.dart';
import '../../view_controller/appButton.dart';
import '../../view_controller/richText.dart';
import '../../view_controller/singleBoxes.dart';
import 'report_charts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  Map<String, double> paiRentRequestReportData = {
    "Approve": 10,
    "Reject": 5,
    "Pending": 20,
  };

  List colorList = [
    Colors.red,
    Colors.amber,
    Colors.green,
    Colors.blue
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      // height: size.height,
      // width: size.width,
      padding: EdgeInsets.all(20),
      color: AppColors.bg,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(text: "Dashboard"),
                  SizedBox(height: 10,),
                  Text("Hi, Nayon Talukder. Welcome to Alloneautos.",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.greyText
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30,),
          Row(
            children: [
              SingleBoxes(
                  title: "25",
                  subTitle: "Total Cars",
                  icon: Image.asset("assets/images/car_list.png",height: 20, width: 20, fit: BoxFit.contain)
              ),
              SizedBox(width: 20,),
              SingleBoxes(
                  title: "57",
                  subTitle: "Rent Request",
                  icon: Image.asset("assets/images/request.png",height: 30, width: 30,)
              ),
              SizedBox(width: 20,),
              SingleBoxes(
                  title: "25",
                  subTitle: "Pending Request",
                  icon: Image.asset("assets/images/p_request.png",height: 30, width: 30,)
              ),
              SizedBox(width: 20,),
              SingleBoxes(
                  title: "12",
                  subTitle: "Assign Drivers",
                  icon: Image.asset("assets/images/driver.png", height: 30, width: 30,)
              ),

            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  // width: size.width*.55,
                   height: 380,
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
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Recent Car Request",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                          TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(AppColors.blue),
                              ),
                              onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage(pageIndex: 1,)))
                              , child: Text("VIEW ALL",
                            style: TextStyle(
                                color: AppColors.white
                            ),
                          ))
                        ],
                      ),
                      SizedBox(height: 8,),
                      Divider(height: 2, color: Colors.grey,),
                      SizedBox(height: 8,),
                      DataTable(
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
                              'Status',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                          )),
                          DataColumn(label: Text(
                              'Action',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
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
                                      Image.network("${CarImageJson.carImageList[i]["image"]}", height: 30, width: 30,)
                                  ),
                                  DataCell(Text('${CarImageJson.carImageList[i]["name"]}')),
                                  DataCell(Text('#48TFJC79')),
                                  DataCell(
                                      Container(
                                        padding: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
                                        decoration: BoxDecoration(
                                            color: i.isOdd ? AppColors.green : AppColors.blue,
                                            borderRadius: BorderRadius.circular(4)
                                        ),
                                        child: Text("${i.isOdd?"Approve":"Pending" }",
                                          style: TextStyle(
                                              fontSize: 9,
                                              color: AppColors.white
                                          ),
                                        ),
                                      )
                                  ),
                                  DataCell(
                                      TextButton(
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStatePropertyAll(Colors.amber),
                                          ),
                                          onPressed: ()=>ShowSingleCar(CarImageJson.carImageList[i]), child: Text("VIEW ",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.white
                                        ),
                                      ))
                                  ),
                                ]
                            ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                flex: 2,
                child: Container(
                  //width: size.width*.22,
                    height: 380,
                    padding: EdgeInsets.all(20),
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
                    child:PieChart(
                      dataMap: paiRentRequestReportData,
                      animationDuration: Duration(milliseconds: 800),
                      chartLegendSpacing: 32,
                      chartRadius: MediaQuery.of(context).size.width / 3,
                      colorList: [
                        Colors.amber,
                        Colors.green,
                        Colors.blue
                      ],
                      initialAngleInDegree: 0,
                      chartType: ChartType.ring,
                      ringStrokeWidth: 20,
                      centerText: "Total Request",
                      legendOptions: LegendOptions(
                        showLegendsInRow: true,
                        legendPosition: LegendPosition.bottom,
                        showLegends: true,
                        legendShape: BoxShape.circle,
                        legendTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      chartValuesOptions: ChartValuesOptions(
                        showChartValueBackground: false,
                        showChartValues: true,
                        showChartValuesInPercentage: false,
                        showChartValuesOutside: false,
                        decimalPlaces: 1,
                      ),
                      // gradientList: ---To add gradient colors---
                      // emptyColorGradient: ---Empty Color gradient---
                    )
                ),
              ),
            ],
          )





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






