import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vendor/app_config.dart';

import '../../model/dasboardModel.dart';

class DashboardController{
  //get api response

  static Future dashboardController()async{

    var response = await http.get(Uri.parse("${AppConfig.DASHBOARD}"));
    print("data ==== ${response.statusCode}");
    print("data ==== ${response.body}");
    if(response.statusCode == 200){
      return DashboardModel.fromJson(jsonDecode(response.body));
    }
  }

}