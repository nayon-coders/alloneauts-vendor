import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/app_config.dart';
import 'package:vendor/firebase/controller/auth_controller.dart';
import 'package:vendor/firebase/controller/firebase_car_controller.dart';
import 'package:vendor/firebase/model/profile_model.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vendor/utility/app_const.dart';
import 'package:vendor/view/main_pages.dart';
import 'package:vendor/view_controller/appButton.dart';
import 'package:vendor/view_controller/appPoup.dart';
import 'package:vendor/view_controller/app_snackbar.dart';

import '../../view_controller/appInput.dart';
import '../../view_controller/bigText.dart';

class AddCar extends StatefulWidget {
  const AddCar({Key? key}) : super(key: key);

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  List<int>? _carImage;//id = 1
  List<int>? _fh1Image; //id = 2
  List<int>? _insuranceImage;//id = 3
  List<int>? _driverLicenceImage;//id = 4

  Uint8List? _unitCarImage;
  Uint8List? _unitFh1Image;
  Uint8List? _unitInsuranceImage;
  Uint8List? _unitDriverLicenceImage;

  startWebFilePicker(index) async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      print("this is files === $files");
      final file = files![0];
      final reader = html.FileReader();

      reader.onLoadEnd.listen((event) {
        if(index == 1){
          setState(() {
            _unitCarImage =
                Base64Decoder().convert(reader.result.toString().split(",").last);
            _carImage = _unitCarImage;
            print("_carImage ==== ${_carImage}");
          });

        }

        if(index == 2){
          setState(() {
            _unitFh1Image =
                Base64Decoder().convert(reader.result.toString().split(",").last);
            _fh1Image = _unitFh1Image;
          });
        }
        if(index == 3){
          setState(() {
            _unitInsuranceImage =
                Base64Decoder().convert(reader.result.toString().split(",").last);
            _insuranceImage = _unitInsuranceImage;
          });
        }
        if(index == 4){
          setState(() {
            _unitDriverLicenceImage =
                Base64Decoder().convert(reader.result.toString().split(",").last);
            _driverLicenceImage = _unitDriverLicenceImage;
          });
        }

      });
      reader.readAsDataUrl(file);
    });
  }

  bool isLoading = false;
  final carName = TextEditingController();
  final platNo = TextEditingController();
  final make = TextEditingController();
  final model = TextEditingController();
  final year = TextEditingController();
  final trim = TextEditingController();
  final location = TextEditingController();
  final price = TextEditingController();
  final color = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final maileg = TextEditingController();


  var _profileModel; // = FirebaseAuthController.getVendorInfo();


  var vendorInfo = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileModel = FirebaseAuthController.getVendorInfo();


  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white
        ),
      child: ListView(
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 25,
                color: AppColors.green,
              ),
              SizedBox(width: 10,),
              const BigText(text: "Add a new car"),
            ],
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.all(15),
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
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 300,
                      child: InkWell(
                        onTap:()=>startWebFilePicker(1),
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                            border: Border.all(width: 1, color: AppColors.green)
                          ),
                          child: _unitCarImage != null
                              ? Image.memory(_unitCarImage!, width: 200, height: 200)
                              : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.cloud_upload_outlined, size: 40, color: AppColors.green,),
                              SizedBox(height: 10,),
                              Text("Upload your Vehicle image."),
                            ],
                          )
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: AppInput(
                                  controller: make,
                                  title: "Make",
                                  hintText: "Make",
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: AppInput(
                                  controller: model,
                                  title: "Model",
                                  hintText: "Model",
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: AppInput(
                                  controller: year,
                                  title: "Year",
                                  hintText: "Year",
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: AppInput(
                                  controller: trim,
                                  title: "Trim",
                                  hintText: "Trim",
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: 20,),
                          AppInput(
                            controller: location,
                            title: "Vehicle Location",
                            hintText: "Select your location",
                          ),
                          SizedBox(height: 20,),
                        ],
                      )
                    ),


                  ],
                ),

                SizedBox(height: 20,),

                Row(
                  children: [
                    const SizedBox(width: 10,),
                    Expanded(
                      child: AppInput(
                        controller: platNo,
                        title: "Plate No",
                        hintText: "TC****",
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: AppInput(
                        controller: color,
                        title: "Color",
                        hintText: "Vehicle color",
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: AppInput(
                        controller: price,
                        title: "Price",
                        hintText: "Rent Price",
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: AppInput(
                        controller: maileg,
                        title: "Mileage",
                        hintText: "Mileage",
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap:()=>startWebFilePicker(2),
                        child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade200,
                                border: Border.all(width: 1, color: AppColors.green)

                            ),
                            child: _unitFh1Image != null
                                ? Image.memory(_unitFh1Image!, width: 200, height: 200)
                                : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.cloud_upload, size: 40, color: AppColors.green,),
                                SizedBox(height: 5,),

                                Text("Upload FH1."),

                              ],
                            )
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: InkWell(
                        onTap:()=>startWebFilePicker(3),
                        child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade200,
                                border: Border.all(width: 1, color: AppColors.green)

                            ),
                            child: _unitInsuranceImage != null
                                ? Image.memory(_unitInsuranceImage!, width: 200, height: 200)
                                : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.cloud_upload, size: 40, color: AppColors.green,),
                                SizedBox(height: 5,),
                                Text("Upload Cirtificate of Insurence."),
                              ],
                            )
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: InkWell(
                        onTap:()=>startWebFilePicker(4),
                        child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade200,
                              border: Border.all(width: 1, color: AppColors.green)
                            ),
                            child: _unitDriverLicenceImage != null
                                ? Image.memory(_unitDriverLicenceImage!, width: 200, height: 200)
                                : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.cloud_upload, size: 40, color: AppColors.green,),
                                SizedBox(height: 5,),
                                Text("Driver Diclaration"),
                              ],
                            )
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: AppInput(
                        controller: email,
                        title: "Email",
                        prefixIcon: Icons.email_outlined,
                        hintText: "nayon.coders@gmail.com",
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: AppInput(
                        controller: phone,
                        title: "Number",
                        prefixIcon: Icons.phone_android,
                        hintText: "+8801814569747",
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 30,),
                isLoading
                    ? Container(
                  width: size.width*.40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.menuColor,
                  ),
                  child: Center(
                    child: CircularProgressIndicator(strokeWidth: 1, color: Colors.white,),
                  ),
                ) : AppButton(
                    onClick: ()=>_addVahicles(),
                    text: "Add Vehicle",
                    width: size.width*.40
                )

              ],
            ),
          ),
          SizedBox(height: 50,),
        ],
      )
    );
  }

  //image selected
  Future<void> pickImage() async {
    print("fileName click");
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null) {
      final fileBytes = result.files.first.bytes;
      final fileName = result.files.first.name;
      print("fileBytes == $fileBytes");
      print("fileName == $fileName");

      // Handle the selected image file (fileBytes)
      // and the file name (fileName) as per your requirements
    } else {
      // User canceled the file picking
    }
  }

 void _addVahicles() async{
    setState(() =>isLoading = true);
    ProfileModel value = await FirebaseAuthController.getVendorInfo();
    setState(() {
      vendorInfo = {
        "vendor_id" : value!.vendorId,
        "vendor_name" : value!.fName! + " " + value.lName!,
        "vendor_email" : value.email,
        "vendor_phone" : value.phone,
      };
    });
    print("vendorInfo === ${vendorInfo}");
   var carImage = await AppConst.uploadImageToFirebaseStorage(_unitCarImage!, "car_images");
   var driverDiclaration = await AppConst.uploadImageToFirebaseStorage(_unitDriverLicenceImage!, "driver_licence_image");
   var fh1 = await AppConst.uploadImageToFirebaseStorage(_unitFh1Image!, "fh1_images");
   var insurance = await AppConst.uploadImageToFirebaseStorage(_unitInsuranceImage!, "insurance_images");

   var todayDate = DateFormat("dd-MM-yyyy").format(DateTime.now());

   //get vendor information

   var carInfo = {
     "cars" : [
       {
         "active_status" : true,
         "assign_status" : false,
         "car_info" : {
           "name" : "${make.text}, ${model.text}, ${year.text}",
           "plate_no" : platNo.text,
           "price" : price.text,
           "vmake" : make.text.toString(),
           "vmodel" : model.text.toString(),
           "vyear" : year.text.toString(),
           "vcolor" : color.text.toString(),
           "vtrim" : trim.text.toString(),
           "location" : location.text.toString(),
           "latitude" : "23.727009",
           "longitude" : "90.4219455",
           "email" : email.text.toString(),
           "contact" : phone.text.toString(),
           "mileage" : maileg.text,
           "images" : {
             "carImage" : carImage,
             "driverDiclaration" : driverDiclaration,
             "fh1" : fh1,
             "insurance": insurance
           },

         },
         "vendor_info" : vendorInfo,
         "assign_driver_info" : {},
         "create_at" : todayDate
       }
     ]
   };
   bool response = await FirebaseCarRentController.addCar(data: carInfo, vendorInfo: vendorInfo, context: context);
   if(response){
     AppSnackBar.appSnackBar("Car added into your list. You can now manage your car.", Colors.green, context);
   }else{
     AppSnackBar.appSnackBar("Something went wrong while adding cars. Please wait or try after sometimes.", Colors.red, context);
   }
    setState(() =>isLoading = false);

 }



}



