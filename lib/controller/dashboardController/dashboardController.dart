import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/app_config.dart';

import '../../model/dasboardModel.dart';

class DashboardController{
  //get api response

  static Future<DashboardModel> dashboardController()async{
    SharedPreferences _pres = await SharedPreferences.getInstance();
    var token = _pres.getString("token");
    var response = await http.get(Uri.parse("${AppConfig.DASHBOARD}"),
      headers: {
        "Authorization" : "Bearer $token"
      }
    );
    print("data ==== ${response.statusCode}");
    print("data ==== ${response.body}");
    //print("data ==== ${response.body}");
    // var data = DashboardModel.fromJson(jsonDecode(response.body));
    // print(data);
     return DashboardModel.fromJson(jsonDecode(response.body));

  }

}