import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/response.dart';
import 'package:vendor/view/main_pages.dart';
import '../../utility/app_color.dart';
import '../../view/auth/accountVerificationCenter.dart';
import '../appButton.dart';
import 'acocuntVerificationWorning.dart';

class AppTopBar extends StatelessWidget {
  const AppTopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: [
          CustomAppBar(),
          SizedBox(height: 20,),
          AccountVerificationWorning(size: size),
          SizedBox(height: 20,),
        ],
      ) ,
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Responsive.isMobile(context)
        ? Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: size.width*.50,
          child: TextFormField(
            decoration: InputDecoration(
                hintText: "Search anything",
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10
                ),
                fillColor: AppColors.white,
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5)
                ),
                contentPadding: EdgeInsets.only(left: 10,right: 10, top: 5, bottom: 5),
                prefixIcon: Icon(CupertinoIcons.smiley, size: 15,)
            ),
          ),
        ),
        SizedBox(width: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Container(
                  width: 30, height: 30,
                  decoration: BoxDecoration(
                      color: AppColors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Icon(Icons.notifications_active_outlined,color: AppColors.green,),
                ),
                Positioned(
                  right: 0, top: -0,
                  child: Container(
                      width: 10, height: 10,
                      decoration: BoxDecoration(
                          color: AppColors.red,
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Center(child: Text("10",
                        style: TextStyle(
                            fontSize: 7, color: AppColors.white
                        ),
                      ))
                  ),
                ),


              ],
            ),
            SizedBox(width: 10,),
            Stack(
              children: [
                Container(
                  width: 30, height: 30,
                  decoration: BoxDecoration(
                      color: AppColors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Icon(Icons.mail_outline_outlined,color: AppColors.blue,),
                ),
                Positioned(
                  right: 0, top: -0,
                  child: Container(
                      width: 10, height: 10,
                      decoration: BoxDecoration(
                          color: AppColors.red,
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Center(child: Text("15",
                        style: TextStyle(
                            fontSize: 7, color: AppColors.white
                        ),
                      ))
                  ),
                ),


              ],
            ),
            SizedBox(width: 5,),
            Container(
              width: 1,
              height: 20,
              color: Colors.grey.shade300,
            ),
            SizedBox(width: 5,),
            InkWell(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage(pageIndex: 6,))),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Icon(Icons.person, size: 20,)
              ),
            )
          ],
        )

      ],
    )
        : Row(
          children: [
            Expanded(
              flex: 2,
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "Search anything",
                    fillColor: AppColors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    contentPadding: EdgeInsets.only(left: 20,right: 20, top: 10, bottom: 10),
                    prefixIcon: Icon(CupertinoIcons.smiley)
                ),
              ),
            ),
            SizedBox(width: 20,),
            Stack(
              children: [
                Container(
                  width: 45, height: 45,
                  decoration: BoxDecoration(
                      color: AppColors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Icon(Icons.notifications_active_outlined,color: AppColors.green,),
                ),
                Positioned(
                  right: 0, top: -0,
                  child: Container(
                      width: 20, height: 20,
                      decoration: BoxDecoration(
                          color: AppColors.red,
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Center(child: Text("10",
                        style: TextStyle(
                            fontSize: 9, color: AppColors.white
                        ),
                      ))
                  ),
                ),


              ],
            ),
            SizedBox(width: 10,),
            Stack(
              children: [
                Container(
                  width: 45, height: 45,
                  decoration: BoxDecoration(
                      color: AppColors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Icon(Icons.mail_outline_outlined,color: AppColors.blue,),
                ),
                Positioned(
                  right: 0, top: -0,
                  child: Container(
                      width: 20, height: 20,
                      decoration: BoxDecoration(
                          color: AppColors.red,
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Center(child: Text("15",
                        style: TextStyle(
                            fontSize: 9, color: AppColors.white
                        ),
                      ))
                  ),
                ),


              ],
            ),
            SizedBox(width: 20,),
            Container(
              width: 2,
              height: 40,
             color: Colors.grey.shade300,
            ),
            SizedBox(width: 20,),
            Text("Nayon Talukder",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black
              ),
            ),
            SizedBox(width: 10,),
            InkWell(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage(pageIndex: 6,))),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Icon(Icons.person, size: 40,)
              ),
            )
          ],
        );
  }
}

