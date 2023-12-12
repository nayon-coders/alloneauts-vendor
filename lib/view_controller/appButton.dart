import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utility/app_color.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key, this.isLoading = false, required this.onClick, required this.text,  this.bgColor = AppColors.green,  this.borderColor=Colors.transparent, required this.width,  this.height=40.00,  this.textSize= 13.00, this.textColor = Colors.white
  }) : super(key: key);
  final String text;
  final Color bgColor;
  final Color textColor;
  final Color borderColor;
  final double width;
  final double height;
  final double textSize;
  final VoidCallback onClick;
  final bool isLoading;

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
          child: isLoading
              ? SpinKitWave(
            color: Colors.white,
            size: 20.0,
          ) : Text("$text",
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


// class AppButtonWithLoading extends StatelessWidget {
//   const AppButtonWithLoading({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onClick,
//       child: Container(
//           width: 100, height: 50,
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: AppColors.green,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: isLoading
//               ? SpinKitWave(
//             color: Colors.white,
//             size: 20.0,
//           )
//               : Center(
//             child: Text("Login",
//               style: TextStyle(
//                 fontSize: 13,
//                 color: AppColors.white,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           )
//       ),
//     );
//   }
// }

