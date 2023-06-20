import 'package:flutter/material.dart';
import 'package:vendor/view/dashboard/dashboard.dart';
import 'package:vendor/view/profile/profile.dart';
import 'package:vendor/view/rent/AddCar.dart';
import 'package:vendor/view/rent/edit_car.dart';
import 'package:vendor/view/rent/manage_car.dart';
import 'package:vendor/view/rent/rentRequest.dart';
import 'package:vendor/view/rent/view_car.dart';

class AllPages{
  static  List allPages = [
    Dashboard(), //index = 0
    RentRequestList(), //index = 1
    ManageCar(), //index = 2
    AddCar(), //index = 3
    EditCar(), //index = 4
    ViewSingleCar(), //index = 5
    Profile(), //index = 6
  ];
}