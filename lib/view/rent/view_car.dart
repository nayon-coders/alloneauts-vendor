import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vendor/view_controller/appButton.dart';
import 'package:vendor/view_controller/richText.dart';

import '../../utility/app_color.dart';
import '../../view_controller/appIconButton.dart';
import '../../view_controller/bigText.dart';
import '../main_pages.dart';

class ViewSingleCar extends StatefulWidget {
  const ViewSingleCar({Key? key}) : super(key: key);

  @override
  State<ViewSingleCar> createState() => _ViewSingleCarState();
}

class _ViewSingleCarState extends State<ViewSingleCar> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: ()=>Navigator.pop(context),
                  icon: Icon(Icons.arrow_back),
                ),
                SizedBox(width: 10,),
                BigText(text: "View #TC74857CH Car"),
              ],
            ),
           Padding(
             padding: const EdgeInsets.only(right: 20.0),
             child: AppButton(
                 onClick: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage(pageIndex: 4,))), //navigat to edit pages
                 text: "Edit Card",
                 width: 150,
             ),
           ),
          ],
        ),
        SizedBox(height: 20,),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    spreadRadius: 2, blurRadius: 3,
                    offset: Offset(0,2)
                )
              ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //top part
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 5, color: AppColors.green,),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color:AppColors.green
                            ),
                            child: Center(
                              child: Text("\$450/month*",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 40
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          RichTextWidget(leftText: "Car Name: ", rightText: "SM TYOTA"),
                          SizedBox(height: 10,),
                          Divider(height: 1,),
                          SizedBox(height: 10,),

                          RichTextWidget(leftText: "Plate No: ", rightText: "#TC875J95J"),
                          SizedBox(height: 10,),
                          Divider(height: 1,),
                          SizedBox(height: 10,),

                          RichTextWidget(leftText: "Make: ", rightText: "TOYTA"),
                          SizedBox(height: 10,),
                          Divider(height: 1,),
                          SizedBox(height: 10,),

                          RichTextWidget(leftText: "Model: ", rightText: "SM"),
                          SizedBox(height: 10,),
                          Divider(height: 1,),
                          SizedBox(height: 10,),

                          RichTextWidget(leftText: "Year: ", rightText: "2020"),
                          SizedBox(height: 10,),
                          Divider(height: 1,),
                          SizedBox(height: 10,),
                          RichTextWidget(leftText: "Color: ", rightText: "Red"),
                          SizedBox(height: 10,),
                          Divider(height: 1,),
                          SizedBox(height: 10,),

                          RichTextWidget(leftText: "Location: ", rightText: "Dhaka, Bangladesh"),
                          SizedBox(height: 10,),
                          Divider(height: 1,),
                          SizedBox(height: 10,),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 350,
                      padding: EdgeInsets.all(10),
                      child: Image.network("https://content-images.carmax.com/qeontfmijmzv/MY19MKj0XutK084z874jt/9632621fd8464b5c0e54a9dee64ad4e5/tesla.jpg", height: 250, width: 300,),                ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Text("Car Documents",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 150,
                      child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS52euNxvkjw46zWDVeEwcd7rYWX4SpucPrry2cDIpnIHbQ6-i3K3-TP2bwqRBhpit1vh8&usqp=CAU", height: 150, fit: BoxFit.cover,)
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Container(
                        height: 150,
                        child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS52euNxvkjw46zWDVeEwcd7rYWX4SpucPrry2cDIpnIHbQ6-i3K3-TP2bwqRBhpit1vh8&usqp=CAU", height: 150, fit: BoxFit.cover,)
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Container(
                        height: 150,
                        child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS52euNxvkjw46zWDVeEwcd7rYWX4SpucPrry2cDIpnIHbQ6-i3K3-TP2bwqRBhpit1vh8&usqp=CAU", height: 150, fit: BoxFit.cover,)
                    ),
                  ),

                ],
              )

              //bottom part
            ],
          ),
        ),
      ],
    );
  }
}
