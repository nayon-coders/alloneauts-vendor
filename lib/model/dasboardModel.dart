// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  final bool? success;
  final String? status;
  final int? statusCode;
  final String? message;
  final Api? api;
  final Data? data;

  DashboardModel({
    this.success,
    this.status,
    this.statusCode,
    this.message,
    this.api,
    this.data,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
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
  final String? endpoint;
  final String? method;

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
  final int? totalCar;
  final int? totalActiveCar;
  final int? totalRequest;
  final int? totalPendingRequest;
  final int? assignDrivers;
  final int? assignVehicle;
  final int? totalTicket;
  final int? totalExpense;
  final int? totalEarning;
  final int? totalRevenue;
  final int? upcomingPay;
  final int? duePayment;
  final List<Report>? reports;

  Data({
    this.totalCar,
    this.totalActiveCar,
    this.totalRequest,
    this.totalPendingRequest,
    this.assignDrivers,
    this.assignVehicle,
    this.totalTicket,
    this.totalExpense,
    this.totalEarning,
    this.totalRevenue,
    this.upcomingPay,
    this.duePayment,
    this.reports,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalCar: json["total_car"],
    totalActiveCar: json["total_active_car"],
    totalRequest: json["total_request"],
    totalPendingRequest: json["total_pending_request"],
    assignDrivers: json["assign_drivers"],
    assignVehicle: json["assign_vehicle"],
    totalTicket: json["total_ticket"],
    totalExpense: json["total_expense"],
    totalEarning: json["total_earning"],
    totalRevenue: json["total_revenue"],
    upcomingPay: json["upcoming_pay"],
    duePayment: json["due_payment"],
    reports: json["reports"] == null ? [] : List<Report>.from(json["reports"]!.map((x) => Report.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_car": totalCar,
    "total_active_car": totalActiveCar,
    "total_request": totalRequest,
    "total_pending_request": totalPendingRequest,
    "assign_drivers": assignDrivers,
    "assign_vehicle": assignVehicle,
    "total_ticket": totalTicket,
    "total_expense": totalExpense,
    "total_earning": totalEarning,
    "total_revenue": totalRevenue,
    "upcoming_pay": upcomingPay,
    "due_payment": duePayment,
    "reports": reports == null ? [] : List<dynamic>.from(reports!.map((x) => x.toJson())),
  };
}

class Report {
  final int? year;
  final List<Detail>? details;

  Report({
    this.year,
    this.details,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    year: json["year"],
    details: json["details"] == null ? [] : List<Detail>.from(json["details"]!.map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "year": year,
    "details": details == null ? [] : List<dynamic>.from(details!.map((x) => x.toJson())),
  };
}

class Detail {
  final String? month;
  final int? expense;
  final int? earnings;

  Detail({
    this.month,
    this.expense,
    this.earnings,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    month: json["month"],
    expense: json["expense"],
    earnings: json["earnings"],
  );

  Map<String, dynamic> toJson() => {
    "month": month,
    "expense": expense,
    "earnings": earnings,
  };
}
