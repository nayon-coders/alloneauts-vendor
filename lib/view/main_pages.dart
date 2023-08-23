import 'package:flutter/material.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view/dashboard/dashboard.dart';
import 'package:vendor/view/pages.dart';
import 'package:vendor/view/rent/AddCar.dart';
import 'package:vendor/view_controller/appDrawer.dart';

import '../view_controller/appTopbar.dart';
import '../view_controller/expanded_menu.dart';
import '../view_controller/single_menu.dart';


class MainPage extends StatefulWidget {
  final int pageIndex;
  final dynamic menuNumber;
  const MainPage({Key? key, this.pageIndex=0, this.menuNumber}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.green,
      child: SafeArea(
        child: Scaffold(
          body: Row(
            children: [
              Expanded(
                  child: Container(
                      color: AppColors.white,
                      child: Drawer(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                          child: ListView(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset("assets/images/logo.png", height: 100, width: 100,),
                              SizedBox(height: 20,),
                              Divider(height: 1,),
                              SizedBox(height: 30,),
                              MenuBar(
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
                                      children: [
                                        buildChildMenu(
                                            size: size,
                                            menuNumber: "2-1",
                                            title: "Manage Vehicle's",
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
                                            title: "Add new Vehicle",
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
                                            title: "Rent Request",
                                            onClick:  (){
                                              setState(() =>selectedChildMenuNumber[0]="2-3");
                                              //pageCount = 1; //AddCar()
                                              // Add new car screen
                                            }
                                        ),
                                        SizedBox(height: 10,),
                                        buildChildMenu(
                                            size: size,
                                            menuNumber: "2-4",
                                            title: "Assign Vehicle",
                                            onClick:  (){
                                              setState(() =>selectedChildMenuNumber[0]="2-4");
                                              //pageCount = 1; //AddCar()
                                              // Add new car screen
                                            }
                                        ),
                                        SizedBox(height: 10,),
                                        buildChildMenu(
                                            size: size,
                                            menuNumber: "2-5",
                                            title: "Vehicle Report's",
                                            onClick:  (){
                                              setState(() =>selectedChildMenuNumber[0]="2-5");
                                              pageCount = 7; //Create Reports()
                                              // Add new car screen
                                            }
                                        ),
                                        SizedBox(height: 10,),
                                        buildChildMenu(
                                            size: size,
                                            menuNumber: "2-6",
                                            title: "Payment Report's",
                                            onClick:  (){
                                              setState(() =>selectedChildMenuNumber[0]="2-6");
                                              pageCount = 7; //Create Reports()
                                              // Add new car screen
                                            }
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // ExpandedMenu(
                              //   onClick: (){
                              //     setState(() {
                              //       selectedMenuNumber[0] = 5;
                              //     });
                              //   },
                              //   isSelected: selectedMenuNumber[0] == 5 ? true : false,
                              //   onLongPress: (){},
                              //   title: "Reports",
                              //   icon: Icons.report_gmailerrorred,
                              //   content: Row(
                              //     children: [
                              //       Container(
                              //         height: 100,
                              //         width: 2,
                              //         color: AppColors.green,
                              //       ),
                              //       SizedBox(width: 10,),
                              //       Column(
                              //         children: [
                              //           buildChildMenu(
                              //               size: size,
                              //               menuNumber: "5-1",
                              //               title: "Vehicle Report's",
                              //               onClick:  (){
                              //                 setState(() =>selectedChildMenuNumber[0]="5-1");
                              //                 pageCount = 7; //Create Reports()
                              //               }
                              //           ),
                              //
                              //           SizedBox(height: 10,),
                              //           buildChildMenu(
                              //               size: size,
                              //               menuNumber: "5-2",
                              //               title: "Payment Reports",
                              //               onClick:  (){
                              //                 setState(() =>selectedChildMenuNumber[0]="5-2");
                              //               }
                              //           ),
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // ),

                              //rent reports - id: 6
                              ExpandedMenu(
                                onClick: (){
                                  setState(() {
                                    selectedMenuNumber[0] = 6;
                                  });
                                },
                                isSelected: selectedMenuNumber[0] == 6 ? true : false,
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
                                            menuNumber: "${widget.menuNumber}",
                                            title: "Ticket Management",
                                            onClick:  (){
                                              setState(() =>selectedChildMenuNumber[0]="${widget.menuNumber}");
                                              pageCount = 10; //Final ticket
                                            }
                                        ),

                                        SizedBox(height: 10,),
                                        buildChildMenu(
                                            size: size,
                                            menuNumber: "6-2",
                                            title: "Find Ticket",
                                            onClick:  (){
                                              setState(() =>selectedChildMenuNumber[0]="6-2");
                                              pageCount = 9;
                                            }
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              //rent reports - id: 7
                              //rent reports - id: 6
                              ExpandedMenu(
                                onClick: (){
                                  setState(() {
                                    selectedMenuNumber[0] = 7;
                                  });
                                },
                                isSelected: selectedMenuNumber[0] == 7 ? true : false,
                                onLongPress: (){},
                                title: "Employ Manage",
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
                                            menuNumber: "7-1",
                                            title: "Create Employ",
                                            onClick:  (){
                                              setState(() =>selectedChildMenuNumber[0]="7-1");
                                              pageCount = 12; //Final ticket
                                            }
                                        ),

                                        SizedBox(height: 10,),
                                        buildChildMenu(
                                            size: size,
                                            menuNumber: "7-2",
                                            title: "Manage",
                                            onClick:  (){
                                              setState(() =>selectedChildMenuNumber[0]="7-2");
                                              pageCount = 13; //employ salary shit
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
                      )
                  ),
              ),
              Expanded(
                flex: 5,
               // child: Dashboard(), //index = 0,
                child: Container(
                  height: size.height,
                  width: size.width*.60,
                  color: AppColors.bg,
                  child: ListView(
                    children: [
                      AppTopBar(),
                      AllPages.allPages[pageCount], //index = 0
                    ],
                  ),
                )
              )
            ],
          ),
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
        width: size.width*.13,
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



