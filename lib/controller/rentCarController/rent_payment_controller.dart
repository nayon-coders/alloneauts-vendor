import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/app_config.dart';

class RentPaymentController{

  //get payment list
  static Future<bool> getPaymentList()async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString("token");
    var res = await http.get(Uri.parse(AppConfig.GET_PAYMENT),
      headers: {
        "Authorization" : "Bearer $token"
      }
    );
    return true;
  }

}