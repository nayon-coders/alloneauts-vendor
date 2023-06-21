import 'package:flutter/material.dart';

import '../utility/app_color.dart';

class AppInput extends StatelessWidget {
  const AppInput({
    Key? key,
    required this.controller, required this.title,  this.prefixIcon,  this.readOnly = false,
    required this.hintText, this.value, this.maxLine = 1
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  final String hintText;
  final String? value;
  final IconData? prefixIcon;
  final bool readOnly;
  final int maxLine;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: AppColors.black
          ),
        ),
        SizedBox(height: 10,),
        TextFormField(

          maxLines: maxLine,
          readOnly: readOnly,
          controller: controller,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 1, color: AppColors.green.withOpacity(0.3))
              ),

              hintText: "$hintText",
              prefixIcon: Icon(prefixIcon)
          ),

        )
      ],
    );
  }
}
