import 'package:flutter/material.dart';

import '../view_controller/appButton.dart';
import '../view_controller/bigText.dart';
import 'app_color.dart';

Future<void> openPopUp({required BuildContext context, required String title}){
   var size = MediaQuery.of(context).size;
   return showDialog<void>(
     context: context,
     barrierDismissible: false, // user must tap button!
     builder: (BuildContext context) {
       return AlertDialog(
         content:  StatefulBuilder(
             builder: (BuildContext context, StateSetter setState) {
               return Container(
                 width: size.width*.30,
                 child: Column(
                   children: [
                     Center(child: BigText(text: "${title}")),
                     const SizedBox(height: 40,),
                     const Icon(Icons.check_circle, size: 120, color: AppColors.green,),
                     const SizedBox(height: 30,),
                     Align(
                       alignment: Alignment.center,
                       child: AppButton(
                         width: size.width*.30,
                         text: "OK",
                         onClick: (){},
                       ),
                     ),
                     SizedBox(height: 15,),
                   ],
                 )
               );
             }
         ),
         actions: <Widget>[
           TextButton(
             child: const Text('Cancel'),
             onPressed: () {
               Navigator.of(context).pop();
             },
           ),
         ],
       );
     },
   );
 }