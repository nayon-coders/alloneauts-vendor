import 'package:flutter/material.dart';
import 'package:vendor/view/dashboard/dashboard.dart';
import 'package:vendor/view/rent/AddCar.dart';
import 'package:vendor/view/rent/manage_car.dart';
import 'package:vendor/view/rent/rentRequest.dart';
import 'package:vendor/view/reports/car-reports.dart';
import 'package:vendor/view/reports/create-reports.dart';
import 'package:vendor/view/ticketManagement/findTicket.dart';
import 'package:vendor/view/ticketManagement/singleTicker.dart';

import 'ticketManagement/allTicket.dart';

class AllPages{
  static  List allPages = [
    Dashboard(), //index = 0
    RentRequestList(), //index = 1
    ManageCar(), //index = 2
    AddCar(), //index = 3
    CarReports(), //index = 4
    CreateReports(), //index = 5
    FindTicket(), //index = 6
    AllTicket(), //index = 7
    SingleTicket(), //index = 8
  ];
}