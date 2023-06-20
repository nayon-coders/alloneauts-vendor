import 'package:flutter/material.dart';
import 'package:vendor/view/dashboard/dashboard.dart';
import 'package:vendor/view/rent/AddCar.dart';
import 'package:vendor/view/rent/manage_car.dart';
import 'package:vendor/view/rent/rentRequest.dart';

class AllPages{
  static  List allPages = [
    Dashboard(), //index = 0
    RentRequestList(), //index = 1
    ManageCar(), //index = 2
    AddCar(), //index = 3
  ];
}