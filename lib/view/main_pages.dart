import 'package:flutter/material.dart';
import 'package:vendor/model/carModel/singleCarModel.dart';
import 'package:vendor/model/rentModels/car_repots_list_model.dart';
import 'package:vendor/response.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view/dashboard/dashboard.dart';
import 'package:vendor/view/employ/createEmployee.dart';
import 'package:vendor/view/pages.dart';
import 'package:vendor/view/rent/AddCar.dart';
import 'package:vendor/view/rent/reports/car-reports.dart';
import 'package:vendor/view/rent/reports/create-reports.dart';
import 'package:vendor/view_controller/appTopBar/appDrawer.dart';

import '../view_controller/appTopBar/appTopbar.dart';
import '../view_controller/expanded_menu.dart';
import '../view_controller/single_menu.dart';

import 'package:vendor/view/employ/employSalary/singleSalary.dart';
import 'package:vendor/view/employ/tax/taxManagement.dart';
import 'package:vendor/view/profile/profile.dart';
import 'package:vendor/view/rent/edit_car.dart';
import 'package:vendor/view/rent/manage_car.dart';
import 'package:vendor/view/rent/rentRequest.dart';
import 'package:vendor/view/rent/view_car.dart';
import 'package:vendor/view/ticketManagement/findTicket.dart';
import 'package:vendor/view/ticketManagement/singleTicker.dart';

import 'employ/employManage.dart';
import 'employ/employSalaryShit.dart';
import 'rent/drivers/drivers_list.dart';
import 'ticketManagement/allTicket.dart';
class MainPage extends StatefulWidget {
  final int pageIndex;
  final dynamic constructorData;
  final dynamic carId;
  final dynamic menuNumber;

  //CreateReports ////
  final AssignedCarDetails? carDetails;
  final String? carImage;
  //CreateReports ////
  const MainPage({Key? key, this.carId, this.pageIndex=0, this.menuNumber, this.constructorData, this.carDetails, this.carImage}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  //selected menu bar
  List selectedMenuNumber = [1];
  List selectedChildMenuNumber = ["1-1"];
  bool isChildMenuHover = false;


  //pages
  int pageCount = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("main screen");
    pageCount = widget.pageIndex!;
    allPages.insert(4, EditCar(carInfo: widget.constructorData, id: widget.carId, )); //index = 4)
    allPages.insert(8, CreateReports(carDetails: widget.carDetails, carImage: widget!.carImage, carId: widget.carId,)); //index = 4)

  }

