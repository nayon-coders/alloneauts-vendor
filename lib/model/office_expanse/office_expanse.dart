// To parse this JSON data, do
//
//     final officeExpanseListModel = officeExpanseListModelFromJson(jsonString);

import 'dart:convert';

OfficeExpanseListModel officeExpanseListModelFromJson(String str) => OfficeExpanseListModel.fromJson(json.decode(str));

String officeExpanseListModelToJson(OfficeExpanseListModel data) => json.encode(data.toJson());

class OfficeExpanseListModel {
  final List<ExpanseList>? expanseList;

  OfficeExpanseListModel({
    this.expanseList,
  });

  factory OfficeExpanseListModel.fromJson(Map<String, dynamic> json) => OfficeExpanseListModel(
    expanseList: json["expanse_list"] == null ? [] : List<ExpanseList>.from(json["expanse_list"]!.map((x) => ExpanseList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "expanse_list": expanseList == null ? [] : List<dynamic>.from(expanseList!.map((x) => x.toJson())),
  };
}

class ExpanseList {
  final String? amount;
  final DateTime? date;
  final String? details;

  ExpanseList({
    this.amount,
    this.date,
    this.details,
  });

  factory ExpanseList.fromJson(Map<String, dynamic> json) => ExpanseList(
    amount: json["amount"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    details: json["details"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "details": details,
  };
}
