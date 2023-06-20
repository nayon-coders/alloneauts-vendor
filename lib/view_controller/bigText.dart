import 'package:flutter/material.dart';

import '../utility/app_color.dart';


class BigText extends StatelessWidget {
  const BigText({
    Key? key, required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text("$text",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: AppColors.black
      ),
    );
  }
}