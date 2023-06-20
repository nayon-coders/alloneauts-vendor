import 'package:flutter/material.dart';
import 'package:vendor/view/main_pages.dart';
import 'package:vendor/view/rent/AddCar.dart';
import 'package:vendor/view_controller/single_menu.dart';

import '../utility/app_color.dart';
import 'expanded_menu.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {


  //selected menu bar
  List selectedMenuNumber = [1];
  List selectedChildMenuNumber = ["1-1"];

  bool isChildMenuHover = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
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
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage()));
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
                        height: 80,
                        width: 2,
                        color: AppColors.green,
                      ),
                      SizedBox(width: 10,),
                      Column(
                        children: [
                          buildChildMenu(
                              size: size,
                              menuNumber: "2-1",
                              title: "Manage Car's",
                              onClick:  (){
                                setState(() =>selectedChildMenuNumber[0]="2-1");
                              }
                          ),
                          SizedBox(height: 10,),
                          buildChildMenu(
                              size: size,
                              menuNumber: "2-2",
                              title: "Add new Car",
                              onClick:  (){
                                setState(() =>selectedChildMenuNumber[0]="2-2");
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCar()));
                              }
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //rent request - id: 3
                MenuBar(
                  title: "Rent Request",
                  onClick: (){
                    setState(() {
                      selectedMenuNumber[0] = 3;
                    });
                  },
                  icon: Icons.car_crash_rounded,
                  isSelected: selectedMenuNumber[0] == 3 ? true : false,
                ),
                //Assign car - id: 4
                MenuBar(
                  title: "Assign Car",
                  onClick: (){
                    setState(() {
                      selectedMenuNumber[0] = 4;
                    });
                  },
                  icon: Icons.assignment_outlined,
                  isSelected: selectedMenuNumber[0] == 4 ? true : false,
                ),
                //rent reports - id: 5
                ExpandedMenu(
                  onClick: (){
                    setState(() {
                      selectedMenuNumber[0] = 5;
                    });
                  },
                  isSelected: selectedMenuNumber[0] == 5 ? true : false,
                  onLongPress: (){},
                  title: "Reports",
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
                              menuNumber: "5-1",
                              title: "Create Report",
                              onClick:  (){
                                setState(() =>selectedChildMenuNumber[0]="5-1");
                              }
                          ),
                          SizedBox(height: 10,),
                          buildChildMenu(
                              size: size,
                              menuNumber: "5-2",
                              title: "View Reports",
                              onClick:  (){
                                setState(() =>selectedChildMenuNumber[0]="5-2");
                              }
                          ),
                          SizedBox(height: 10,),
                          buildChildMenu(
                              size: size,
                              menuNumber: "5-3",
                              title: "Payment Reports",
                              onClick:  (){
                                setState(() =>selectedChildMenuNumber[0]="5-3");
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
        child: Text("$title"),
      ),
    );
  }
}
