import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/app_config.dart';
import 'package:vendor/view/main_pages.dart';
import 'package:vendor/view_controller/appPoup.dart';
import 'package:vendor/view_controller/dataError.dart';
import 'package:vendor/view_controller/loadingWidget.dart';

import '../../carImageJson.dart';
import '../../controller/rentCarController/rentCarController.dart';
import '../../model/rentModels/rentCarListModel.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();

    //initial model
    _getRentCarFuture = RentCarController.getRentCarList();
  }
  Future<RentCarModel>? _getRentCarFuture;
  //manage car method

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
              const BigText(text: "Manage Vehicle's"),
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
          FutureBuilder<RentCarModel>(
              future: _getRentCarFuture,
              builder: (context, AsyncSnapshot<RentCarModel>snapshot) {

                if(snapshot.connectionState == ConnectionState.waiting){
                  return Padding(padding: EdgeInsets.all(100), child: SizedBox(
                       width: 100,
                      child: const LoadingWidget(title: "Vehicles loading")));
                }else if(snapshot.hasData){
                  return Container(
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
                              'Vehicle Name',
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
                          for(var i=0;i<snapshot.data!.data.cars.length; i++)
                            DataRow(
                                color: MaterialStateColor.resolveWith((states) {
                                  return i.isOdd? Colors.grey.shade200 : Colors.white; //make tha magic!
                                }),
                                cells: [
                                  DataCell(
                                      Image.network("${AppConfig.DOMAIN}/${snapshot.data!.data.cars[i].images[0]}", height: 50, width: 50,)
                                  ),
                                  DataCell(Text('${snapshot.data!.data.cars[i].details.vmake} ${snapshot.data!.data.cars[i].details.vmodel}, ${snapshot.data!.data.cars[i].details.vyear}', style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500
                                  ),)),
                                  DataCell(Text('#${snapshot.data!.data.cars[i].details.plateNo}',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600
                                    ),
                                  )),
                                  DataCell(Text('\$${snapshot.data!.data.cars[i].details.price}',style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500
                                  ),)),
                                  DataCell(
                                      Text('0 Ticket',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.red
                                        ),
                                      )),
                                  DataCell(Text('\$0 Fine',
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
                                          onClick: ()=>ShowSingleCar(snapshot.data!, i),
                                        ),
                                        SizedBox(width: 5,),
                                        AppIconButton(
                                          icon: Icons.edit,
                                          onClick: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage(pageIndex: 4, constructorData: snapshot.data!.data.cars[i].id,))),
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
                  );
                }else{
                  return Padding(padding: EdgeInsets.all(50), child: SizedBox(
                      width: 100, height: 100,
                      child: DataError(onClick: ()=>RentCarController.getRentCarList())));
                }
              }
          ),

        ],
      ),
    );
  }

  bool _isDeleting = false;
  Future<void> ShowSingleCar(RentCarModel carInfo, i) async {
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
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 5, color: AppColors.green,),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color:AppColors.green
                                ),
                                child: Center(
                                  child: Text("\$${carInfo.data.cars[i].details.price}/month*",
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 40
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 10,),

                              RichTextWidget(leftText: "Plate No: ", rightText: "#${carInfo.data.cars[i].details.plateNo}"),
                              SizedBox(height: 10,),
                              Divider(height: 1,),
                              SizedBox(height: 10,),

                              RichTextWidget(leftText: "Make: ", rightText: "${carInfo.data.cars[i].details.vmake}"),
                              SizedBox(height: 10,),
                              Divider(height: 1,),
                              SizedBox(height: 10,),

                              RichTextWidget(leftText: "Model: ", rightText: "${carInfo.data.cars[i].details.vmodel}"),
                              SizedBox(height: 10,),
                              Divider(height: 1,),
                              SizedBox(height: 10,),

                              RichTextWidget(leftText: "Year: ", rightText: "${carInfo.data.cars[i].details.vyear}"),
                              SizedBox(height: 10,),
                              Divider(height: 1,),
                              SizedBox(height: 10,),
                              RichTextWidget(leftText: "Color: ", rightText: "${carInfo.data.cars[i].details.vcolor}"),
                              SizedBox(height: 10,),
                              Divider(height: 1,),
                              SizedBox(height: 10,),

                              RichTextWidget(leftText: "Location: ", rightText: "${carInfo.data.cars[i].details.location}"),
                              SizedBox(height: 10,),
                              Divider(height: 1,),
                              SizedBox(height: 10,),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              padding: EdgeInsets.all(10),
                              child: Image.network("${AppConfig.DOMAIN}/${carInfo.data.cars[i].images[0]}", height: 220, width: 300,),
                            ),
                            SizedBox(height: 10,),
                            const Text("Documents",
                              style: TextStyle(
                                fontSize: 15, 
                                fontWeight: FontWeight.w600, 
                              ),
                            ), 
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Image.network("${AppConfig.DOMAIN}/${carInfo.data.cars[i].images[0]}", height: 100,),
                                      SizedBox(height: 5,),
                                      Text("FH",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Image.network("${AppConfig.DOMAIN}/${carInfo.data.cars[i].images[0]}", height: 100),
                                      SizedBox(height: 5,),
                                      Text("Insurance",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Image.network("${AppConfig.DOMAIN}/${carInfo.data.cars[i].images[0]}", height: 100),
                                      SizedBox(height: 5,),
                                      Text("Diclaration",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      AppButton(onClick: (){}, text: "Assign Car Info", bgColor: Colors.cyan, width: 150),
                      SizedBox(width: 20,),
                      AppButton(onClick: (){}, text: "Payment History", width: 150),
                      SizedBox(width: 20,),
                      AppButton(onClick: (){}, text: "Edit Vehicles", bgColor: Colors.amber, width: 120),
                      SizedBox(width: 20,),
                      InkWell(
                        onTap: ()async{
                          AppPopup.appPopup(context: context, title: "You want to delete this car?", body: "Do you want to delete this car?. Remember, it never recovery..", dialogType: DialogType.warning, onOkBtn: ()async{
                            deleteCar(carInfo.data.cars[i].id.toString());
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:  Center(
                            child: _isDeleting
                                ? SpinKitPulsingGrid()
                                : Text("Delete",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      )

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

  void deleteCar(id) async{
    _isDeleting = await RentCarController.deleteCar(id);
    print("_isDeleting === ${_isDeleting}");
    if(_isDeleting == false){
      _getRentCarFuture = RentCarController.getRentCarList();
      Navigator.pop(context);
      AppPopup.appPopup(context: context, title: "Car is Deleted Success", body: "This Car is Deleted Success. It never recovery.", dialogType: DialogType.success, onOkBtn: (){});
    }else{
      Navigator.pop(context);
      AppPopup.appPopup(context: context, title: "Opps", body: "Something went wrong. Please try again.", dialogType: DialogType.infoReverse, onOkBtn: (){});
    }
  }

}

