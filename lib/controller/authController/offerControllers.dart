import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vendor/app_config.dart';
import 'package:vendor/utility/app_color.dart';

import '../../model/authModel/offerModel.dart';

class OfferControllers{
  //get api response
  
  static Future<PricingModel> getOfferData()async{

    var response = await http.get(Uri.parse("${AppConfig.OFFERS}"),
      headers: {
        "Accept": "application/json"
      }
    );
    print("data ==----== ${response.statusCode}");
    print("data ==== ${response.body}");
    if(response.statusCode == 200){
      return PricingModel.fromJson(jsonDecode(response.body));
    }else
      return PricingModel.fromJson(jsonDecode(response.body));

  }

}