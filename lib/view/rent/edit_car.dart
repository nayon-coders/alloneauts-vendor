import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/app_config.dart';
import 'package:vendor/controller/rentCarController/rentCarController.dart';
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
import '../../view_controller/appNetworkImage.dart';
import '../../view_controller/bigText.dart';

class EditCar extends StatefulWidget {
  final dynamic carInfo;
  final dynamic id;
  const EditCar({Key? key, required this.carInfo, this.id}) : super(key: key);

  @override
  State<EditCar> createState() => _EditCarState();
}

class _EditCarState extends State<EditCar> {

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
    var url = Uri.parse(AppConfig.UPDATE_RENT_CAR);
    var request = http.MultipartRequest("POST", url);
    request.headers.addAll(header);
    if(_carImage != null ){
      request.files.add(await http.MultipartFile.fromBytes('car_images', _carImage!.toList()!,
          contentType: MediaType('application', 'json'), filename: "car_image"));
    }


    if(_fh1Image != null ){
      request.files.add(await http.MultipartFile.fromBytes('fh', _fh1Image!,
          contentType: MediaType('application', 'json'), filename: "fh1_image"));
    }

    if(_insuranceImage != null){
      request.files.add(await http.MultipartFile.fromBytes('insurance', _insuranceImage!,
          contentType: MediaType('application', 'json'), filename: "insurance"));
    }
    if(_driverLicenceImage != null){
      request.files.add(await http.MultipartFile.fromBytes('diclaration', _driverLicenceImage!,
          contentType: MediaType('application', 'json'), filename: "diclaration"));
    }


    request.fields.addAll(carInfo);
    print("Car info ==== ${carInfo}");

