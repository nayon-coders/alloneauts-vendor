import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';

import '../utility/app_color.dart';

class ExpandedMenu extends StatelessWidget {
  const ExpandedMenu({
    Key? key, required this.title, required this.icon, required this.onClick, required this.onLongPress, this.isExpand = false, this.isSelected = false, required this.content
  }) : super(key: key);
  final String title;
  final IconData icon;
  final Widget content;
      final VoidCallback onClick;
      final VoidCallback onLongPress;
      final bool isExpand;
      final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ExpandedTile(
      theme:  ExpandedTileThemeData(
        headerColor: isSelected ? AppColors.green.withOpacity(0.4) : AppColors.white,
        headerRadius: 0.0,
        headerPadding: EdgeInsets.only(left: 5.0, right: 5, top: 10 ,bottom: 10),
        contentBackgroundColor: AppColors.green.withOpacity(0.1),
        contentPadding: EdgeInsets.only(left: 20.0, right: 5, top: 10 ,bottom: 10),
        contentRadius: 10.0,
      ),
      controller: ExpandedTileController(isExpanded:isExpand),
      title: Row(
        children: [
          Icon(icon, color: AppColors.green,),
          SizedBox(width: 3,),
          Text("$title",
            style: TextStyle(
                fontSize: 12,
                color: AppColors.textColor,
                fontWeight: FontWeight.w500
            ),
          )
        ],
      ),
      content: content!,
      onTap:onClick,
      onLongTap:onLongPress,
    );
  }
}
