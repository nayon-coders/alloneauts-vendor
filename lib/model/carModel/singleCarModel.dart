// To parse this JSON data, do
//
//     final singleCarModel = singleCarModelFromJson(jsonString);

import 'dart:convert';

SingleCarModel singleCarModelFromJson(String str) => SingleCarModel.fromJson(json.decode(str));

String singleCarModelToJson(SingleCarModel data) => json.encode(data.toJson());

class SingleCarModel {
  final int? id;
  final Details? details;
  final List<String> images;

  SingleCarModel({
    this.id,
    this.details,
    required this.images,
  });

  factory SingleCarModel.fromJson(Map<String, dynamic> json) => SingleCarModel(
    id: json["id"],
    details: Details.fromJson(json["details"]),
    images: List<String>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "details": details?.toJson(),
    "images": List<dynamic>.from(images.map((x) => x)),
  };
}

class Details {
  final String? name;
  final int? price;
  final dynamic duration;
  final dynamic paymentMethod;
  final String? mileage;
  final String? location;
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
  final String? contact;
  final String? email;
  final String? productCode;
  final int? active;

  Details({
    this.name,
    this.price,
    this.duration,
    this.paymentMethod,
    this.mileage,
    this.location,
    this.latitude,
    this.longitude,
    this.plateNo,
    this.vyear,
    this.vcolor,
    this.vmodel,
    this.vmake,
    this.fh,
    this.insurance,
    this.diclaration,
    this.contact,
    this.email,
    this.productCode,
    this.active,
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
