import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vendor/response.dart';
import 'package:vendor/view/main_pages.dart';
import 'package:vendor/view_controller/appButton.dart';
import 'package:vendor/view_controller/appPoup.dart';
import 'package:vendor/view_controller/bigText.dart';
class EmployeeClocking extends StatefulWidget {
  const EmployeeClocking({Key? key}) : super(key: key);

  @override
  State<EmployeeClocking> createState() => _EmployeeClockingState();
}

class _EmployeeClockingState extends State<EmployeeClocking> {
  final pin = TextEditingController();
  bool isVerify = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: ()=>Get.back(),
                    icon: Icon(Icons.arrow_back),
                  ),
                  BigText(text: "Employee Clocking")
                ],
              ),
              SizedBox(height: 30,),
              isVerify
                  ? Container(
                 width: Responsive.isDesktop(context) ? size.width*.50 : size.width*.80,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 4, spreadRadius: 2
                    )
                  ]
                ),
                child: Column(
                  children: [ 
                    Container(
                      height: 200,
                      child: Stack(
                        children: [
                          // Container(
                          //   width: size.width,
                          //   height: 200,
                          //   decoration: BoxDecoration(
                          //     color: Colors.black.withOpacity(0.4),
                          //       image: DecorationImage(
                          //         image: AssetImage("assets/images/morning.jpg"),
                          //         fit: BoxFit.cover,
                          //       )
                          //   ),
                          // ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                             width: 200,
                             height: 200,
                             decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(100),
                               border: Border.all(width: 3, color: Colors.green),
                               image: DecorationImage(
                                 image: AssetImage("assets/images/driver.png"),
                                 fit: BoxFit.cover,
                               )
                             ),
                   ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text("Name:",
                        style: TextStyle(
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      trailing: Text("Nayon Talukder",
                        style: TextStyle(
                          fontSize: 16,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.email_outlined),
                      title: Text("Email:",
                        style: TextStyle(
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      trailing: Text("nayon.coders@gmail.com",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone_android),
                      title: Text("Phone:",
                        style: TextStyle(
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      trailing: Text("+880 1814569747",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.merge_type),
                      title: Text("Job Type:",
                        style: TextStyle(
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      trailing: Text("Hourlly",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.merge_type),
                      title: Text("Shift:",
                        style: TextStyle(
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      trailing: Text("Night Shift",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    AppButton(onClick: ()=>clockIn(), text: "Clocking", width: 100)
                  ],
                ),
              )
                  : Container(
                width: Responsive.isDesktop(context)? size.width*.60 : size.width*.90,
                padding: EdgeInsets.all(20),
                height: size.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
                child: Column(
                  children: [
                    Image.asset("assets/images/pin.jpg", height: 150, width: 150,),
                    SizedBox(height: 10,),
                    Text("Employe PIN",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: size.width*.20,
                      child: PinCodeTextField(
                        length: 4,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          activeColor: Colors.blue,
                          shape: PinCodeFieldShape.box,
                          inactiveFillColor: Colors.grey.shade300,
                          inactiveColor: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                        ),
                        animationDuration: Duration(milliseconds: 300),
                        backgroundColor: Colors.white,
                        enableActiveFill: true,
                        //errorAnimationController: errorController,
                        controller: pin,
                        onCompleted: (v) {
                          print("Completed");
                        },
                        onChanged: (value) {
                          print(value);
                        },
                        appContext: context,
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },

                      ),
                    ),
                    AppButton(onClick: (){
                      setState(() {
                        isVerify = true;
                      });
                    }, text: "VERIFY", width: 100)

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  clockIn() {
    AppPopup.appPopup(context: context, title: "Clock In Success", body: "Clocking is success at 10:00 AM.", dialogType: DialogType.success, onOkBtn: ()=>Get.to(MainPage(pageIndex: 18,)));
  }
}
