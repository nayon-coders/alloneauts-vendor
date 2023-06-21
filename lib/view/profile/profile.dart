import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:vendor/view_controller/appButton.dart';
import 'package:vendor/view_controller/appInput.dart';

import '../../view_controller/bigText.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final name = TextEditingController();
  final companyName = TextEditingController();
  final mailingAddress = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final website = TextEditingController();


  final yearsBusiness = TextEditingController();
  final brefDescribe = TextEditingController();



  List<int>? idOrDrivingLicense; //index - 1
  List<int>? legaleBusnessName; // index - 2
  List<int>? businessStructure; // index - 3
  List<int>? texIdentificationNumber; //index - 4
  List<int>? buinessLicense; // index - 5


  Uint8List? idOrDrivingLicenseData;
  Uint8List? legaleBusnessNameData;
  Uint8List? businessStructureData;
  Uint8List? texIdentificationNumberData;
  Uint8List? buinessLicenseData;

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
        setState(() {
          if(index == 1){
            idOrDrivingLicenseData = Base64Decoder().convert(reader.result.toString().split(",").last);
            idOrDrivingLicense = idOrDrivingLicenseData;
          }else if(index == 2){
            legaleBusnessNameData = Base64Decoder().convert(reader.result.toString().split(",").last);
            legaleBusnessName = legaleBusnessNameData;
          }else if(index == 3){
            businessStructureData = Base64Decoder().convert(reader.result.toString().split(",").last);
            businessStructure = businessStructureData;
          }else if(index == 4){
            texIdentificationNumberData = Base64Decoder().convert(reader.result.toString().split(",").last);
            texIdentificationNumber = texIdentificationNumberData;
          }else{
            buinessLicenseData = Base64Decoder().convert(reader.result.toString().split(",").last);
            buinessLicense = buinessLicenseData;
          }

        });
      });
      reader.readAsDataUrl(file);
    });
  }

  // Future uploadImage() async {
  //   var url = Uri.parse("API URL HERE...");
  //   var request = http.MultipartRequest("POST", url);
  //   request.files.add(await http.MultipartFile.fromBytes('file', _selectedFile!,
  //       contentType: MediaType('application', 'json'), filename: "Any_name"));
  //
  //   request.send().then((response) {
  //     if (response.statusCode == 200) {
  //       print("File uploaded successfully");
  //     } else {
  //       print('file upload failed');
  //     }
  //   });
  // }



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
                   alignment: Alignment.center,
                   child: Container(
                     decoration: BoxDecoration(
                       color:Colors.white,
                       borderRadius: BorderRadius.circular(100)
                     ),
                     child: IconButton(
                       icon: Icon(Icons.edit, color: Colors.green,),
                       onPressed: (){},
                     ),
                   ),
                 ),

               ],
             ),
           ),
         ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(text: "Contact Information"),
                        SizedBox(height: 10,),
                        AppInput(
                            controller: name,
                            title: "Name",
                            prefixIcon: Icons.person,
                            hintText: "Nayon talukder"
                        ),
                        SizedBox(height: 20,),
                        InkWell(
                          onTap:()=>startWebFilePicker(1),
                          child: Container(
                              height: 200,
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade200,
                              ),
                              child: idOrDrivingLicenseData != null
                                  ? Image.memory(idOrDrivingLicenseData!, width: 200, height: 200)
                                  : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Contact person photo ID or driving license. (JPG, PNG, JPEG ect)."),
                                  SizedBox(height: 5,),
                                  Icon(Icons.add, color: Colors.black,)
                                ],
                              )
                          ),
                        ),
                        SizedBox(height: 20,),
                        AppInput(
                            controller: companyName,
                            title: "Company Name",
                            prefixIcon: Icons.house_siding_rounded,
                            hintText: "Type your Company Name"
                        ),
                        SizedBox(height: 20,),
                        AppInput(
                            controller: mailingAddress,
                            title: "Company Name",
                            prefixIcon: Icons.location_city,
                            hintText: "Type your Mailing address"
                        ),
                        SizedBox(height: 20,),
                        AppInput(
                            controller: email,
                            title: "Email",
                            readOnly: true,
                            prefixIcon: Icons.email_outlined,
                            hintText: "alloneautos@gmail.com"
                        ),
                        SizedBox(height: 20,),
                        AppInput(
                            controller: email,
                            title: "Phone Number",
                            readOnly: true,
                            prefixIcon: Icons.phone_android,
                            hintText: "+928495893439"
                        ),
                        SizedBox(height: 20,),
                      ],
                    ),
                  ),

                  SizedBox(width: 30,),

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(text: "Company Information"),
                        SizedBox(height: 40,),

                        Row(
                         children: [
                           Expanded(
                             child: InkWell(
                               onTap:()=>startWebFilePicker(2),
                               child: Container(
                                   height: 200,
                                   width: size.width,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),
                                     color: Colors.grey.shade200,
                                   ),
                                   child: legaleBusnessNameData != null
                                       ? Image.memory(legaleBusnessNameData!, width: 200, height: 200)
                                       : Padding(
                                         padding: const EdgeInsets.all(20.0),
                                         child: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: [
                                         Center(child: Text("Legal business name (store front picture)(JPG, PNG, JPEG ect).")),
                                         SizedBox(height: 10,),
                                         Icon(Icons.add, color: Colors.black,)
                                     ],
                                   ),
                                       )
                               ),
                             ),
                           ),

                           SizedBox(width: 10,),

                           Expanded(
                             child: InkWell(
                               onTap:()=>startWebFilePicker(3),
                               child: Container(
                                   height: 200,
                                   width: size.width,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),
                                     color: Colors.grey.shade200,
                                   ),
                                   child: businessStructureData != null
                                       ? Image.memory(businessStructureData!, width: 200, height: 200)
                                       : Padding(
                                     padding: const EdgeInsets.all(20.0),
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                       children: [
                                         Center(child: Text("Business structure (e.g., sole proprietorship, partnership, corporation)(JPG, PNG, JPEG ect).")),
                                         SizedBox(height: 10,),
                                         Icon(Icons.add, color: Colors.black,)
                                       ],
                                     ),
                                   )
                               ),
                             ),
                           ),
                         ],
                       ),

                        SizedBox(height: 20,),

                        Row(
                          children: [
                            Expanded(
                              child:InkWell(
                                onTap:()=>startWebFilePicker(4),
                                child: Container(
                                    height: 200,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade200,
                                    ),
                                    child: texIdentificationNumberData != null
                                        ? Image.memory(texIdentificationNumberData!, width: 200, height: 200)
                                        : Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Center(child: Text("Tax identification number (TIN)(JPG, PNG, JPEG ect).")),
                                          SizedBox(height: 10,),
                                          Icon(Icons.add, color: Colors.black,)
                                        ],
                                      ),
                                    )
                                ),
                              ) ,
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child:    InkWell(
                                onTap:()=>startWebFilePicker(5),
                                child: Container(
                                    height: 200,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade200,
                                    ),
                                    child: buinessLicenseData != null
                                        ? Image.memory(buinessLicenseData!, width: 200, height: 200)
                                        : Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Center(child: Text("Business registration/license number (if applicable) (JPG, PNG, JPEG ect).")),
                                          SizedBox(height: 10,),
                                          Icon(Icons.add, color: Colors.black,)
                                        ],
                                      ),
                                    )
                                ),
                              ),
                            )
                          ],
                        ),

                        SizedBox(height: 20,),
                        AppInput(
                            controller: yearsBusiness,
                            title: "Years in business (number input)",
                            prefixIcon: Icons.calendar_month,
                            hintText: "Years in business (number input)"
                        ),
                        SizedBox(height: 20,),
                        AppInput(
                          maxLine: 4,
                            controller: yearsBusiness,
                            title: "Brief description of the company's products/services",
                            hintText: "Brief description of the company's products/services"
                        ),

                      ],
                    ),
                  ),
                ],
              ),

                SizedBox(height: 30,),
                Align(
                  alignment: Alignment.center,
                  child: AppButton(
                      onClick: (){},
                      text: "Edit Profile",
                      width: 200
                  ),
                ),
                SizedBox(height: 30,),
              ],
            ),
          )

        ],
      ),
    );
  }
}
