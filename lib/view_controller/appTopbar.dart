import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vendor/view/main_pages.dart';
import '../utility/app_color.dart';

class AppTopBar extends StatelessWidget {
  const AppTopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 50),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Search anything",
                  fillColor: AppColors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  contentPadding: EdgeInsets.only(left: 20,right: 20, top: 10, bottom: 10),
                  prefixIcon: Icon(CupertinoIcons.smiley)
              ),
            ),
          ),
          SizedBox(width: 20,),
          Stack(
            children: [
              Container(
                width: 45, height: 45,
                decoration: BoxDecoration(
                    color: AppColors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Icon(Icons.notifications_active_outlined,color: AppColors.green,),
              ),
              Positioned(
                right: 0, top: -0,
                child: Container(
                    width: 20, height: 20,
                    decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Center(child: Text("10",
                      style: TextStyle(
                          fontSize: 9, color: AppColors.white
                      ),
                    ))
                ),
              ),


            ],
          ),
          SizedBox(width: 10,),
          Stack(
            children: [
              Container(
                width: 45, height: 45,
                decoration: BoxDecoration(
                    color: AppColors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Icon(Icons.mail_outline_outlined,color: AppColors.blue,),
              ),
              Positioned(
                right: 0, top: -0,
                child: Container(
                    width: 20, height: 20,
                    decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Center(child: Text("15",
                      style: TextStyle(
                          fontSize: 9, color: AppColors.white
                      ),
                    ))
                ),
              ),


            ],
          ),
          SizedBox(width: 20,),
          Container(
            width: 2,
            height: 40,
           color: Colors.grey.shade300,
          ),
          SizedBox(width: 20,),
          Text("Nayon Talukder",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.black
            ),
          ),
          SizedBox(width: 10,),
          InkWell(
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage(pageIndex: 6,))),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Icon(Icons.person, size: 40,)
            ),
          )

        ],
      ) ,
    );
  }
}
