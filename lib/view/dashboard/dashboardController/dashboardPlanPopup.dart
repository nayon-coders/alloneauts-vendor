import 'package:flutter/material.dart';

import '../../../utility/app_color.dart';
import '../../../view_controller/appButton.dart';
import '../../../view_controller/bigText.dart';

class DashboardPlanPopup extends StatelessWidget {
  const DashboardPlanPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width*.80,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only( bottom: 10,),
              decoration: BoxDecoration(
                  color: AppColors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('You are active our "GOLD" plan.',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.green
                        ),
                      ),
                      Text('If you want to upgrade plan, then go to the upgrade option and upgrade your plan.',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey
                        ),
                      ),
                    ],
                  ),
                  AppButton(onClick: (){}, text: "Upgrade", width: 150)
                ],
              ),
            ),

          ],
        ),
      ],
    );
  }
}
