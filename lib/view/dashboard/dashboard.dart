import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:vendor/carImageJson.dart';
import 'package:vendor/controller/dashboardController/dashboardController.dart';
import 'package:vendor/model/dasboardModel.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view/auth/accountVerificationCenter.dart';
import 'package:vendor/view/dashboard/dashboardController/dashboardPlanPopup.dart';
import 'package:vendor/view/main_pages.dart';
import 'package:vendor/view_controller/bigText.dart';
import 'package:vendor/view_controller/dataError.dart';
import 'package:vendor/view_controller/dataLoading.dart';
import '../../app_config.dart';
import '../../view_controller/appButton.dart';
import '../../view_controller/richText.dart';
import '../../view_controller/singleBoxes.dart';
import 'package:vendor/view/globals.dart' as global;

import 'package:http/http.dart' as http;
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
    dashboardController();
   getDashboardData = dashboardController();

  }

  late Future<DashboardModel> getDashboardData;
  Future<DashboardModel> dashboardController()async{
    var response = await http.get(Uri.parse("${AppConfig.DASHBOARD}"),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${global.token}',
      },
    );
    print("data ==== ${response.statusCode}");
    print("data ==== ${response.body}");
    if(response.statusCode == 200){
      return DashboardModel.fromJson(jsonDecode(response.body));
    }
    return DashboardModel.fromJson(jsonDecode(response.body));
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder<DashboardModel>(
      future: getDashboardData,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
           return DataLoading(text: "Preparing Dashboard");
        }else if(snapshot.hasData){
          var dashboardData = snapshot.data?.data;
          return Container(
            // height: size.height,
            // width: size.width,
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            color: AppColors.bg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DashboardPlanPopup(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
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
                SizedBox(height: 30,),
                Row(
                  children: [
                    SingleBoxes(
                        title: "${dashboardData?.numberOfTotalCar}",
                        subTitle: "Vehicles",
                        icon: Image.asset("assets/images/car_list.png",height: 20, width: 20, fit: BoxFit.contain),
                        title2: "20",
                        subTitle2: "Total Ticket",
                        icon2: Image.asset("assets/images/request.png",height: 20, width: 20, fit: BoxFit.contain)
                    ),
                    SizedBox(width: 20,),
                    SingleBoxes(

                        title: "${dashboardData?.numberOfRentRequest}",
                        subTitle: "Total Request",
                        icon: Image.asset("assets/images/request.png",height: 30, width: 30,),
                        title2: "${dashboardData?.numberOfPendingRequest}",
                        subTitle2: "Today Ticket",
                        icon2: Image.asset("assets/images/request.png",height: 20, width: 20, fit: BoxFit.contain)
                    ),
                    SizedBox(width: 20,),
                    SingleBoxes(
                        title: "${dashboardData?.numberOfPendingRequest}",
                        subTitle: "Pending Request",
                        icon: Image.asset("assets/images/p_request.png",height: 30, width: 30,),
                        title2: "${dashboardData?.numberOfPendingRequest}",
                        subTitle2: "Today Ticket",
                        icon2: Image.asset("assets/images/request.png",height: 20, width: 20, fit: BoxFit.contain)
                    ),
                    SizedBox(width: 20,),
                    SingleBoxes(
                        title: "${dashboardData?.numberOfAssignDriver}",
                        subTitle: "Assign Drivers",
                        icon: Image.asset("assets/images/driver.png", height: 30, width: 30,),
                        title2: "${dashboardData?.numberOfPendingRequest}",
                        subTitle2: "Today Ticket",
                        icon2: Image.asset("assets/images/request.png",height: 20, width: 20, fit: BoxFit.contain)
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
                                for(var i=0;i<dashboardData!.rentRequests!.length;i++)
                                  DataRow(
                                      color: MaterialStateColor.resolveWith((states) {
                                        return i.isOdd? Colors.grey.shade200 : Colors.white; //make tha magic!
                                      }),
                                      cells: [
                                        DataCell(
                                            Image.network("${CarImageJson.carImageList[i]["image"]}", height: 30, width: 30,)
                                        ),
                                        DataCell(Text('${dashboardData!.rentRequests![i].car.name}')),
                                        DataCell(Text('#${dashboardData!.rentRequests![i].car.plateNo}')),
                                        DataCell(
                                            Container(
                                              padding: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
                                              decoration: BoxDecoration(
                                                  color: i.isOdd ? AppColors.green : AppColors.blue,
                                                  borderRadius: BorderRadius.circular(4)
                                              ),
                                              child: Text("${dashboardData!.rentRequests![i].status == "Pending"?"Pending": dashboardData!.rentRequests![i].status == "Approve" ? "Approve" : "Reject" }",
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
                                                onPressed: ()=>ShowSingleCar(dashboardData?.rentRequests[i]), child: Text("VIEW ",
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
        }else{
          return DataError();
        }

      }
    );
  }

  Future<void> ShowSingleCar(RentRequest? carInfo) async {
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
                              Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOvF74AmTuYjrklyYZ8NjDUX8RrX3SST-oh1PJpDuMhvc4Qwp-eAYtutnDb7mP2CeAsik&usqp=CAU", height: 100, width: 100,),
                              RichTextWidget(
                                leftText: "Car Name: ",
                                rightText: "${carInfo?.car.name}",
                              ),
                              SizedBox(height: 7,),
                              RichTextWidget(
                                leftText: "Plate No: ",
                                rightText: "${carInfo?.car.plateNo}",
                              ),
                              SizedBox(height: 7,),
                              RichTextWidget(
                                leftText: "Model No: ",
                                rightText: "${carInfo?.car.vmodel}",
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
                                rightText: "${carInfo?.driver.name}",
                              ),
                              SizedBox(height: 7,),
                              RichTextWidget(
                                leftText: "Phone Number: ",
                                rightText: "${carInfo?.driver.phone}",
                              ),
                              SizedBox(height: 7,),
                              RichTextWidget(
                                leftText: "Email Address:",
                                rightText: "${carInfo?.driver.image}",
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
                  // Html(
                  //   data: """
                  //     <p>Hello, My Name is <b>Nayon Talukder</b> and i am interested to the <b>2017 Toyota Camry SE</b>. You can reach me by <b>Email: nayon@gmail.com</b> or phone Number <b>+8801814569747</b>.<br><br>Thank You</p>
                  //   """
                  // ),
                  Text("${carInfo?.message}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                    ),
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

  void accountVerification()async{
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
                  BigText(text: "Account Verification Center"),
                  SizedBox(height: 10,),
                  Text("You need to upload following Document for verification.",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Divider(height: 1, color: Colors.grey,),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap:()=>startWebFilePicker(1),
                    child: Container(
                        height: 200,
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade200,
                        ),
                        child: idOrDrivingLicenseData != null
                            ? Image.memory(idOrDrivingLicenseData!, width: 200, height: 200)
                            : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Contact person photo ID or driving license. (JPG, PNG, JPEG ect).",

                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400
                          ),
                          ),
                          SizedBox(height: 10,),
                          Icon(Icons.add, size: 15, color: Colors.black,)
                          ],
                        )
                    ),
                  ),

                  SizedBox(height: 20,),

                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap:()=>startWebFilePicker(2),
                          child: Container(
                              height: 200,
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade200,
                              ),
                              child: legaleBusnessNameData != null
                                  ? Image.memory(legaleBusnessNameData!, width: 200, height: 200)
                                  : Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(child: Text("Legal business name (store front picture)(JPG, PNG, JPEG ect).",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400
                                      ),
                                    )),
                                    SizedBox(height: 10,),
                                    Icon(Icons.add, size: 15, color: Colors.black,)
                                  ],
                                ),
                              )
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: InkWell(
                          onTap:()=>startWebFilePicker(3),
                          child: Container(
                              height: 200,
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade200,
                              ),
                              child: businessStructureData != null
                                  ? Image.memory(businessStructureData!, width: 200, height: 200)
                                  : Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(child: Text("Business structure (e.g., sole proprietorship, partnership, corporation)(JPG, PNG, JPEG ect).",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400
                                      ),
                                    )),
                                    SizedBox(height: 10,),
                                    Icon(Icons.add, size: 15, color: Colors.black,)
                                  ],
                                ),
                              )
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20,),

                  Row(
                    children: [
                      Expanded(
                        child:InkWell(
                          onTap:()=>startWebFilePicker(4),
                          child: Container(
                              height: 200,
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade200,
                              ),
                              child: texIdentificationNumberData != null
                                  ? Image.memory(texIdentificationNumberData!, width: 200, height: 200)
                                  : Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(child: Text("Tax identification number (TIN)(JPG, PNG, JPEG ect).",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400
                                      ),
                                    )),
                                    SizedBox(height: 10,),
                                    Icon(Icons.add, size: 15, color: Colors.black,)
                                  ],
                                ),
                              )
                          ),
                        ) ,
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child:    InkWell(
                          onTap:()=>startWebFilePicker(5),
                          child: Container(
                              height: 200,
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade200,
                              ),
                              child: buinessLicenseData != null
                                  ? Image.memory(buinessLicenseData!, width: 200, height: 200)
                                  : Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(child: Text("Business registration/license number (if applicable) (JPG, PNG, JPEG ect).",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400
                                      ),
                                    )),
                                    SizedBox(height: 10,),
                                    Icon(Icons.add, size: 15, color: Colors.black,)
                                  ],
                                ),
                              )
                          ),
                        ),
                      )
                    ],
                  ),

                ],
              ),
            ),
          ),
          actions: <Widget>[
            AppButton(onClick: (){}, bgColor: AppColors.green, text: "Submit for Review", width: 200),
            SizedBox(width: 10,),
            AppButton(onClick: (){}, bgColor: AppColors.red, text: "Later", width: 100),
          ],
        );
      },
    );
  }



  List<int>? idOrDrivingLicense; //index - 1
  List<int>? legaleBusnessName; // index - 2
  List<int>? businessStructure; // index - 3
  List<int>? texIdentificationNumber; //index - 4
  List<int>? buinessLicense; // index - 5


  Uint8List? idOrDrivingLicenseData;
  Uint8List? legaleBusnessNameData;
  Uint8List? businessStructureData;
  Uint8List? texIdentificationNumberData;
  Uint8List? buinessLicenseData;
  startWebFilePicker(index) async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      print("this is files === $files");
      final file = files![0];
      final reader = html.FileReader();
      reader.onLoadEnd.listen((event) {
        setState(() {
          if(index == 1){
            idOrDrivingLicenseData = Base64Decoder().convert(reader.result.toString().split(",").last);
            idOrDrivingLicense = idOrDrivingLicenseData;
          }else if(index == 2){
            legaleBusnessNameData = Base64Decoder().convert(reader.result.toString().split(",").last);
            legaleBusnessName = legaleBusnessNameData;
          }else if(index == 3){
            businessStructureData = Base64Decoder().convert(reader.result.toString().split(",").last);
            businessStructure = businessStructureData;
          }else if(index == 4){
            texIdentificationNumberData = Base64Decoder().convert(reader.result.toString().split(",").last);
            texIdentificationNumber = texIdentificationNumberData;
          }else{
            buinessLicenseData = Base64Decoder().convert(reader.result.toString().split(",").last);
            buinessLicense = buinessLicenseData;
          }

        });
      });
      reader.readAsDataUrl(file);
    });
  }



}






