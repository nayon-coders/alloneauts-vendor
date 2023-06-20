import 'package:flutter/material.dart';
import '../utility/app_color.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    Key? key, required this.onClick, required this.icon,  this.bgColor = AppColors.green,  this.borderColor = Colors.transparent,  this.iconColor = AppColors.white,
  }) : super(key: key);
  final IconData icon;
  final Color bgColor;
  final Color borderColor;
  final Color iconColor;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            border: Border.all(width: 1, color: borderColor),
            color: bgColor
        ),
        child: Icon(icon,color: iconColor, size: 20,),
      ),
    );
  }
}
