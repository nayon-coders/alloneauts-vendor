import 'package:flutter/material.dart';

import '../utility/app_color.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key, required this.onClick, required this.text,  this.bgColor = AppColors.green,  this.borderColor=Colors.transparent, required this.width,  this.height=40.00,  this.textSize= 13.00, this.textColor = Colors.white
  }) : super(key: key);
  final String text;
  final Color bgColor;
  final Color textColor;
  final Color borderColor;
  final double width;
  final double height;
  final double textSize;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: bgColor,
            border: Border.all(width: 1, color: borderColor)
        ),
        child: Center(
          child: Text("$text",
            style: TextStyle(
                fontSize: textSize,
                fontWeight: FontWeight.w600,
                color: textColor
            ),
          ) ,
        ),
      ),
    );
  }
}
