import 'package:flutter/material.dart';

import '../utility/app_color.dart';

class SingleBoxes extends StatelessWidget {
  const SingleBoxes({
    Key? key, required this.title, required this.subTitle, required this.icon, required this.title2, required this.subTitle2, required this.icon2,
  }) : super(key: key);
  final String title;
  final String title2;
  final String subTitle;
  final String subTitle2;
  final Widget icon;
  final Widget icon2;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 170,
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: icon
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("$title",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black
                      ),
                    ),
                    SizedBox(height: 3,),
                    Text("$subTitle",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10,),
            Divider(height: 1, color: Colors.grey,),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 40,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: icon2
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("$title2",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black
                      ),
                    ),
                    SizedBox(height: 3,),
                    Text("$subTitle2",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
