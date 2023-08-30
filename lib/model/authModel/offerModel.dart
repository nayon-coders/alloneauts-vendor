// To parse this JSON data, do
//
//     final pricingModel = pricingModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PricingModel pricingModelFromJson(String str) => PricingModel.fromJson(json.decode(str));

String pricingModelToJson(PricingModel data) => json.encode(data.toJson());

class PricingModel {
  final List<Monthly> yearly;
  final List<Monthly> monthly;

  PricingModel({
    required this.yearly,
    required this.monthly,
  });

  factory PricingModel.fromJson(Map<String, dynamic> json) => PricingModel(
    yearly: List<Monthly>.from(json["yearly"].map((x) => Monthly.fromJson(x))),
    monthly: List<Monthly>.from(json["monthly"].map((x) => Monthly.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "yearly": List<dynamic>.from(yearly.map((x) => x.toJson())),
    "monthly": List<dynamic>.from(monthly.map((x) => x.toJson())),
  };
}

class Monthly {
  final int id;
  final String type;
  final int price;
  final int discount;
  final String category;
  final String short;
  final List<String> details;

  Monthly({
    required this.id,
    required this.type,
    required this.price,
    required this.discount,
    required this.category,
    required this.short,
    required this.details,
  });

  factory Monthly.fromJson(Map<String, dynamic> json) => Monthly(
    id: json["ID"],
    type: json["type"],
    price: json["price"],
    discount: json["discount"],
    category: json["category"],
    short: json["short"],
    details: List<String>.from(json["details"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "type": type,
    "price": price,
    "discount": discount,
    "category": category,
    "short": short,
    "details": List<dynamic>.from(details.map((x) => x)),
  };
}
