import 'package:flutter/material.dart';
import 'package:vendor/view/dashboard/dashboard.dart';
import 'package:vendor/view/profile/profile.dart';
import 'package:vendor/view/rent/AddCar.dart';
import 'package:vendor/view/rent/edit_car.dart';
import 'package:vendor/view/rent/manage_car.dart';
import 'package:vendor/view/rent/rentRequest.dart';
import 'package:vendor/view/rent/view_car.dart';
import 'package:vendor/view/reports/car-reports.dart';
import 'package:vendor/view/reports/create-reports.dart';
import 'package:vendor/view/ticketManagement/findTicket.dart';
import 'package:vendor/view/ticketManagement/singleTicker.dart';

import 'ticketManagement/allTicket.dart';

class AllPages{
  static const  List allPages = [
    Dashboard(), //index = 0
    RentRequestList(), //index = 1
    ManageCar(), //index = 2
    AddCar(), //index = 3
    EditCar(), //index = 4
    ViewSingleCar(), //index = 5
    Profile(), //index = 6
    CarReports(), //index = 7
    CreateReports(), //index = 8
    FindTicket(), //index = 9
    AllTicket(), //index = 10
    SingleTicket(), //index = 11
  ];
}