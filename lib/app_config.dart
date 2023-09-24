import 'package:flutter/material.dart';

class AppConfig{
  static String NYC_POEN_CAMERA_VOILATION = "https://data.cityofnewyork.us/resource/nc67-uf89.json?plate=";


  static String DOMAIN = "https://alloneautos.com";
  static String BASE_URL = "https://alloneautos.com/api";
  static String OFFERS = "$BASE_URL/pricings";
  static String LOGIN = "$BASE_URL/vendor/login";
  static String DASHBOARD = "$BASE_URL/vendor/dashboard";
  static String RENT_CAR_LIST = "$BASE_URL/vendor/rent/cars";
  static String DELETE_RENT_CAR = "$BASE_URL/vendor/rent/car/"; //END POINT IS SHARED
  static String ADD_CAR_FOR_RENT = "$BASE_URL/vendor/rent/car";
  static String UPDATE_RENT_CAR = "$BASE_URL/vendor/rent/car/"; //END POINT IS CAR ID
  static String SINGLE_RENT_CAR = "$BASE_URL/vendor/rent/car/"; //END POINT IS SHARED



  //employee management
  static String CREATE_EMPLOYEE_PROFILE = "$BASE_URL/vendor/employee"; //END POINT IS SHARED
  static String EMPLOYEE_LIST = "$BASE_URL/vendor/employee"; //END POINT IS SHARED



}