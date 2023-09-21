import 'package:flutter/material.dart';
import 'package:vendor/response.dart';

import '../../../utility/app_color.dart';
import '../../../view_controller/appButton.dart';
import '../../../view_controller/bigText.dart';

class DashboardPlanPopup extends StatelessWidget {
  const DashboardPlanPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only( bottom: 10,),
      decoration: BoxDecoration(
          color: AppColors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(5)
      ),
      child: Responsive.isMobile(context)
          ? Column(
        children: [
          PlanPopupContent(size: size),
          SizedBox(height: 10,),
          AppButton(
              onClick: (){},
              text: "Upgrade",
              textSize: 10,
              width: size.width),
        ],
      )
          : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PlanPopupContent(size: size),
              AppButton(
                  onClick: (){},
                  text: "Upgrade",
                  textSize: 10,
                  width: size.width*.15)
            ],
          )
    );
  }
}

class PlanPopupContent extends StatelessWidget {
  const PlanPopupContent({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:Responsive.isMobile(context) ? size.width : size.width*.60,
      child: Column(
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
    );
  }
}
