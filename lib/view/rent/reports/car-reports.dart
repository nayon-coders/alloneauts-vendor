import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/app_config.dart';
import 'package:vendor/controller/rentCarController/rentCarController.dart';
import 'package:vendor/model/rentModels/car_repots_list_model.dart';
import 'package:vendor/response.dart';
import 'package:vendor/view_controller/appButton.dart';
import 'package:vendor/view_controller/appNetworkImage.dart';
import 'package:vendor/view_controller/bigText.dart';
import 'package:vendor/view_controller/loadingWidget.dart';

import '../../../carImageJson.dart';
import '../../../utility/app_color.dart';
import '../../../view_controller/appIconButton.dart';
import '../../main_pages.dart';

class CarReports extends StatefulWidget {
  const CarReports({Key? key}) : super(key: key);

  @override
  State<CarReports> createState() => _CarReportsState();
}

class _CarReportsState extends State<CarReports> {
  bool isAllCar = true;
  bool isAssignCar = false;

  List<Car> _availableCarList = [];
  List<Car> _assignCarList = [];
  bool isLoading = false; 
  Future getCarListForReports()async{
    setState(() =>isLoading = true);
    var res = await RentCarController.getCartListForReports();
    //this loop for available car
    for(var i in res!.data!.availableCar!){
      setState(() {
        _availableCarList.add(i);
      });
    }
    //this loop for assign car
    for(var i in res!.data!.assignedCar!){
      setState(() {
        _assignCarList.add(i);
      });
    }

    print("_assignCarList ${_assignCarList.length}");
    setState(() =>isLoading = false);

  }

