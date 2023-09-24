import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/app_config.dart';
import 'package:vendor/view/globals.dart' as global;
import '../../model/rentModels/rentCarListModel.dart';

class RentCarController{
  
  //car rent list
  static Future<RentCarModel> getRentCarList()async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    var res = await http.get(Uri.parse(AppConfig.RENT_CAR_LIST),
      headers: {
        "Authorization" : "Bearer ${token}"
      }
    );
    print("data === ${jsonDecode(res.body)["data"]}");
  //  return jsonDecode(res.body)["data"]["cars"];
    var json = jsonDecode(res.body);
    return RentCarModel.fromJson(json);
  }

 //single car rent edit
  static Future editRentCar(singleCarEditInfo)async{
    bool _isLoading = true;
    bool _isError = false;
    print("This is car id === ${singleCarEditInfo["id"]}");
    print("This is car id === ${singleCarEditInfo}");
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    var res = await http.post(Uri.parse(AppConfig.DELETE_RENT_CAR+"${singleCarEditInfo["id"]}/update"),
        headers: {
          "Authorization" : "Bearer ${token}"
        },
      body: singleCarEditInfo
    );
    print("status ==== ${res.statusCode}");
    print("status ==== ${res.body}");
    return res;
  }


  //ADD CARD
  static Future addCard(carInfo)async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    var res = await http.post(Uri.parse(AppConfig.ADD_CAR_FOR_RENT),
        headers: {
          "Authorization" : "Bearer ${token}"
        },
        body:carInfo
    );
    print("add car data === ${res.body}");
    print("add car status === ${res.statusCode}");
    //  return jsonDecode(res.body)["data"]["cars"];
    return res;
  }



  //single car rent delete
  static Future<bool> deleteCar(id)async{
    bool _isLoading = true;
    bool _isError = false;
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    var res = await http.post(Uri.parse(AppConfig.DELETE_RENT_CAR+"$id/delete"),
        headers: {
          "Content-Type": "application/json",
          "Authorization" : "Bearer ${token}"
        }
    );
    print("status ==== ${res.statusCode}");
    print("status ==== ${res.body}");
    if(res.statusCode == 200){
      _isLoading = false;
      return _isLoading;
    }else{
      _isError = true;
      return _isError;
    }
  }


  //single car rent search
  static Future<http.Response> singleRentCartController(id)async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    var res = await http.get(Uri.parse("${AppConfig.SINGLE_RENT_CAR}51"),
        headers: {
          "Content-Type": "application/json",
          "Authorization" : "Bearer ${token}"
        }
    ); //  return jsonDecode(res.body)["data"]["cars"];
    var json = jsonDecode(res.body);
    return res;
  }
  
}