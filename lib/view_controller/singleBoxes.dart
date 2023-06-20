import 'package:flutter/material.dart';

import '../utility/app_color.dart';

class SingleBoxes extends StatelessWidget {
  const SingleBoxes({
    Key? key, required this.title, required this.subTitle, required this.icon,
  }) : super(key: key);
  final String title;
  final String subTitle;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 150,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
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
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black
                  ),
                ),
                SizedBox(height: 8,),
                Text("$subTitle",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
