import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/app_config.dart';
import 'package:vendor/utility/app_color.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vendor/view/main_pages.dart';
import 'package:vendor/view_controller/appButton.dart';
import 'package:vendor/view_controller/appPoup.dart';

import '../../view_controller/appInput.dart';
import '../../view_controller/bigText.dart';

class AddCar extends StatefulWidget {
  const AddCar({Key? key}) : super(key: key);

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {

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
  Future uploadImage(carInfo) async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    var header = {
      "Accept" : "Application/json",
      "Authorization" : "Bearer $token"
    };
    var url = Uri.parse(AppConfig.ADD_CAR_FOR_RENT);
    var request = http.MultipartRequest("POST", url);
    request.headers.addAll(header);
      request.files.add(await http.MultipartFile.fromBytes('car_images', _carImage!.toList()!,
          contentType: MediaType('application', 'json'), filename: "car_image"));

      request.files.add(await http.MultipartFile.fromBytes('fh', _fh1Image!,
          contentType: MediaType('application', 'json'), filename: "fh1_image"));

      request.files.add(await http.MultipartFile.fromBytes('insurance', _insuranceImage!,
          contentType: MediaType('application', 'json'), filename: "insurance"));
      request.files.add(await http.MultipartFile.fromBytes('diclaration', _driverLicenceImage!,
          contentType: MediaType('application', 'json'), filename: "diclaration"));

      request.fields.addAll(carInfo);
      print("Car info ==== ${carInfo}");

    request.send().then((response) {
      if (response.statusCode == 200) {
        print("File uploaded successfully");
        AppPopup.appPopup(
          context: context,
          title: "You Vehicle added success!",
          body: "You new Vehicle create success. You can check it from Vehicle rent->Manage Vehicle's",
          dialogType: DialogType.success,
          onOkBtn: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage(pageIndex: 3,))),
        );
      } else {
        print('file upload failed');
        AppPopup.appPopup(
          context: context,
          title: "Something went wrong !",
          body: "You new Vehicle create success. You can check it from Vehicle rent->Manage Vehicle's",
          dialogType: DialogType.error,
          onOkBtn: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage(pageIndex: 3,))),
        );
      }
      setState(() {
        isLoading = false;
      });
    });
  }

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
                onPressed: ()=>Get.back(),
                icon: Icon(Icons.arrow_back, color: AppColors.green,),
              ),
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
                    onClick: ()async{
                      var carInfo = {
                        "name" : "Car Name",
                        "plate_no" : platNo.text,
                        "price" : price.text,
                        "vmake" : make.text.toString(),
                        "vmodel" : model.text.toString(),
                        "vyear" : year.text.toString(),
                        "color" : color.text.toString(),
                        "vcolor" : color.text.toString(),
                        "vtrim" : trim.text.toString(),
                        "location" : location.text.toString(),
                        "location" : location.text.toString(),
                        "latitude" : "23.727009",
                        "longitude" : "90.4219455",
                        "email" : email.text.toString(),
                        "contact" : phone.text.toString(),
                        "contact" : phone.text.toString(),
                        "mileage" : maileg.text,
                      };
                      uploadImage(carInfo);
                    },
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



}



