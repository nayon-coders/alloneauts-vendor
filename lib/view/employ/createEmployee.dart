import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:vendor/utility/app_color.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_config.dart';
import '../../controller/EmployeeController/employeeController.dart';
import '../../utility/app_color.dart';
import '../../view_controller/appButton.dart';
import '../../view_controller/appInput.dart';
import '../../view_controller/appPoup.dart';
import '../../view_controller/bigText.dart';

class CreateEmployee extends StatefulWidget {
  const CreateEmployee({Key? key}) : super(key: key);

  @override
  State<CreateEmployee> createState() => _CreateEmployeeState();
}

class _CreateEmployeeState extends State<CreateEmployee> {



  final hourly = TextEditingController();
  final monthly = TextEditingController();
  final weekly = TextEditingController();

  Map<String, bool> employeePermission = {
    'Manage Vehicles': true,
    'Add Vehicles': true,
    'Rent Request': false,
    'Vehicles Reports': false,
    'Payment Reports': false,
    'Ticket Manage': false,
  };

  List<String> gender=["Male","Female","Other"];
  String? select;

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

  bool genderCheck = false;


  List<int>? _uploadDocumentsList;
  List<int>? _uploadProfileList;
  Uint8List? _uploadDocuments;
  Uint8List? _uploadProfile;

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
        if(index == 0){
          setState(() {
            _uploadProfile =
                Base64Decoder().convert(reader.result.toString().split(",").last);
            _uploadDocumentsList = _uploadProfile;
          });
        }
        if( index == 1){
          setState(() {
            _uploadDocuments =
                Base64Decoder().convert(reader.result.toString().split(",").last);
            _uploadDocumentsList = _uploadDocuments;
          });
        }

      });
      reader.readAsDataUrl(file);
    });
  }



  final first_name = TextEditingController();
  final last_name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirm_password = TextEditingController();
  final document = TextEditingController();
  final street_address = TextEditingController();
  final apartment = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final zipcode = TextEditingController();
  final home_phone = TextEditingController();
  final call_phone = TextEditingController();
  final social_security_number = TextEditingController();
  final birth_date = TextEditingController();
  final marital_status = TextEditingController();
  final spouseHas = TextEditingController();
  final spouseName = TextEditingController();
  final spouseNumber = TextEditingController();
  final emergencyFirstName = TextEditingController();
  final emergencyLastName = TextEditingController();
  final emergencyNumber = TextEditingController();
  final start_date = TextEditingController();
  var avatar;


  bool isLoading = false;
  Future uploadImage(employeeInfo) async {
    setState(() {
      isLoading = true;
    });
    
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    var header = {
      "Accept" : "Application/json",
      "Authorization" : "Bearer $token",
      "Accept" : "application/json"
    };
    print("_uploadProfileList === $_uploadProfileList");
    print("_uploadProfileList === $_uploadDocumentsList");
    var url = Uri.parse(AppConfig.CREATE_EMPLOYEE_PROFILE);
    var request = http.MultipartRequest("POST", url);
    request.headers.addAll(header);
    if(_uploadProfileList != null){
      request.files.add(await http.MultipartFile.fromBytes('avatar', _uploadProfileList!.toList(),
          contentType: MediaType('application', 'json'), filename: "profile"));

    }
    if(_uploadDocumentsList != null){
      request.files.add(await http.MultipartFile.fromBytes('document', _uploadDocumentsList!.toList(),
          contentType: MediaType('application', 'json'), filename: "uploadDocumentsList"));
    }



    print("Car info ==== ${employeeInfo}");

    request.fields.addAll(employeeInfo);

    request.send().then((response) {
      print("response. === ${response.stream.toList()}");
      print("response. === ${response.statusCode}");
      if (response.statusCode == 200) {
        print("File uploaded successfully");
        AppPopup.appPopup(
          context: context,
          title: "You Employee added success!",
          body: "You new Employee create success. You can check it from Vehicle rent->Manage Vehicle's",
          dialogType: DialogType.success,
          onOkBtn: (){},
        );
      } else {
        print('file upload failed');
        AppPopup.appPopup(
          context: context,
          title: "Something went wrong !",
          body: "You new Employee create success. You can check it from Vehicle rent->Manage Vehicle's",
          dialogType: DialogType.error,
          onOkBtn: (){}
        );
      }
      setState(() {
        isLoading = false;
      });
    });
  }


  // void createEmploye() async{
  //   var res = await EmployeeController.createNewEmployee(
  //       first_name: first_name.text,
  //       last_name: last_name.text,
  //       email: email.text,
  //       phone: phone.text,
  //       password: password.text,
  //       confirm_password: confirm_password.text,
  //       avatar: avatar,
  //       document: document.text,
  //       street_address: street_address.text,
  //       apartment: apartment.text,
  //       city: city.text,
  //       state: state.text,
  //       zipcode: zipcode.text,
  //       home_phone: home_phone.text,
  //       call_phone: call_phone.text,
  //       social_security_number: social_security_number.text,
  //       birth_date: birth_date.text,
  //       marital_status: marital_status.text,
  //       spouseHas: spouseHas.text,
  //       spouseName: spouseName.text,
  //       spouseNumber: spouseNumber.text,
  //       emergencyFirstName: emergencyFirstName.text,
  //       emergencyLastName: emergencyLastName.text,
  //       emergencyNumber: emergencyNumber.text,
  //       taxFederalIncome: taxList.values.elementAt(0),
  //       taxStateIncome: taxList.values.elementAt(1),
  //       taxCountryIncome: taxList.values.elementAt(2),
  //       taxMedicareIncome: taxList.values.elementAt(3),
  //       employee_type: selectEmployType,
  //       start_date: start_date.text,
  //       permissionManageVehicle: employeePermission.values.elementAt(0),
  //       permissionAddVehicle: employeePermission.values.elementAt(1),
  //       permissionRentRequest: employeePermission.values.elementAt(2),
  //       permissionVehicleReport: employeePermission.values.elementAt(3),
  //       permissionPaymentReport: employeePermission.values.elementAt(4),
  //       permissionTicketManagement: employeePermission.values.elementAt(5)
  //   );
  //
  //   print("this is data === ${res.body}");
  // }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      color: Colors.white,
      padding: EdgeInsets.only(left: 50, right: 50, bottom: 40),
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: ListView(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: ()=>Navigator.pop(context),
                icon: Icon(Icons.arrow_back, color: Colors.black,),
              ),
              const BigText(text: "Create Employee"),
            ],
          ),
          SizedBox(height: 10,),
          const Text("You can create Employee. You can control the user accessibility.",
            style: TextStyle(
              fontSize: 10,
            ),
          ),
          SizedBox(height: 30,),
          Text("Personal Information",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 20,),
          AppInput(controller: first_name, title: "First Name", hintText: "First Name", prefixIcon: Icons.person,),
          SizedBox(height: 20,),
          AppInput(controller: last_name, title: "Last Name", hintText: "Last Name", prefixIcon: Icons.person),

          SizedBox(height: 20,),
          Text("Gender",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
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
                  'Select Gender',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: gender
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
                value: select,
                onChanged: (String? value) {
                  setState(() {
                    select = value;
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
          SizedBox(height: 20,),
          AppInput(controller: email, title: "Email", hintText: "jhon@gmail.com", prefixIcon: Icons.email_outlined),
          SizedBox(height: 20,),
          AppInput(controller: phone, title: "Phone Number", hintText: "+1 938*******", prefixIcon: Icons.phone_android),
          SizedBox(height: 20,),
          AppInput(controller: password, title: "Password", hintText: "Password", prefixIcon: Icons.key),
          SizedBox(height: 20,),
          AppInput(controller: confirm_password, title: "Confirm Password", hintText: "Confirm Password", prefixIcon: Icons.key),
          SizedBox(height: 20,),
          Divider(height: 1, color: AppColors.grey,),
          SizedBox(height: 10,),
          Text("Upload Documents",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: ()=>startWebFilePicker(0),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 1, color: AppColors.green.withOpacity(0.3))
                    ),
                    child: _uploadProfile != null
                        ? Image.memory(_uploadProfile!, width: 200, height: 200)
                        : Column(
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
              ),
              SizedBox(width: 10,),
              Expanded(
                child: InkWell(
                  onTap: ()=>startWebFilePicker(1),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 1, color: AppColors.green.withOpacity(0.3))
                    ),
                    child:_uploadDocuments != null
                        ? Image.memory(_uploadDocuments!, width: 200, height: 200)
                        : Column(
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
          Text("Job Information",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
          ),
          SizedBox(height: 10,),
          AppInput(controller: start_date, title: "Start Date", hintText: "Start Date", prefixIcon: Icons.calendar_month),
          SizedBox(height: 20,),

          Text("Permisson",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
          ),
          SizedBox(height: 10,),
          SizedBox(
            height: 50.00*employeePermission.length,
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: employeePermission.keys.map((String key) {
                return new CheckboxListTile(
                  title: new Text(key,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  value: employeePermission[key],
                  onChanged: (value) {
                    setState(() {
                      employeePermission[key] = value!;
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
          SizedBox(height: 20,),
          Text("Adddress",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
          ),
          SizedBox(height: 10,),
          AppInput(controller: street_address, title: "Street Address:", hintText: "First Name", prefixIcon: Icons.apartment),
          SizedBox(height: 20,),
          AppInput(controller: apartment, title: "Apartment: ", hintText: "Apartment", prefixIcon: Icons.apartment),
          SizedBox(height: 20,),
          AppInput(controller: city, title: "City", hintText: "City", prefixIcon: Icons.apartment),
          SizedBox(height: 20,),
          AppInput(controller: state, title: "State", hintText: "State", prefixIcon: Icons.apartment),
          SizedBox(height: 20,),
          AppInput(controller: zipcode, title: "ZIP COde", hintText: "ZIP Code", prefixIcon: Icons.apartment),
          SizedBox(height: 20,),
          AppInput(controller: home_phone, title: "Home Phone", hintText: "Home Phone", prefixIcon: Icons.phone),
          SizedBox(height: 20,),
          AppInput(controller: call_phone, title: "Call Phone", hintText: "Call Phone", prefixIcon: Icons.apartment),
          SizedBox(height: 20,),
          AppInput(controller: social_security_number, title: "Social Security number", hintText: "Social Security Number", prefixIcon: Icons.keyboard),
          SizedBox(height: 20,),
          AppInput(controller: birth_date, title: "Birth Date", hintText: "Birth Date", prefixIcon: Icons.calendar_month),
          SizedBox(height: 20,),
          AppInput(controller: marital_status, title: "Marital Status", hintText: "Marital Status", prefixIcon: Icons.man_rounded),
          SizedBox(height: 20,),
          AppInput(controller: spouseHas, title: "Spouse's", hintText: "Spouse's", prefixIcon: Icons.person),
          SizedBox(height: 20,),
          AppInput(controller: spouseName, title: "Spouse's number", hintText: "Spouse's number", prefixIcon: Icons.phone),
          SizedBox(height: 20,),
          AppInput(controller: spouseNumber, title: "Spouse's name", hintText: "Spouse's Name", prefixIcon: Icons.apartment),

          SizedBox(height: 20,),
          Text("Emergency Contact Information",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
          ),
          SizedBox(height: 10,),
          AppInput(controller: emergencyFirstName, title: "First Name:", hintText: "First Name", prefixIcon: Icons.person),
          SizedBox(height: 20,),
          AppInput(controller: emergencyLastName, title: "Last Name:", hintText: "Last Name", prefixIcon: Icons.person),
          SizedBox(height: 20,),
          AppInput(controller: emergencyNumber, title: "Phone Number", hintText: "+1*** *** ** ", prefixIcon: Icons.phone_android),


          SizedBox(height: 30,),
          AppButton(onClick: (){
    Map<String, String> employeeInfo = {
              "first_name" : first_name.text,
              "last_name" : last_name.text,
              "email" : email.text,
              "phone" : phone.text,
              "password" : password.text,
              "confirm_password" : confirm_password.text,
              "street_address" : street_address.text,
              "city" : city.text,
              "state" : state.text,
              "zipcode" : zipcode.text,
              "home_phone" : home_phone.text,
              "call_phone" : call_phone.text,
              "social_security_number" : social_security_number.text,
              "birth_date" : birth_date.text,
              "marital_status" : marital_status.text,
              "spouse[has]" : spouseHas.text,
              "spouse[has]" : spouseHas.text,
              "spouse[name]" : spouseName.text,
              "spouse[number]" : spouseNumber.text,
              "emergency[firstname]" : emergencyFirstName.text,
              "emergency[lastname]" : emergencyLastName.text,
              "emergency[phone]" : emergencyNumber.text,
              "tax[federal_income]" : taxList.values.elementAt(0).toString(),
              "tax[state_income]" : taxList.values.elementAt(1).toString(),
              "tax[medicare_tax]" : taxList.values.elementAt(2).toString(),
              "tax[country]" : taxList.values.elementAt(3).toString(),
              "employee_type" : selectEmployType.toString(),
              "start_date" : start_date.text,
              "permission[manage_vehicle]" : employeePermission.values.elementAt(0).toString(),
              "permission[add_vehicle]" :  employeePermission.values.elementAt(1).toString(),
              "permission[rent_request]" :  employeePermission.values.elementAt(2).toString(),
              "permission[vehicle_reports]" :  employeePermission.values.elementAt(3).toString(),
              "permission[payment_report]" :  employeePermission.values.elementAt(4).toString(),
              "permission[ticket_manage]" :  employeePermission.values.elementAt(5).toString(),
            };
            print("this is $employeeInfo");
            uploadImage(employeeInfo);
            //AppPopup.appPopup(context: context, title: "Success", body: "Successfully create Employ", dialogType: DialogType.success, onOkBtn: ()=>Navigator.pop(context));
          }, text: "Create Employee", width: 100),

        ],
      ),
    );
  }

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: AppColors.green,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value){
            setState(() {
              print(value);
              select=value;
            });
          },
        ),
        Text(title)
      ],
    );
  }

}
