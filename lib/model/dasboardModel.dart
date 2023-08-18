// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  final bool success;
  final String status;
  final int statusCode;
  final String message;
  final Data data;

  DashboardModel({
    required this.success,
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
    success: json["success"],
    status: json["status"],
    statusCode: json["status_code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status": status,
    "status_code": statusCode,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  final int numberOfTotalCar;
  final int numberOfRentRequest;
  final int numberOfPendingRequest;
  final int numberOfRejectRequest;
  final int numberOfAssignDriver;
  final List<RentRequest> rentRequests;

  Data({
    required this.numberOfTotalCar,
    required this.numberOfRentRequest,
    required this.numberOfPendingRequest,
    required this.numberOfRejectRequest,
    required this.numberOfAssignDriver,
    required this.rentRequests,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    numberOfTotalCar: json["numberOfTotalCar"],
    numberOfRentRequest: json["numberOfRentRequest"],
    numberOfPendingRequest: json["numberOfPendingRequest"],
    numberOfRejectRequest: json["numberOfRejectRequest"],
    numberOfAssignDriver: json["numberOfAssignDriver"],
    rentRequests: List<RentRequest>.from(json["rent_requests"].map((x) => RentRequest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "numberOfTotalCar": numberOfTotalCar,
    "numberOfRentRequest": numberOfRentRequest,
    "numberOfPendingRequest": numberOfPendingRequest,
    "numberOfRejectRequest": numberOfRejectRequest,
    "numberOfAssignDriver": numberOfAssignDriver,
    "rent_requests": List<dynamic>.from(rentRequests.map((x) => x.toJson())),
  };
}

class RentRequest {
  final int requestId;
  final String message;
  final String status;
  final Car car;
  final Driver driver;

  RentRequest({
    required this.requestId,
    required this.message,
    required this.status,
    required this.car,
    required this.driver,
  });

  factory RentRequest.fromJson(Map<String, dynamic> json) => RentRequest(
    requestId: json["request_id"],
    message: json["message"],
    status: json["status"],
    car: Car.fromJson(json["car"]),
    driver: Driver.fromJson(json["driver"]),
  );

  Map<String, dynamic> toJson() => {
    "request_id": requestId,
    "message": message,
    "status": status,
    "car": car.toJson(),
    "driver": driver.toJson(),
  };
}

class Car {
  final int carId;
  final String name;
  final int price;
  final dynamic mileage;
  final String plateNo;
  final String vyear;
  final String vcolor;
  final String vmodel;
  final String vmake;
  final String image;
  final Location location;

  Car({
    required this.carId,
    required this.name,
    required this.price,
    required this.mileage,
    required this.plateNo,
    required this.vyear,
    required this.vcolor,
    required this.vmodel,
    required this.vmake,
    required this.image,
    required this.location,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    carId: json["car_id"],
    name: json["name"],
    price: json["price"],
    mileage: json["mileage"],
    plateNo: json["plate_no"],
    vyear: json["vyear"],
    vcolor: json["vcolor"],
    vmodel: json["vmodel"],
    vmake: json["vmake"],
    image: json["image"],
    location: Location.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "car_id": carId,
    "name": name,
    "price": price,
    "mileage": mileage,
    "plate_no": plateNo,
    "vyear": vyear,
    "vcolor": vcolor,
    "vmodel": vmodel,
    "vmake": vmake,
    "image": image,
    "location": location.toJson(),
  };
}

class Location {
  final String place;
  final dynamic longitude;
  final dynamic latitude;

  Location({
    required this.place,
    required this.longitude,
    required this.latitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    place: json["place"],
    longitude: json["longitude"],
    latitude: json["latitude"],
  );

  Map<String, dynamic> toJson() => {
    "place": place,
    "longitude": longitude,
    "latitude": latitude,
  };
}

class Driver {
  final String name;
  final dynamic image;
  final String phone;
  final String email;

  Driver({
    required this.name,
    required this.image,
    required this.phone,
    required this.email,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    name: json["name"],
    image: json["image"],
    phone: json["phone"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "phone": phone,
    "email": email,
  };
}
