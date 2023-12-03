import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/app_config.dart';

import '../../model/employeeModel/employeeModel.dart';

class EmployeeController{

  static Future createNewEmployee({
  required String first_name,
  required String last_name,
  required String email,
  required String phone,
  required String password,
  required String confirm_password,
  required String avatar,
  required String document,
  required String street_address,
  required String apartment,
  required String city,
  required String state,
  required String zipcode,
  required String home_phone,
  required String call_phone,
  required String social_security_number,
  required String birth_date,
  required String marital_status,
  required String spouseHas,
  required String spouseName,
  required String spouseNumber,
  required String emergencyFirstName,
  required String emergencyLastName,
  required String emergencyNumber,
  required bool taxFederalIncome,
  required bool taxStateIncome,
  required bool taxCountryIncome,
  required bool taxMedicareIncome,
  required String employee_type,
  required String start_date,
  required bool permissionManageVehicle,
  required bool permissionAddVehicle,
  required bool permissionRentRequest,
  required bool permissionVehicleReport,
  required bool permissionPaymentReport,
  required bool permissionTicketManagement,
})async{
    //token
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    print("token === ${token}");
    var res = await http.post(Uri.parse(AppConfig.CREATE_EMPLOYEE_PROFILE),
      headers: {
        "Authorization" : "Bearer $token"
      },
      body: {
        "first_name" : first_name,
        "last_name" : last_name,
        "email" : email,
        "phone" : phone,
        "password" : password,
        "confirm_password" : confirm_password,
        "avatar" : avatar,
        "document" : document,
        "street_address" : street_address,
        "city" : city,
        "state" : state,
        "zipcode" : zipcode,
        "home_phone" : home_phone,
        "call_phone" : call_phone,
        "social_security_number" : social_security_number,
        "birth_date" : birth_date,
        "marital_status" : marital_status,
        "spouse[has]" : spouseHas,
        "spouse[has]" : spouseHas,
        "spouse[name]" : spouseName,
        "spouse[number]" : spouseNumber,
        "emergency[firstname]" : emergencyFirstName,
        "emergency[lastname]" : emergencyLastName,
        "emergency[phone]" : emergencyNumber,
        "tax[federal_income]" : taxFederalIncome,
        "tax[state_income]" : taxStateIncome,
        "tax[medicare_tax]" : taxMedicareIncome,
        "tax[country]" : taxCountryIncome,
        "employee_type" : employee_type,
        "employee_type" : employee_type,
        "start_date" : start_date,
        "start_date" : start_date,
        "permission[manage_vehicle]" : permissionManageVehicle,
        "permission[add_vehicle]" : permissionAddVehicle,
        "permission[rent_request]" : permissionRentRequest,
        "permission[vehicle_reports]" : permissionVehicleReport,
        "permission[payment_report]" : permissionPaymentReport,
        "permission[ticket_manage]" : permissionTicketManagement,
      }
    );

    print("this is create empolyee reports === ${res.statusCode}");
    print("this is create empolyee reports === ${res.body}");

    return res;

  }


  static Future<EmployeeListModel> employeeList()async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");

    var res = await http.get(Uri.parse(AppConfig.EMPLOYEE_LIST),
      headers: {
        "Authorization": "Bearer $token",
      }
    );
    return EmployeeListModel.fromJson(jsonDecode(res.body));
  }


  ////show single employee data
  static Future<EmployeeListModel> showSingleemployee(id)async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");

    var res = await http.get(Uri.parse(AppConfig.EMPLOYEE_LIST+"/$id"),
        headers: {
          "Authorization": "Bearer $token",
        }
    );
    return EmployeeListModel.fromJson(jsonDecode(res.body));
  }

  //delete employuee
  static Future deleteEmployee (id)async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");

    var res = await http.delete(Uri.parse(AppConfig.EMPLOYEE_LIST+"/$id"),
        headers: {
          "Authorization": "Bearer $token",
        }
    );
    return res;
  }




}