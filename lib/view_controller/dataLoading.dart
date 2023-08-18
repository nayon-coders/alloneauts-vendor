import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DataLoading extends StatelessWidget {
  final String text;
  const DataLoading({Key? key, required this.text}) : super(key: key);

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
            Text('$text',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 20,),
            SpinKitWave(
              color: Colors.green,
              size: 30.0,
            )
          ],
        )
    );
  }
}
