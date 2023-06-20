import 'package:flutter/material.dart';

import '../../view_controller/bigText.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: ListView(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: ()=>Navigator.pop(context),
                icon: Icon(Icons.arrow_back),
              ),
              SizedBox(width: 10,),
              BigText(text: "My Profile"),
            ],
          ),
          SizedBox(height: 20,),
          
         Expanded(
           child: Container(
             height: 150,
             child: Stack(
               children: [

                 Image.asset("assets/images/car2.jpeg",
                   height: 150, width: size.width, fit: BoxFit.cover,),
                 Container(
                   width: size.width,
                   height: 150,
                   decoration: BoxDecoration(
                     color: Colors.black.withOpacity(0.5),
                   ),
                 ),
                 Align(
                   alignment: Alignment.centerRight,
                   child: IconButton(
                     icon: Icon(Icons.edit, color: Colors.green,),
                     onPressed: (){},
                   ),
                 ),
               ],
             ),
           ),
         ),
          SizedBox(height: 20,),

        ],
      ),
    );
  }
}
