// To parse this JSON data, do
//
//     final rentCarModel = rentCarModelFromJson(jsonString);

import 'dart:convert';

RentCarModel rentCarModelFromJson(String str) => RentCarModel.fromJson(json.decode(str));

String rentCarModelToJson(RentCarModel data) => json.encode(data.toJson());

class RentCarModel {
  bool? success;
  String? status;
  int? statusCode;
  String? message;
  Api? api;
  Data? data;

  RentCarModel({
    this.success,
    this.status,
    this.statusCode,
    this.message,
    this.api,
    this.data,
  });

  factory RentCarModel.fromJson(Map<String, dynamic> json) => RentCarModel(
    success: json["success"],
    status: json["status"],
    statusCode: json["status_code"],
    message: json["message"],
    api: json["api"] == null ? null : Api.fromJson(json["api"]),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status": status,
    "status_code": statusCode,
    "message": message,
    "api": api?.toJson(),
    "data": data?.toJson(),
  };
}

class Api {
  String? endpoint;
  String? method;

  Api({
    this.endpoint,
    this.method,
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
  List<Car>? cars;

  Data({
    this.cars,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    cars: json["cars"] == null ? [] : List<Car>.from(json["cars"]!.map((x) => Car.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cars": cars == null ? [] : List<dynamic>.from(cars!.map((x) => x.toJson())),
  };
}

class Car {
  int? id;
  Details? details;
  List<String>? images;

  Car({
    this.id,
    this.details,
    this.images,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    id: json["id"],
    details: json["details"] == null ? null : Details.fromJson(json["details"]),
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "details": details?.toJson(),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
  };
}

class Details {
  String? name;
  String? price;
  String? mileage;
  String? location;
  String? latitude;
  String? longitude;
  String? plateNo;
  String? vtrim;
  String? vyear;
  String? vmodel;
  String? vmake;
  String? vcolor;
  String? email;
  String? contact;
  String? carCode;
  List<String>? fh;
  List<String>? insurance;
  List<String>? diclaration;

  Details({
    this.name,
    this.price,
    this.mileage,
    this.location,
    this.latitude,
    this.longitude,
    this.plateNo,
    this.vtrim,
    this.vyear,
    this.vmodel,
    this.vmake,
    this.vcolor,
    this.email,
    this.contact,
    this.carCode,
    this.fh,
    this.insurance,
    this.diclaration,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    name: json["name"],
    price: json["price"],
    mileage: json["mileage"],
    location: json["location"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    plateNo: json["plate_no"],
    vtrim: json["vtrim"],
    vyear: json["vyear"],
    vmodel: json["vmodel"],
    vmake: json["vmake"],
    vcolor: json["vcolor"],
    email: json["email"],
    contact: json["contact"],
    carCode: json["car_code"],
    fh: json["fh"] == null ? [] : List<String>.from(json["fh"]!.map((x) => x)),
    insurance: json["insurance"] == null ? [] : List<String>.from(json["insurance"]!.map((x) => x)),
    diclaration: json["diclaration"] == null ? [] : List<String>.from(json["diclaration"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "mileage": mileage,
    "location": location,
    "latitude": latitude,
    "longitude": longitude,
    "plate_no": plateNo,
    "vtrim": vtrim,
    "vyear": vyear,
    "vmodel": vmodel,
    "vmake": vmake,
    "vcolor": vcolor,
    "email": email,
    "contact": contact,
    "car_code": carCode,
    "fh": fh == null ? [] : List<dynamic>.from(fh!.map((x) => x)),
    "insurance": insurance == null ? [] : List<dynamic>.from(insurance!.map((x) => x)),
    "diclaration": diclaration == null ? [] : List<dynamic>.from(diclaration!.map((x) => x)),
  };
}
