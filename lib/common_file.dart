import 'package:flutter/material.dart';
import 'package:vendor/utility/app_color.dart';

class Replace extends StatefulWidget {
  const Replace({Key? key}) : super(key: key);

  @override
  State<Replace> createState() => _ReplaceState();
}

class _ReplaceState extends State<Replace> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.green,
      child: SafeArea(
        child: Scaffold(

        ),
      ),
    );
  }
}
