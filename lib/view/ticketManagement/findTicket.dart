import 'package:flutter/material.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:vendor/view_controller/appButton.dart';
import 'package:vendor/view_controller/appInput.dart';
import 'package:vendor/view_controller/bigText.dart';

class FindTicket extends StatefulWidget {
  const FindTicket({Key? key}) : super(key: key);

  @override
  State<FindTicket> createState() => _FindTicketState();
}

class _FindTicketState extends State<FindTicket> {
  final platNo = TextEditingController();
  final platState = TextEditingController();
  final platType = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Container(
          margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              
              Row(
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back, color: AppColors.green,)),
                  Text("Find Ticket",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.green
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              BigText(text: "NYC Department of Finance Parking and Camera Violations"),
              SizedBox(height: 30,),
              
              


            ],
          ),
        ),
      ),
    );
  }

  Column searchByVoilation() {
    return Column(
      children: [
        AppInput(controller: platNo, title: "Plate No", hintText: "Enter 10 digit violation number"),
        SizedBox(height: 20,),
        AppButton(onClick: (){}, text: "Search", width: 200)
      ],
    );
  }
}
