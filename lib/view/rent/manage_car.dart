import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/app_config.dart';
import 'package:vendor/firebase/controller/firebase_car_controller.dart';
import 'package:vendor/firebase/model/firebase_car_model.dart';
import 'package:vendor/response.dart';
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
import '../../view_controller/appNetworkImage.dart';
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
    _getAllCar = FirebaseCarRentController.getAllCar();
  }
  Future<RentCarModel>? _getRentCarFuture;
  Future<FirebaseCarModel>? _getAllCar;
  //manage car method

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 25,
                    color: AppColors.green,
                  ),
                  SizedBox(width: 10,),
                  const BigText(text: "Manage Vehicle's"),
                ],
              ),
              SizedBox(
                width: Responsive.isDesktop(context) ? size.width*.20 : size.width*.40,
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Search...",
                      fillColor: AppColors.white,
                      hintStyle: TextStyle(
                        fontSize: 15,
                      ),
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: AppColors.green.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: AppColors.green.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: AppColors.green.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      contentPadding: EdgeInsets.only(left: 10,right: 10, top: 0, bottom: 0),
                      prefixIcon: Icon(Icons.search, size: 20,)
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10,),
          FutureBuilder<FirebaseCarModel>(
              future: _getAllCar,
              builder: (context, snapshot) {
                print(snapshot.data);

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
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
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
                            for(var i=0;i<snapshot.data!.cars!.length; i++)
                              DataRow(
                                  color: MaterialStateColor.resolveWith((states) {
                                    return i.isOdd? Colors.grey.shade200 : Colors.white; //make tha magic!
                                  }),
                                  cells: [
                                    DataCell(
                                        AppNetworkImage(
                                          url: "${snapshot.data!.cars![i]!.carInfo!.images!.carImage!}",
                                          width: 50, height: 50, boxFit: BoxFit.contain,
                                        ),
                                    ),
                                    DataCell(Text('${snapshot.data!.cars![i]!.carInfo!.name}', style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500
                                    ),)),
                                    DataCell(Text('#${snapshot.data!.cars![i]!.carInfo!.plateNo}',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600
                                      ),
                                    )),
                                    DataCell(Text('\$${snapshot.data!.cars![i]!.carInfo!.price}',style: TextStyle(
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
                                            color: snapshot.data!.cars![i]!.activeStatus != null && snapshot.data!.cars![i]!.activeStatus == true ? Colors.green : Colors.red,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Text('${snapshot.data!.cars![i]!.activeStatus != null && snapshot.data!.cars![i]!.activeStatus == true ? 'Active': "Inactive"}',
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
                                            onClick: ()=>ShowSingleCar(snapshot!.data!.cars![i]!.carInfo!, i),
                                          ),
                                          SizedBox(width: 5,),
                                          AppIconButton(
                                            icon: Icons.edit,
                                            onClick: ()=>Get.to(MainPage(pageIndex: 4, constructorData: snapshot.data!.cars![i],), transition: Transition.fadeIn),
                                            bgColor: Colors.amber,
                                          ),
                                          const SizedBox(width: 5,),
                                          AppIconButton(
                                            icon: Icons.report_gmailerrorred_rounded,
                                            onClick: (){},
                                            bgColor: AppColors.blue,
                                          ),
                                          const SizedBox(width: 5,),
                                        ],
                                      ),

                                    ),
                                  ]
                              ),
                          ],
                        ),
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
  Future<void> ShowSingleCar(CarInfo carInfo, i) async {
    var size = MediaQuery.of(context).size;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content:  Container(
            width: Responsive.isDesktop(context) ? size.width*.80 : size.width,
            //height: Responsive.isDesktop(context) ? size.width*.80 : size.width*.90,
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
                                  child: Text("\$${carInfo!.price}/month*",
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 40
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 10,),

                              RichTextWidget(leftText: "Plate No: ", rightText: "#${carInfo!.plateNo}"),
                              SizedBox(height: 10,),
                              Divider(height: 1,),
                              SizedBox(height: 10,),

                              RichTextWidget(leftText: "Make: ", rightText: "${carInfo!.vmake}"),
                              SizedBox(height: 10,),
                              Divider(height: 1,),
                              SizedBox(height: 10,),

                              RichTextWidget(leftText: "Model: ", rightText: "${carInfo!.vmodel}"),
                              SizedBox(height: 10,),
                              Divider(height: 1,),
                              SizedBox(height: 10,),

                              RichTextWidget(leftText: "Year: ", rightText: "${carInfo!.vyear}"),
                              SizedBox(height: 10,),
                              Divider(height: 1,),
                              SizedBox(height: 10,),
                              RichTextWidget(leftText: "Color: ", rightText: "${carInfo!.vcolor}"),
                              SizedBox(height: 10,),
                              Divider(height: 1,),
                              SizedBox(height: 10,),

                              RichTextWidget(leftText: "Location: ", rightText: "${carInfo!.location}"),
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
                              child: AppNetworkImage(
                                  url: "${carInfo.images!.carImage}", width: 220, height: 220)
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
                                     AppNetworkImage(url: "${carInfo!.images!.fh1}", width: 100, height: 50),
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
                                      AppNetworkImage(url: "${carInfo!.images!.insurance}", width: 100, height: 50),
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
                                      AppNetworkImage(url: "${carInfo!.images!.driverDiclaration}", width: 100, height: 50),
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

