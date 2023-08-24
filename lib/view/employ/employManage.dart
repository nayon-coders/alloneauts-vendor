import 'dart:convert';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:vendor/view_controller/appButton.dart';
import 'package:vendor/view_controller/appInput.dart';
import 'package:vendor/view_controller/appPoup.dart';
import 'dart:html' as html;
import '../../utility/app_color.dart';
import '../../view_controller/appIconButton.dart';
import '../../view_controller/bigText.dart';

class EmployManagement extends StatefulWidget {
  const EmployManagement({Key? key}) : super(key: key);

  @override
  State<EmployManagement> createState() => _EmployManagementState();
}

class _EmployManagementState extends State<EmployManagement> {

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final pass = TextEditingController();


  final hourly = TextEditingController();
  final monthly = TextEditingController();
  final weekly = TextEditingController();

  Map<String, bool> values = {
    'Manage Vehicles': true,
    'Add Vehicles': true,
    'Rent Request': false,
    'Vehicles Reports': false,
    'Payment Reports': false,
    'Ticket Manage': false,
  };

  Map<String, bool> taxList = {
    'Federal Income Tax': true,
    'State Income Tax': true,
    'Medicare Tax': false,
    'Country Tax': false,
  };

  List<String> employType = [
    "Hourly",
    "Weekly",
    "Monthly"
  ];
  var selectEmployType;



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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BigText(text: "Employ Management"),
              SizedBox(
                width: size.width*.20,
                child: AppButton(
                  onClick: ()=>addEmploy(),
                  text: "Add Employ",
                  bgColor: AppColors.green,
                  width: 100,
                )
              )
            ],
          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width, //to get the width of screen
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
            child: FittedBox(
              child: DataTable(
                dividerThickness:0,
                sortAscending: false,
                columns: const [
                  DataColumn(label: Text(
                      'Profile',
                  )),

                  DataColumn(label: Text(
                      'Employ Name',
                  )),
                  DataColumn(label: Text(
                      'Email',
                  )),
                  DataColumn(label: Text(
                      'Phone',
                  )),
                  DataColumn(label: Text(
                      'Documents',
                  )),
                  DataColumn(label: Text(
                    'Staus',
                  )),
                  DataColumn(label: Text(
                      'Action',
                  )),
                ],
                rows: [
                  for(var i=0;i<5;i++)
                    DataRow(
                        color: MaterialStateColor.resolveWith((states) {
                          return i.isOdd? Colors.grey.shade200 : Colors.white; //make tha magic!
                        }),
                        cells: [
                          DataCell(
                              Image.network("https://newprofilepic.photo-cdn.net//assets/images/article/profile.jpg?4d355bd", height: 50, width: 50,)
                          ),
                          DataCell(Text('Johan Due', style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),)),
                          DataCell(Text('jhona@gmail.com',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                            ),
                          )),
                          DataCell(Text('+1 9840 ******',style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),)),

                          DataCell(Container(
                              padding: EdgeInsets.only(left: 7, right: 7, bottom: 3,top: 3),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Text('Active',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ))),
                          DataCell(Container(
                              padding: EdgeInsets.only(left: 7, right: 7, bottom: 3,top: 3),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Text('View Documnets',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ))),
                          DataCell(
                            Row(
                              children: [
                                SizedBox(width: 5,),
                                AppIconButton(
                                  icon: Icons.edit,
                                  onClick: (){},
                                  bgColor: Colors.amber,
                                ),
                                SizedBox(width: 5,),
                                AppIconButton(
                                  icon: Icons.delete_outline_outlined,
                                  onClick: (){},
                                  bgColor: AppColors.red,
                                ),
                                SizedBox(width: 5,),
                              ],
                            ),

                          ),
                        ]
                    ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  addEmploy() {
    var size = MediaQuery.of(context).size;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content:  StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: size.width*.30,
                color: Colors.grey.shade50,
                child: SingleChildScrollView(
                  child: ListBody(
                    children:  <Widget>[
                      BigText(text: "Create Epmloy"),
                      SizedBox(height: 10,),
                      Text("You can create Employ. You can control the user accessibility.",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Divider(height: 1, color: AppColors.grey,),
                      SizedBox(height: 30,),
                      AppInput(controller: firstName, title: "First Name", hintText: "First Name", prefixIcon: Icons.person,),
                      SizedBox(height: 20,),
                      AppInput(controller: lastName, title: "Last Name", hintText: "Last Name", prefixIcon: Icons.person),
                      SizedBox(height: 20,),
                      AppInput(controller: email, title: "Email", hintText: "jhon@gmail.com", prefixIcon: Icons.email_outlined),
                      SizedBox(height: 20,),
                      AppInput(controller: phone, title: "Phone Number", hintText: "+1 938*******", prefixIcon: Icons.phone_android),
                      SizedBox(height: 20,),
                      AppInput(controller: pass, title: "Password", hintText: "Password", prefixIcon: Icons.key),
                      SizedBox(height: 20,),
                      AppInput(controller: pass, title: "Confirm Password", hintText: "Confirm Password", prefixIcon: Icons.key),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(width: 1, color: AppColors.green.withOpacity(0.3))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Upload Profile",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Icon(Icons.upload_outlined, color: AppColors.green, size: 30,)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(width: 1, color: AppColors.green.withOpacity(0.3))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text("Upload Documents",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Icon(Icons.upload_outlined, color: AppColors.green, size: 30,)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text("Employ Type",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              'Select Employ Role',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: employType
                                .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                                .toList(),
                            value: selectEmployType,
                            onChanged: (String? value) {
                              setState(() {
                                selectEmployType = value;
                              });
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              height: 40,
                              width: 140,
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                          ),
                        ),
                      ),
                      selectEmployType != null ? Column(
                        children: [
                          SizedBox(height: 20,),
                          selectEmployType == "Hourly"
                              ? AppInput(controller: hourly, title: "Hourly Rate", hintText: "12", prefixIcon: Icons.attach_money)
                              : selectEmployType == "Weekly"
                              ? AppInput(controller: weekly, title: "Weekly Rate", hintText: "500", prefixIcon: Icons.attach_money)
                              : selectEmployType == "Monthly"
                              ? AppInput(controller: monthly, title: "Monthly Rate", hintText: "2000", prefixIcon: Icons.attach_money)
                              : SizedBox(height: 20,),
                        ],
                      ) : Center(),
                      SizedBox(height: 20,),
                      Text("Permission",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(height: 10,),
                      SizedBox(
                        height: 50.00*values.length,
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          children: values.keys.map((String key) {
                            return new CheckboxListTile(
                              title: new Text(key,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                              value: values[key],
                              onChanged: (value) {
                                setState(() {
                                  values[key] = value!;
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("Tax",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(height: 10,),
                      SizedBox(
                        height: 50.00*taxList.length,
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          children: taxList.keys.map((String key) {
                            return new CheckboxListTile(
                              title: new Text(key,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              value: taxList[key],
                              onChanged: (value) {
                                setState(() {
                                  taxList[key] = value!;
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 30,),
                      AppButton(onClick: (){
                        AppPopup.appPopup(context: context, title: "Success", body: "Successfully create Employ", dialogType: DialogType.success, onOkBtn: ()=>Navigator.pop(context));
                      }, text: "Create Employ", width: 100),


                    ],
                  ),
                ),
              );
            }
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
