import 'package:flutter/material.dart';

import '../utility/app_color.dart';

class MenuBar extends StatelessWidget {
  const MenuBar({
    Key? key, required this.title, required this.onClick, required this.icon, this.isSelected = false
  }) : super(key: key);

  final String title;
  final VoidCallback onClick;
  final IconData icon;
  final isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.green.withOpacity(0.4) : AppColors.white,
       // borderRadius: BorderRadius.circular(4)
      ),
      child: ListTile(
        selectedColor: AppColors.green.withOpacity(0.4),
        hoverColor: AppColors.green.withOpacity(0.4),
        horizontalTitleGap: 0.00,
        onTap: onClick,
        leading: Icon(icon, color: AppColors.green,),
        title: Text("$title",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor
          ),
        ),
      ),
    );
  }
}
