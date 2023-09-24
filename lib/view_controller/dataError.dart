import 'package:flutter/material.dart';

class DataError extends StatelessWidget {
  final VoidCallback onClick;
  const DataError({Key? key, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width*.50,
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Check your internet connection or Try again."),
          SizedBox(height: 10,),
          TextButton(onPressed: onClick, child: Text("Try again."))
        ],
      ),
    );
  }
}