  List allPages = [
    Dashboard(), //index = 0
    RentRequestList(), //index = 1
    ManageCar(), //index = 2
    AddCar(), //index = 3
    //here data will be initial when page is call
    // index 4 comes from initstate
    ViewSingleCar(), //index = 5
    Profile(), //index = 6
    CarReports(), //index = 7
    //come form init - CreateReports(), //index = 8
    FindTicket(), //index = 9
    AllTicket(), //index = 10
    SingleTicket(), //index = 11
    EmployManagement(), //index = 12
    EmploySalaryShit(), //index = 13
    SingleEmploySalary(), //index = 14
    TaxManagement(), //index = 15
    CreateEmployee(), //index = 16
    DriverList(), //index = 17
  ];



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.green,
      child: SafeArea(
        child: Scaffold(
          drawer: buildMobileDesktopMenu(),
            key: _scaffoldKey,
          body: Responsive.isDesktop(context)
              ? Row(
                children: [
                  buildSideMenu(size),
                  Expanded(
                    flex: 5,
                   // child: Dashboard(), //index = 0,
                    child: Container(
                      height: size.height,
                      width: size.width*.60,
                      color: AppColors.bg,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            AppTopBar(),
                            allPages[pageCount], //index = 0
                          ],
                        ),
                      ),
                    )
                  )
                ],
              )
              : Container(
                height: size.height,
                width: size.width,
                color: AppColors.bg,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.menu, color: AppColors.green, size: 30,),
                            onPressed: ()=>_scaffoldKey.currentState?.openDrawer(),
                          )
                        ],
                      ),
                      AppTopBar(),
                      allPages[pageCount], //index = 0
                    ],
                  ),
                ),
              )
        ),
      ),
    );
  }

  Container buildSideMenu(Size size) {
    return Container(
      height: size.height,
      width: 220,
      margin: EdgeInsets.only(top: 30, bottom: 30),
      decoration: BoxDecoration(
        color: AppColors.white,
      ),
      child: ListView(
        children: [
          Image.asset("assets/images/logo.png", height: 100, width: 100,),
          const SizedBox(height: 20,),
          const Divider(height: 1,),
          const SizedBox(height: 30,),
          AppMenuBar(
            title: "Dashboard",
            onClick: (){
              setState(() {
                selectedMenuNumber[0] = 1;
                pageCount = 0; // dashboard screes
              });
            },
            icon: Icons.dashboard_outlined,
            isSelected: selectedMenuNumber[0] == 1 ? true : false,
          ),
          //car menu - id: 2
          ExpandedMenu(
            onClick: (){
              setState(() {
                selectedMenuNumber[0] = 2;
              });
            },
            isSelected: selectedMenuNumber[0] == 2 ? true : false,
            onLongPress: (){},
            title: "Car Rent",
            icon: Icons.list_alt_outlined,
            content: Row(
              children: [
                Container(
                  height: 200,
                  width: 2,
                  color: AppColors.green,
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildChildMenu(
                        size: size,
                        menuNumber: "2-1",
                        title: "Manage Car's",
                        onClick:  (){
                          setState((){
                            selectedChildMenuNumber[0]="2-1";
                            pageCount = 2; //ManageCar()
                          });
                        }
                    ),
                    SizedBox(height: 10,),
                    buildChildMenu(
                        size: size,
                        menuNumber: "2-2",
                        title: "Add new Car",
                        onClick:  (){
                          setState(() =>selectedChildMenuNumber[0]="2-2");
                          pageCount = 3; //AddCar()
                          // Add new car screen
                        }
                    ),
                    SizedBox(height: 10,),
                    buildChildMenu(
                        size: size,
                        menuNumber: "2-3",
                        title: "Rent request",
                        onClick:  (){
                          setState(() =>selectedChildMenuNumber[0]="2-3");
                          pageCount = 1; //AddCar()
                          // Add new car screen
                        }
                    ),
                    SizedBox(height: 10,),
                    buildChildMenu(
                        size: size,
                        menuNumber: "2-5",
                        title: "Vehicles Reports",
                        onClick:  (){
                          setState(() =>selectedChildMenuNumber[0]="2-5");
                          pageCount = 7; //AddCar()
                          // Add new car screen
                        }
                    ),
                    SizedBox(height: 10,),
                    buildChildMenu(
                        size: size,
                        menuNumber: "2-7",
                        title: "Driver List",
                        onClick:  (){
                          setState(() =>selectedChildMenuNumber[0]="2-7");
                          pageCount = 17; //AddCar()
                          // Add new car screen
                        }
                    ),
                  ],
                ),
              ],
            ),
          ),


          ///Ticket manage
          ExpandedMenu(
            onClick: (){
              setState(() {
                selectedMenuNumber[0] = 3;
              });
            },
            isSelected: selectedMenuNumber[0] == 3 ? true : false,
            onLongPress: (){},
            title: "Manage Ticket",
            icon: Icons.report_gmailerrorred,
            content: Row(
              children: [
                Container(
                  height: 100,
                  width: 2,
                  color: AppColors.green,
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildChildMenu(
                        size: size,
                        menuNumber: "3-1",
                        title: "Ticket Management",
                        onClick:  (){
                          setState(() =>selectedChildMenuNumber[0]="3-1");
                          pageCount = 10; //Final ticket
                        }
                    ),

                    SizedBox(height: 10,),
                    buildChildMenu(
                        size: size,
                        menuNumber: "3-2",
                        title: "Find Ticket",
                        onClick:  (){
                          setState(() =>selectedChildMenuNumber[0]="3-2");
                          pageCount = 9;
                        }
                    ),
                  ],
                ),
              ],
            ),
          ),


          ///Tax Manage
          ExpandedMenu(
            onClick: (){
              setState(() {
                selectedMenuNumber[0] = 4;
              });
            },
            isSelected: selectedMenuNumber[0] == 4 ? true : false,
            onLongPress: (){},
            title: "Tax Management",
            icon: Icons.report_gmailerrorred,
            content: Row(
              children: [
                Container(
                  height: 80,
                  width: 2,
                  color: AppColors.green,
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildChildMenu(
                        size: size,
                        menuNumber: "4-1",
                        title: "Tax Manage",
                        onClick:  (){
                          setState(() =>selectedChildMenuNumber[0]="4-1");
                          pageCount = 15; //Final ticket
                        }
                    ),
                  ],
                ),
              ],
            ),
          ),


          ///employ management
          ExpandedMenu(
            onClick: (){
              setState(() {
                selectedMenuNumber[0] = 5;
              });
            },
            isSelected: selectedMenuNumber[0] == 5 ? true : false,
            onLongPress: (){},
            title: "Employee",
            icon: Icons.report_gmailerrorred,
            content: Row(
              children: [
                Container(
                  height: 80,
                  width: 2,
                  color: AppColors.green,
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildChildMenu(
                        size: size,
                        menuNumber: "5-1",
                        title: "Employee Manage",
                        onClick:  (){
                          setState(() =>selectedChildMenuNumber[0]="5-1");
                          pageCount = 12; //Final ticket
                        }
                    ),
                    SizedBox(height: 5,),
                    buildChildMenu(
                        size: size,
                        menuNumber: "5-2",
                        title: "Salary Sheet",
                        onClick:  (){
                          setState(() =>selectedChildMenuNumber[0]="5-2");
                          pageCount = 13; //Final ticket
                        }
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Spacer(),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Text("V1.0.0",
          //     style: TextStyle(
          //       fontWeight: FontWeight.w600,
          //       fontSize: 12,
          //       color: AppColors.green
          //     ),
          //   ),
          // )

        ],
      ),
    );
  }

  ////////////////////////////// mobile and dasktop /////////////////////
  buildMobileDesktopMenu(){
    var size = MediaQuery.of(context).size;
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 10),
        child: ListView(
          children: [
            const SizedBox(height: 20,),
            Image.asset("assets/images/logo.png", height: 100, width: 100,),
            const SizedBox(height: 20,),
            const Divider(height: 1,),
            const SizedBox(height: 30,),
            AppMenuBar(
              title: "Dashboard",
              onClick: (){
                setState(() {
                  selectedMenuNumber[0] = 1;
                  pageCount = 0; // dashboard screes
                });
              },
              icon: Icons.dashboard_outlined,
              isSelected: selectedMenuNumber[0] == 1 ? true : false,
            ),
            //car menu - id: 2
            ExpandedMenu(
              onClick: (){
                setState(() {
                  selectedMenuNumber[0] = 2;
                });
              },
              isSelected: selectedMenuNumber[0] == 2 ? true : false,
              onLongPress: (){},
              title: "Car Rent",
              icon: Icons.list_alt_outlined,
              content: Row(
                children: [
                  Container(
                    height: 200,
                    width: 2,
                    color: AppColors.green,
                  ),
                  SizedBox(width: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildChildMenu(
                          size: size,
                          menuNumber: "2-1",
                          title: "Manage Car's",
                          onClick:  (){
                            setState((){
                              selectedChildMenuNumber[0]="2-1";
                              pageCount = 2; //ManageCar()
                            });
                          }
                      ),
                      SizedBox(height: 10,),
                      buildChildMenu(
                          size: size,
                          menuNumber: "2-2",
                          title: "Add new Car",
                          onClick:  (){
                            setState(() =>selectedChildMenuNumber[0]="2-2");
                            pageCount = 3; //AddCar()
                            // Add new car screen
                          }
                      ),
                      SizedBox(height: 10,),
                      buildChildMenu(
                          size: size,
                          menuNumber: "2-3",
                          title: "Rent request",
                          onClick:  (){
                            setState(() =>selectedChildMenuNumber[0]="2-3");
                            pageCount = 1; //AddCar()
                            // Add new car screen
                          }
                      ),
                      SizedBox(height: 10,),
                      buildChildMenu(
                          size: size,
                          menuNumber: "2-4",
                          title: "Assign Vehicles",
                          onClick:  (){
                            setState(() =>selectedChildMenuNumber[0]="2-4");
                            //pageCount = ; //AddCar()
                            // Add new car screen
                          }
                      ),
                      SizedBox(height: 10,),
                      buildChildMenu(
                          size: size,
                          menuNumber: "2-5",
                          title: "Vehicles Reports",
                          onClick:  (){
                            setState(() =>selectedChildMenuNumber[0]="2-5");
                            pageCount = 7; //AddCar()
                            // Add new car screen
                          }
                      ),
                      SizedBox(height: 10,),
                      buildChildMenu(
                          size: size,
                          menuNumber: "2-6",
                          title: "Payment Reports",
                          onClick:  (){
                            setState(() =>selectedChildMenuNumber[0]="2-6");
                            pageCount = 8; //AddCar()
                            // Add new car screen
                          }
                      ),
                    ],
                  ),
                ],
              ),
            ),


            ///Ticket manage
            ExpandedMenu(
              onClick: (){
                setState(() {
                  selectedMenuNumber[0] = 3;
                });
              },
              isSelected: selectedMenuNumber[0] == 3 ? true : false,
              onLongPress: (){},
              title: "Manage Ticket",
              icon: Icons.report_gmailerrorred,
              content: Row(
                children: [
                  Container(
                    height: 100,
                    width: 2,
                    color: AppColors.green,
                  ),
                  SizedBox(width: 10,),
                  Column(
                    children: [
                      buildChildMenu(
                          size: size,
                          menuNumber: "3-1",
                          title: "Ticket Management",
                          onClick:  (){
                            setState(() =>selectedChildMenuNumber[0]="3-1");
                            pageCount = 10; //Final ticket
                          }
                      ),

                      SizedBox(height: 10,),
                      buildChildMenu(
                          size: size,
                          menuNumber: "3-2",
                          title: "Find Ticket",
                          onClick:  (){
                            setState(() =>selectedChildMenuNumber[0]="3-2");
                            pageCount = 9;
                          }
                      ),
                    ],
                  ),
                ],
              ),
            ),


            ///Tax Manage
            ExpandedMenu(
              onClick: (){
                setState(() {
                  selectedMenuNumber[0] = 4;
                });
              },
              isSelected: selectedMenuNumber[0] == 4 ? true : false,
              onLongPress: (){},
              title: "Tax Management",
              icon: Icons.report_gmailerrorred,
              content: Row(
                children: [
                  Container(
                    height: 80,
                    width: 2,
                    color: AppColors.green,
                  ),
                  SizedBox(width: 10,),
                  Column(
                    children: [
                      buildChildMenu(
                          size: size,
                          menuNumber: "4-1",
                          title: "Tax Manage",
                          onClick:  (){
                            setState(() =>selectedChildMenuNumber[0]="4-1");
                            pageCount = 15; //Final ticket
                          }
                      ),
                    ],
                  ),
                ],
              ),
            ),


            ///employ management
            ExpandedMenu(
              onClick: (){
                setState(() {
                  selectedMenuNumber[0] = 5;
                });
              },
              isSelected: selectedMenuNumber[0] == 5 ? true : false,
              onLongPress: (){},
              title: "Employee",
              icon: Icons.report_gmailerrorred,
              content: Row(
                children: [
                  Container(
                    height: 80,
                    width: 2,
                    color: AppColors.green,
                  ),
                  SizedBox(width: 10,),
                  Column(
                    children: [
                      buildChildMenu(
                          size: size,
                          menuNumber: "5-1",
                          title: "Employee Manage",
                          onClick:  (){
                            setState(() =>selectedChildMenuNumber[0]="5-1");
                            pageCount = 12; //Final ticket
                          }
                      ),
                      SizedBox(height: 5,),
                      buildChildMenu(
                          size: size,
                          menuNumber: "5-2",
                          title: "Salary Sheet",
                          onClick:  (){
                            setState(() =>selectedChildMenuNumber[0]="5-2");
                            pageCount = 13; //Final ticket
                          }
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Spacer(),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Text("V1.0.0",
            //     style: TextStyle(
            //       fontWeight: FontWeight.w600,
            //       fontSize: 12,
            //       color: AppColors.green
            //     ),
            //   ),
            // )

          ],
        ),
      ),
    );
  }



  InkWell buildChildMenu( {
    required Size size,
    required String menuNumber,
    required String title,
    required VoidCallback onClick,
  }) {
    return InkWell(
      onTap:onClick,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        //width: size.width,
        decoration: BoxDecoration(
            color: selectedChildMenuNumber[0] == "$menuNumber"? AppColors.green.withOpacity(0.4) : AppColors.white,
            borderRadius: BorderRadius.circular(4)
        ),
        child: Text("$title",
          style: TextStyle(
            fontSize: 12
          ),
        ),
      ),
    );
  }


}