  Future getAssignCarListForReports()async{
    setState(() =>isLoading = true);
    var res = await RentCarController.getCartListForReports();
    //this loop for assign car
    for(var i in res!.data!.assignedCar!){
      setState(() {
        _assignCarList.add(i);
      });
    }
    setState(() =>isLoading = false);

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCarListForReports();
    //getAssignCarListForReports();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BigText(text: "Car Report's"),
                Row(
                  children: [
                    AppButton(
                        onClick: (){
                          setState(() {
                            isAllCar = true;
                            isAssignCar = false;
                          });
                        },
                      bgColor: isAllCar ? AppColors.blue : Colors.transparent,
                        text: "All",
                        width: 40,
                        height: 20,
                        textSize: 12,
                      textColor: isAllCar ? AppColors.white : AppColors.blue,
                      borderColor: AppColors.blue,
                    ),
                    SizedBox(width: 10,),
                    AppButton(
                        onClick: (){
                          setState(() {
                            isAllCar = false;
                            isAssignCar = true;
                          });
                        },
                        text: "Assign Car",
                        width: 80,
                      bgColor: isAssignCar ? AppColors.blue : Colors.transparent,
                      textColor: isAssignCar ? AppColors.white : AppColors.blue,
                        height: 20,
                        textSize: 12,
                      borderColor: AppColors.blue,
                    ),
                  ],
                ),
               Responsive.isDesktop(context) ?  SizedBox(
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
                ) : Center(),
              ],
            ),
            SizedBox(height: 20,),
            isLoading
                ? Center(child: LoadingWidget(title: "Vehicel's loading..."),)
                :Container(
              width: size.width,
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
              child: isAllCar ? allCarMethod() : assignCarMethod(),
            ),

          ],
        ),
      ),
    );
  }

  allCarMethod() {
    return _availableCarList.isNotEmpty
        ?  DataTable(
              dividerThickness:0,
              sortAscending: false,
              columns: const [
                DataColumn(
                    label: Text(
                    'Car',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
                )),
                DataColumn(label: Text(
                    'Car Name',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
                )),
                DataColumn(label: Text(
                    'Plate No.',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
                )),

                DataColumn(label: Text(
                    'Status.',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
                )),

                DataColumn(label: Text(
                    'Action',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
                )),
              ],
              rows: [
                for(var i=0;i<_availableCarList.length;i++)
                  DataRow(
                      color: MaterialStateColor.resolveWith((states) {
                        return i.isOdd? Colors.grey.shade200 : Colors.white; //make tha magic!
                      }),
                      cells: [
                        DataCell(
                            AppNetworkImage(url: "${AppConfig.DOMAIN}/${_availableCarList[i].images![0]}", width: 60, height: 60)
                        ),
                        DataCell(Text('${_availableCarList[i].details!.name}')),
                        DataCell(Text('#${_availableCarList[i].details!.plateNo}',
                          style: TextStyle(
                              fontWeight: FontWeight.w600
                          ),
                        )),
                        DataCell(
                          Container(
                            padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              color: _availableCarList[i].active == 1 ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Text('${_availableCarList[i].active == 1 ? "Active" : "Deactivate"}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.black
                              ),
                            ),
                          )
                        ),

                        DataCell(
                          Row(
                            children: [
                              AppIconButton(
                                icon: Icons.remove_red_eye,
                                onClick: ()=>Get.to(MainPage(pageIndex: 5,), transition: Transition.fadeIn),
                              ),
                              SizedBox(width: 5,),
                              AppIconButton(
                                icon: Icons.report_gmailerrorred,
                                onClick: ()=>Get.to(MainPage(pageIndex: 8, carDetails: _availableCarList[i]!.details, carImage: _availableCarList[i]!.images![0], id: _assignCarList[i]!.id.toString(),), transition: Transition.fadeIn),
                                bgColor: Colors.amber,
                              ),
                              SizedBox(width: 5,),

                            ],
                          ),

                        ),
                      ]
                  ),
              ],
            )
        : Container(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Image.asset("assets/images/not-found.jpeg",
                  height: 100, width: 100,
                ),
                SizedBox(height: 10,),
                Text("No data found",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                )
              ],
            ),
        ) ;
  }


  //assign car
  assignCarMethod() {
    return _assignCarList.isNotEmpty
        ?  DataTable(
          dividerThickness:0,
          sortAscending: false,
          columns: const [
            DataColumn(
                label: Text(
                    'Car',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
                )),
            DataColumn(label: Text(
                'Car Name',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
            )),
            DataColumn(label: Text(
                'Plate No.',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
            )),

            DataColumn(label: Text(
                'Driver Info',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
            )),

            DataColumn(label: Text(
                'Status.',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
            )),

            DataColumn(label: Text(
                'Action',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
            )),
          ],
          rows: [
            for(var i=0;i<_assignCarList.length;i++)
              DataRow(
                  color: MaterialStateColor.resolveWith((states) {
                    return i.isOdd? Colors.grey.shade200 : Colors.white; //make tha magic!
                  }),
                  cells: [
                    DataCell(
                        AppNetworkImage(url: "${AppConfig.DOMAIN}/${_assignCarList[i].images![0]}", width: 60, height: 60)
                    ),
                    DataCell(Text('${_assignCarList[i].details!.name}')),
                    DataCell(
                        Text('#${_assignCarList[i].details!.plateNo}',
                      style: TextStyle(
                          fontWeight: FontWeight.w600
                      ),
                    )),
                    DataCell(
                        ClipRRect(
                            borderRadius:BorderRadius.circular(100),
                            child: AppNetworkImage(url: "https://cdn.dribbble.com/users/3305260/screenshots/6570213/ord_4x.jpg?resize=400x0", width: 60, height: 60))
                    ),
                    DataCell(
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              color: _assignCarList[i].active == 1 ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Text(_assignCarList[i].active == 1 ? "Active" : "Deactivate",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.black
                            ),
                          ),
                        )
                    ),

                    DataCell(
                      Row(
                        children: [
                          AppIconButton(
                            icon: Icons.remove_red_eye,
                            onClick: ()=>Get.to(MainPage(pageIndex: 5,), transition: Transition.fadeIn),
                          ),
                          SizedBox(width: 5,),
                          AppIconButton(
                            icon: Icons.report_gmailerrorred,
                            onClick: ()=>Get.to(MainPage(pageIndex: 8, carDetails: _assignCarList[i]!.details, carImage: _assignCarList[i]!.images![0], id: _assignCarList[i]!.id.toString(),), transition: Transition.fadeIn),
                            bgColor: Colors.amber,
                          ),
                          SizedBox(width: 5,),

                        ],
                      ),

                    ),
                  ]
              ),
          ],
        )
        : Container(
      padding: EdgeInsets.all(30),
      child: Column(
        children: [
          Image.asset("assets/images/not-found.jpeg",
            height: 100, width: 100,
          ),
          SizedBox(height: 10,),
          Text("No data found",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          )
        ],
      ),
    ) ;
  }

}
