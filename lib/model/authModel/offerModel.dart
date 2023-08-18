// To parse this JSON data, do
//
//     final offerModels = offerModelsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OfferModels offerModelsFromJson(String str) => OfferModels.fromJson(json.decode(str));

String offerModelsToJson(OfferModels data) => json.encode(data.toJson());

class OfferModels {
  final bool success;
  final String status;
  final int statusCode;
  final String message;
  final Api api;
  final Data data;

  OfferModels({
    required this.success,
    required this.status,
    required this.statusCode,
    required this.message,
    required this.api,
    required this.data,
  });

  factory OfferModels.fromJson(Map<String, dynamic> json) => OfferModels(
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
  final List<Pricing> pricing;

  Data({
    required this.pricing,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pricing: List<Pricing>.from(json["pricing"].map((x) => Pricing.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pricing": List<dynamic>.from(pricing.map((x) => x.toJson())),
  };
}

class Pricing {
  final int id;
  final String type;
  final int price;
  final int discount;
  final String category;
  final String short;
  final String details;

  Pricing({
    required this.id,
    required this.type,
    required this.price,
    required this.discount,
    required this.category,
    required this.short,
    required this.details,
  });

  factory Pricing.fromJson(Map<String, dynamic> json) => Pricing(
    id: json["ID"],
    type: json["type"],
    price: json["price"],
    discount: json["discount"],
    category: json["category"],
    short: json["short"],
    details: json["details"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "type": type,
    "price": price,
    "discount": discount,
    "category": category,
    "short": short,
    "details": details,
  };
}
