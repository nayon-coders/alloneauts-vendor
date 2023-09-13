// To parse this JSON data, do
//
//     final singleRentCarModel = singleRentCarModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SingleRentCarModel singleRentCarModelFromJson(String str) => SingleRentCarModel.fromJson(json.decode(str));

String singleRentCarModelToJson(SingleRentCarModel data) => json.encode(data.toJson());

class SingleRentCarModel {
  final bool success;
  final String status;
  final int statusCode;
  final String message;
  final Api api;
  final Data data;

  SingleRentCarModel({
    required this.success,
    required this.status,
    required this.statusCode,
    required this.message,
    required this.api,
    required this.data,
  });

  factory SingleRentCarModel.fromJson(Map<String, dynamic> json) => SingleRentCarModel(
    success: json["success"],
    status: json["status"],
    statusCode: json["status_code"],
    message: json["message"],
    api: Api.fromJson(json["api"]),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status": status,
    "status_code": statusCode,
    "message": message,
    "api": api.toJson(),
    "data": data.toJson(),
  };
}

class Api {
  final String endpoint;
  final String method;

  Api({
    required this.endpoint,
    required this.method,
  });

  factory Api.fromJson(Map<String, dynamic> json) => Api(
    endpoint: json["endpoint"],
    method: json["method"],
  );

  Map<String, dynamic> toJson() => {
    "endpoint": endpoint,
    "method": method,
  };
}

class Data {
  final Car car;

  Data({
    required this.car,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    car: Car.fromJson(json["car"]),
  );

  Map<String, dynamic> toJson() => {
    "car": car.toJson(),
  };
}

class Car {
  final int id;
  final Details details;
  final List<String> images;

  Car({
    required this.id,
    required this.details,
    required this.images,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    id: json["id"],
    details: Details.fromJson(json["details"]),
    images: List<String>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "details": details.toJson(),
    "images": List<dynamic>.from(images.map((x) => x)),
  };
}

class Details {
  final String name;
  final int price;
  final dynamic duration;
  final String paymentMethod;
  final String mileage;
  final String location;
  final dynamic latitude;
  final dynamic longitude;
  final dynamic plateNo;
  final dynamic vyear;
  final dynamic vcolor;
  final dynamic vmodel;
  final dynamic vmake;
  final dynamic fh;
  final dynamic insurance;
  final dynamic diclaration;
  final String contact;
  final String email;
  final String productCode;
  final int active;

  Details({
    required this.name,
    required this.price,
    required this.duration,
    required this.paymentMethod,
    required this.mileage,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.plateNo,
    required this.vyear,
    required this.vcolor,
    required this.vmodel,
    required this.vmake,
    required this.fh,
    required this.insurance,
    required this.diclaration,
    required this.contact,
    required this.email,
    required this.productCode,
    required this.active,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    name: json["name"],
    price: json["price"],
    duration: json["duration"],
    paymentMethod: json["payment_method"],
    mileage: json["mileage"],
    location: json["location"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    plateNo: json["plate_no"],
    vyear: json["vyear"],
    vcolor: json["vcolor"],
    vmodel: json["vmodel"],
    vmake: json["vmake"],
    fh: json["fh"],
    insurance: json["insurance"],
    diclaration: json["diclaration"],
    contact: json["contact"],
    email: json["email"],
    productCode: json["product_code"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "duration": duration,
    "payment_method": paymentMethod,
    "mileage": mileage,
    "location": location,
    "latitude": latitude,
    "longitude": longitude,
    "plate_no": plateNo,
    "vyear": vyear,
    "vcolor": vcolor,
    "vmodel": vmodel,
    "vmake": vmake,
    "fh": fh,
    "insurance": insurance,
    "diclaration": diclaration,
    "contact": contact,
    "email": email,
    "product_code": productCode,
    "active": active,
  };
}
