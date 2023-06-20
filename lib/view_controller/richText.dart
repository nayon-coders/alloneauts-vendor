import 'package:flutter/material.dart';

import '../utility/app_color.dart';

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    Key? key, required this.leftText, required this.rightText,
  }) : super(key: key);
  final String leftText;
  final String rightText;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          children: [
            TextSpan(
                text: "$leftText",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                )
            ),
            TextSpan(
                text: "$rightText",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                )
            )
          ]
      ),
    );
  }
}