    request.send().then((response) {
      if (response.statusCode == 200) {
        print("File uploaded successfully");
        AppPopup.appPopup(
          context: context,
          title: "Your Vehicle is updated success!",
          body: "Your Vehicle is updated successfully. You can check it from Vehicle rent->Manage Vehicle's",
          dialogType: DialogType.success,
          onOkBtn: ()=>Get.to(MainPage(pageIndex: 3,))
        );
      } else {
        print('file upload failed');
        AppPopup.appPopup(
          context: context,
          title: "Something went wrong !",
          body: "While you updating your Vehicles, its make some problem. Try again or contact with support in details.",
          dialogType: DialogType.error,
          onOkBtn: (){},
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
  var lat, lng;

  _getSingleCar()async{
    print("widget.carInfo!.details! ${widget.carInfo!.details!.mileage}");
    carName.text = widget.carInfo!.details!.name.toString();
    platNo.text = widget.carInfo!.details!.plateNo.toString();
    make.text = widget.carInfo!.details!.vmake.toString();
    color.text = widget.carInfo!.details!.vcolor.toString();
    year.text = widget.carInfo!.details!.vyear.toString();
    model.text = widget.carInfo!.details!.vmodel.toString();
    location.text = widget.carInfo!.details!.location.toString();
    email.text = widget.carInfo!.details!.email.toString();
    price.text = widget.carInfo!.details!.price.toString();
    trim.text = widget.carInfo!.details!.vtrim.toString();
    lat = widget.carInfo!.details!.latitude.toString();
    lng = widget.carInfo!.details!.longitude.toString();
    maileg.text = widget.carInfo!.details!.mileage.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSingleCar();
  }

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
                const BigText(text: "Update your car."),
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
                                  : AppNetworkImage(
                                url: "${AppConfig.DOMAIN}/${widget.carInfo.images[0]}",
                                width: 200, height: 200,
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
                                  : AppNetworkImage(
                                url: "${AppConfig.DOMAIN}/${widget.carInfo.details!.fh![0]}",
                                width: 200, height: 200,
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
                                  :  AppNetworkImage(
                                url: "${AppConfig.DOMAIN}/${widget.carInfo.details!.insurance![0]}",
                                width: 200, height: 200,
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
                                  : AppNetworkImage(
                                url: "${AppConfig.DOMAIN}/${widget.carInfo.details!.diclaration![0]}",
                                width: 200, height: 200,
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







// import 'dart:async';
//
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:vendor/app_config.dart';
// import 'package:vendor/controller/rentCarController/rentCarController.dart';
// import 'package:vendor/model/carModel/singleCarModel.dart';
// import 'package:vendor/utility/app_color.dart';
// import 'package:file_picker/file_picker.dart';
// import 'dart:typed_data';
// import 'dart:html' as html;
// import 'package:http_parser/http_parser.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:vendor/view/main_pages.dart';
// import 'package:vendor/view_controller/appButton.dart';
// import 'package:vendor/view_controller/appPoup.dart';
// import 'package:vendor/view_controller/dataError.dart';
// import 'package:vendor/view_controller/loadingWidget.dart';
//
// import '../../model/rentModels/rentCarListModel.dart';
// import '../../view_controller/appInput.dart';
// import '../../view_controller/appNetworkImage.dart';
// import '../../view_controller/bigText.dart';
// class EditCar extends StatefulWidget {
//   final dynamic carInfo;
//   final dynamic id;
//   const EditCar({Key? key, required this.carInfo, this.id}) : super(key: key);
//
//   @override
//   State<EditCar> createState() => _EditCarState();
// }
//
// class _EditCarState extends State<EditCar> {
//
//   List<int>? _selectedFile;
//   Uint8List? _carImageBytesData;
//   Uint8List? _fhImageBytesData;
//   Uint8List? _incuranceImageBytesData;
//   Uint8List? _drivingLicenceImageBytesData;
//
//   startWebFilePicker(car) async {
//     html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
//     uploadInput.multiple = true;
//     uploadInput.draggable = true;
//     uploadInput.click();
//     uploadInput.onChange.listen((event) {
//       final files = uploadInput.files;
//       print("this is files === $files");
//       final file = files![0];
//       final reader = html.FileReader();
//
//       reader.onLoadEnd.listen((event) {
//         if(car == 0){
//           setState(() {
//             _carImageBytesData =
//                 Base64Decoder().convert(reader.result.toString().split(",").last);
//             _selectedFile = _carImageBytesData;
//           });
//         }
//         if(car == 1){
//           setState(() {
//             _incuranceImageBytesData =
//                 Base64Decoder().convert(reader.result.toString().split(",").last);
//             _selectedFile = _carImageBytesData;
//           });
//         }
//         if(car == 2){
//           setState(() {
//             _fhImageBytesData =
//                 Base64Decoder().convert(reader.result.toString().split(",").last);
//             _selectedFile = _carImageBytesData;
//           });
//         }
//         if(car == 3){
//           setState(() {
//             _drivingLicenceImageBytesData =
//                 Base64Decoder().convert(reader.result.toString().split(",").last);
//             _selectedFile = _carImageBytesData;
//           });
//         }
//
//       });
//       reader.readAsDataUrl(file);
//     });
//   }
//
//   Future uploadImage() async {
//     var url = Uri.parse("API URL HERE...");
//     var request = http.MultipartRequest("POST", url);
//     request.files.add(await http.MultipartFile.fromBytes('file', _selectedFile!,
//         contentType: MediaType('application', 'json'), filename: "Any_name"));
//
//     request.send().then((response) {
//       if (response.statusCode == 200) {
//         print("File uploaded successfully");
//       } else {
//         print('file upload failed');
//       }
//     });
//   }
//
//   final carName = TextEditingController();
//   final platNo = TextEditingController();
//   final make = TextEditingController();
//   final model = TextEditingController();
//   final year = TextEditingController();
//   final location = TextEditingController();
//   final price = TextEditingController();
//   final color = TextEditingController();
//   final vtrim = TextEditingController();
//   final phone = TextEditingController();
//   final email = TextEditingController();
//   final maileg = TextEditingController();
//   var lat, lng;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getUserInfo();
//     print("car info ==== ${widget.carInfo.details}");
//     //data initial
//     _getSingleCar();
//   }
//
//   bool isLoading = false;
//    _getSingleCar()async{
//      print("widget.carInfo!.details! ${widget.carInfo!.details!.mileage}");
//     carName.text = widget.carInfo!.details!.name.toString();
//     platNo.text = widget.carInfo!.details!.plateNo.toString();
//     make.text = widget.carInfo!.details!.vmake.toString();
//     color.text = widget.carInfo!.details!.vcolor.toString();
//     year.text = widget.carInfo!.details!.vyear.toString();
//     model.text = widget.carInfo!.details!.vmodel.toString();
//     location.text = widget.carInfo!.details!.location.toString();
//     email.text = widget.carInfo!.details!.email.toString();
//     price.text = widget.carInfo!.details!.price.toString();
//     vtrim.text = widget.carInfo!.details!.vtrim.toString();
//     lat.text = widget.carInfo!.details!.latitude.toString();
//     lng.text = widget.carInfo!.details!.longitude.toString();
//     maileg.text = widget.carInfo!.details!.mileage.toString();
//   }
//
//   var userEmail, userPhone;
//   getUserInfo()async{
//     SharedPreferences _pref = await SharedPreferences.getInstance();
//     setState(() {
//       email.text = _pref.getString("email").toString();
//       phone.text = _pref.getString("phone").toString();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return   Container(
//         height: size.height,
//         margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
//         child: ListView(
//           children: [
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: ()=>Navigator.pop(context),
//                   icon: Icon(Icons.arrow_back),
//                 ),
//                 SizedBox(width: 10,),
//                 BigText(text: "Edit #${platNo.text} Car"),
//               ],
//             ),
//             SizedBox(height: 20,),
//             Container(
//               padding: EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                   color: AppColors.white,
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.grey.shade300,
//                         spreadRadius: 2, blurRadius: 3,
//                         offset: Offset(0,2)
//                     )
//                   ]
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       SizedBox(
//                         width: 300,
//                         child: InkWell(
//                           onTap:()=>startWebFilePicker(0),
//                           child: Container(
//                               height: 200,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.grey.shade300,
//                                 border: Border.all(width: 1, color: AppColors.menuColor)
//                               ),
//                               child: _carImageBytesData != null
//                                   ? Image.memory(_carImageBytesData!, width: 200, height: 200)
//                                   : AppNetworkImage(
//                                 url: "${AppConfig.DOMAIN}/${widget.carInfo.images[0]}",
//                                 width: 200, height: 200,
//                               )
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 20,),
//                       Expanded(
//                           child: Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: AppInput(
//                                       controller: make,
//                                       title: "Make",
//                                       prefixIcon: Icons.car_repair_rounded,
//                                       hintText: "Make",
//                                     ),
//                                   ),
//                                   SizedBox(width: 10,),
//                                   Expanded(
//                                     child: AppInput(
//                                       controller: model,
//                                       title: "Model",
//                                       prefixIcon: Icons.model_training,
//                                       hintText: "Model",
//                                     ),
//                                   ),
//                                   SizedBox(width: 10,),
//                                   Expanded(
//                                     child: AppInput(
//                                       controller: year,
//                                       title: "Year",
//                                       prefixIcon: Icons.date_range_outlined,
//                                       hintText: "Year",
//                                     ),
//                                   ),
//                                   SizedBox(width: 10,),
//                                   Expanded(
//                                     child: AppInput(
//                                       controller: vtrim,
//                                       title: "Trim",
//                                       prefixIcon: Icons.car_crash_sharp,
//                                       hintText: "Trim",
//                                     ),
//                                   ),
//
//                                 ],
//                               ),
//                               SizedBox(height: 20,),
//                               AppInput(
//                                 controller: location,
//                                 title: "Vehicle Location",
//                                 prefixIcon: Icons.location_on_outlined,
//                                 hintText: "Select your location",
//                               ),
//                               SizedBox(height: 20,),
//                             ],
//                           )
//                       ),
//
//
//                     ],
//                   ),
//
//                   SizedBox(height: 20,),
//                   Row(
//                     children: [
//                       const SizedBox(width: 10,),
//                       Expanded(
//                         child: AppInput(
//                           controller: platNo,
//                           title: "Plate No",
//                           hintText: "TC****",
//                         ),
//                       ),
//                       SizedBox(width: 20,),
//                       Expanded(
//                         child: AppInput(
//                           controller: color,
//                           title: "Color",
//                           hintText: "Vehicle color",
//                         ),
//                       ),
//                       const SizedBox(width: 10,),
//                       Expanded(
//                         child: AppInput(
//                           controller: price,
//                           title: "Price",
//                           hintText: "Rent Price",
//                         ),
//                       ),
//                       const SizedBox(width: 10,),
//                       Expanded(
//                         child: AppInput(
//                           controller: maileg,
//                           title: "Mileage",
//                           hintText: "Mileage",
//                         ),
//                       ),
//
//                     ],
//                   ),
//                   SizedBox(height: 20,),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: InkWell(
//                           onTap:()=>startWebFilePicker(2),
//                           child: Container(
//                               height: 200,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.grey.shade200,
//                               ),
//                               child: _fhImageBytesData != null
//                                   ? Image.memory(_fhImageBytesData!, width: 200, height: 200)
//                                   : AppNetworkImage(
//                                 url: "${AppConfig.DOMAIN}/${widget.carInfo.images[0]}",
//                                 width: 200, height: 200,
//                               )
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 20,),
//                       Expanded(
//                         child: InkWell(
//                           onTap:()=>startWebFilePicker(1),
//                           child: Container(
//                               height: 200,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.grey.shade200,
//                               ),
//                               child: _incuranceImageBytesData != null
//                                   ? Image.memory(_carImageBytesData!, width: 200, height: 200)
//                                   : AppNetworkImage(
//                                 url: "${AppConfig.DOMAIN}/${widget.carInfo.images[0]}",
//                                 width: 200, height: 200,
//                               )
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 20,),
//                       Expanded(
//                         child: InkWell(
//                           onTap:()=>startWebFilePicker(3),
//                           child: Container(
//                               height: 200,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.grey.shade200,
//                               ),
//                               child: _drivingLicenceImageBytesData != null
//                                   ? Image.memory(_drivingLicenceImageBytesData!, width: 200, height: 200)
//                                   : AppNetworkImage(
//                                 url: "${AppConfig.DOMAIN}/${widget.carInfo.images[0]}",
//                                 width: 200, height: 200,
//                               )
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 20,),
//                     ],
//                   ),
//                   SizedBox(height: 20,),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: AppInput(
//                           controller: email,
//                           title: "Email",
//                           prefixIcon: Icons.email_outlined,
//                           hintText: "nayon.coders@gmail.com",
//                         ),
//                       ),
//                       SizedBox(width: 10,),
//                       Expanded(
//                         child: AppInput(
//                           controller: phone,
//                           title: "Number",
//                           prefixIcon: Icons.phone_android,
//                           hintText: "+8801814569747",
//                         ),
//                       ),
//
//                     ],
//                   ),
//                   SizedBox(height: 30,),
//                   AppButton(
//                       onClick: ()async{
//                         // AppPopup.appPopup(
//                         //   context: context,
//                         //   title: "You cart added success!",
//                         //   body: "You new car create success. You can check it from Car rent->Manage Car's",
//                         //   dialogType: DialogType.success,
//                         //   onOkBtn: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage(pageIndex: 3,))),
//                         // );
//                         var singleCarEditInfo = {
//                           "id" : widget.carInfo.id.toString(),
//                           "name" : carName.text.toString(),
//                           "plate_no":platNo.text.toString(),
//                           "vmake" : make.text.toString(),
//                           "vmodel" : model.text.toString(),
//                           "vyear" : year.text.toString(),
//                           "color" : color.text.toString(),
//                           "vcolor" : color.text.toString(),
//                           "vtrim" : vtrim.text.toString(),
//                           "location" : location.text.toString(),
//                           "location" : location.text.toString(),
//                           "latitude" : lat.toString(),
//                           "longitude" : lng.toString(),
//                           "email" : email.text.toString(),
//                           "contact" : phone.text.toString(),
//                           "contact" : phone.text.toString(),
//                           "mileage" : "0",
//                         };
//                         var res = await RentCarController.editRentCar(singleCarEditInfo);
//                         print("eddit car response ==== ${res.body}");
//                         print("eddit car response ==== ${res.statusCode}");
//                         if(res.statusCode == 200){
//                           AppPopup.appPopup(
//                             context: context,
//                             title: "You Vehicles is updated!",
//                             body: "You Vehicles updated success. You can check it from Car rent->Manage Car's",
//                             dialogType: DialogType.success,
//                             onOkBtn: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage(pageIndex: 2,))),
//                           );
//                         }else{
//                           AppPopup.appPopup(
//                             context: context,
//                             title: "Something went Wrong.",
//                             body: "You Vehicles updated Unsuccessful. You check you information again or You have some server problem.",
//                             dialogType: DialogType.error,
//                             onOkBtn: (){},
//                           );
//                         }
//
//                       },
//                       text: "Add Car",
//                       width: size.width*.40
//                   )
//
//                 ],
//               ),
//             ),
//             SizedBox(height: 50,),
//           ],
//         )
//     );
//   }
//
//   //image selected
//   Future<void> pickImage() async {
//     print("fileName click");
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//       allowMultiple: true,
//     );
//
//     if (result != null) {
//       final fileBytes = result.files.first.bytes;
//       final fileName = result.files.first.name;
//       print("fileBytes == $fileBytes");
//       print("fileName == $fileName");
//
//       // Handle the selected image file (fileBytes)
//       // and the file name (fileName) as per your requirements
//     } else {
//       // User canceled the file picking
//     }
//   }
//
//
//
// }
//
//
//
