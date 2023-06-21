import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
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
import '../../view_controller/planCarManageLimit.dart';

class AddCar extends StatefulWidget {
  const AddCar({Key? key}) : super(key: key);

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {



  List colorList = [
    Colors.red,
    Colors.amber,
    Colors.green,
  ];


  List<int>? _selectedFile;
  Uint8List? _bytesData;

  startWebFilePicker() async {
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
        setState(() {
          _bytesData =
              Base64Decoder().convert(reader.result.toString().split(",").last);
          _selectedFile = _bytesData;
        });
      });
      reader.readAsDataUrl(file);
    });
  }

  Future uploadImage() async {
    var url = Uri.parse("API URL HERE...");
    var request = http.MultipartRequest("POST", url);
    request.files.add(await http.MultipartFile.fromBytes('file', _selectedFile!,
        contentType: MediaType('application', 'json'), filename: "Any_name"));

    request.send().then((response) {
      if (response.statusCode == 200) {
        print("File uploaded successfully");
      } else {
        print('file upload failed');
      }
    });
  }

  final carName = TextEditingController();
  final platNo = TextEditingController();
  final make = TextEditingController();
  final model = TextEditingController();
  final year = TextEditingController();
  final location = TextEditingController();
  final price = TextEditingController();
  final color = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: ListView(
        children: [
          //planing car management limitation.
          //once vendo crossing thire limited.
          PlaingCarManageLimite(),

          BigText(text: "Add New Car"),
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
                    Expanded(
                      child: InkWell(
                        onTap:()=>startWebFilePicker(),
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                          ),
                          child: _bytesData != null
                              ? Image.memory(_bytesData!, width: 200, height: 200)
                              : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Upload your car image."),
                              SizedBox(height: 5,),
                              Icon(Icons.add, color: Colors.black,)
                            ],
                          )
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: Column(
                        children: [
                          AppInput(
                              controller: carName,
                            title: "Car Name",
                            prefixIcon: Icons.title,
                            hintText: "Car name",
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Expanded(
                                child: AppInput(
                                  controller: make,
                                  title: "Make",
                                  prefixIcon: Icons.car_repair_rounded,
                                  hintText: "Make",
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: AppInput(
                                  controller: model,
                                  title: "Model",
                                  prefixIcon: Icons.model_training,
                                  hintText: "Model",
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: AppInput(
                                  controller: year,
                                  title: "Year",
                                  prefixIcon: Icons.date_range_outlined,
                                  hintText: "Year",
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ),


                  ],
                ),
                SizedBox(height: 20,),
                AppInput(
                  controller: location,
                  title: "Car Location",
                  prefixIcon: Icons.title,
                  hintText: "Select your location",
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: AppInput(
                        controller: color,
                        title: "Color",
                        prefixIcon: Icons.color_lens_outlined,
                        hintText: "Car color",
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: AppInput(
                        controller: price,
                        title: "Price",
                        prefixIcon: Icons.attach_money,
                        hintText: "Rent Price",
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap:()=>startWebFilePicker(),
                        child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade200,
                            ),
                            child: _bytesData != null
                                ? Image.memory(_bytesData!, width: 200, height: 200)
                                : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Upload FH1."),
                                SizedBox(height: 5,),
                                Icon(Icons.add, color: Colors.black,)
                              ],
                            )
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: InkWell(
                        onTap:()=>startWebFilePicker(),
                        child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade200,
                            ),
                            child: _bytesData != null
                                ? Image.memory(_bytesData!, width: 200, height: 200)
                                : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Upload Cirtificate of Insurence."),
                                SizedBox(height: 5,),
                                Icon(Icons.add, color: Colors.black,)
                              ],
                            )
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: InkWell(
                        onTap:()=>startWebFilePicker(),
                        child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade200,
                            ),
                            child: _bytesData != null
                                ? Image.memory(_bytesData!, width: 200, height: 200)
                                : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Driver Diclaration"),
                                SizedBox(height: 5,),
                                Icon(Icons.add, color: Colors.black,)
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
                AppButton(
                    onClick: (){
                      AppPopup.appPopup(
                          context: context,
                          title: "You cart added success!",
                          body: "You new car create success. You can check it from Car rent->Manage Car's",
                          dialogType: DialogType.success,
                          onOkBtn: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage(pageIndex: 3,))),
                      );
                    },
                    text: "Add Car",
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




