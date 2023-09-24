// To parse this JSON data, do
//
//     final employeeListModel = employeeListModelFromJson(jsonString);

import 'dart:convert';

EmployeeListModel employeeListModelFromJson(String str) => EmployeeListModel.fromJson(json.decode(str));

String employeeListModelToJson(EmployeeListModel data) => json.encode(data.toJson());

class EmployeeListModel {
  bool? success;
  String? status;
  int? statusCode;
  String? message;
  Api? api;
  List<Datum>? data;

  EmployeeListModel({
    this.success,
    this.status,
    this.statusCode,
    this.message,
    this.api,
    this.data,
  });

  factory EmployeeListModel.fromJson(Map<String, dynamic> json) => EmployeeListModel(
    success: json["success"],
    status: json["status"],
    statusCode: json["status_code"],
    message: json["message"],
    api: json["api"] == null ? null : Api.fromJson(json["api"]),
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status": status,
    "status_code": statusCode,
    "message": message,
    "api": api?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
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

class Datum {
  int? id;
  int? status;
  String? createdAt;
  Details? details;

  Datum({
    this.id,
    this.status,
    this.createdAt,
    this.details,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    status: json["status"],
    createdAt: json["created_at"],
    details: json["details"] == null ? null : Details.fromJson(json["details"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "created_at": createdAt,
    "details": details?.toJson(),
  };
}

class Details {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  dynamic avatar;
  String? document;
  String? streetAddress;
  String? apartment;
  String? city;
  String? state;
  String? zipcode;
  String? homePhone;
  String? callPhone;
  String? socialSecurityNumber;
  String? birthDate;
  String? maritalStatus;
  Spouse? spouse;
  Emergency? emergency;
  Tax? tax;
  String? employeeType;
  String? startDate;
  Permission? permission;

  Details({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.avatar,
    this.document,
    this.streetAddress,
    this.apartment,
    this.city,
    this.state,
    this.zipcode,
    this.homePhone,
    this.callPhone,
    this.socialSecurityNumber,
    this.birthDate,
    this.maritalStatus,
    this.spouse,
    this.emergency,
    this.tax,
    this.employeeType,
    this.startDate,
    this.permission,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phone: json["phone"],
    avatar: json["avatar"],
    document: json["document"],
    streetAddress: json["street_address"],
    apartment: json["apartment"],
    city: json["city"],
    state: json["state"],
    zipcode: json["zipcode"],
    homePhone: json["home_phone"],
    callPhone: json["call_phone"],
    socialSecurityNumber: json["social_security_number"],
    birthDate: json["birth_date"],
    maritalStatus: json["marital_status"],
    spouse: json["spouse"] == null ? null : Spouse.fromJson(json["spouse"]),
    emergency: json["emergency"] == null ? null : Emergency.fromJson(json["emergency"]),
    tax: json["tax"] == null ? null : Tax.fromJson(json["tax"]),
    employeeType: json["employee_type"],
    startDate: json["start_date"],
    permission: json["permission"] == null ? null : Permission.fromJson(json["permission"]),
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "avatar": avatar,
    "document": document,
    "street_address": streetAddress,
    "apartment": apartment,
    "city": city,
    "state": state,
    "zipcode": zipcode,
    "home_phone": homePhone,
    "call_phone": callPhone,
    "social_security_number": socialSecurityNumber,
    "birth_date": birthDate,
    "marital_status": maritalStatus,
    "spouse": spouse?.toJson(),
    "emergency": emergency?.toJson(),
    "tax": tax?.toJson(),
    "employee_type": employeeType,
    "start_date": startDate,
    "permission": permission?.toJson(),
  };
}

class Emergency {
  String? firstname;
  String? lastname;
  String? phone;

  Emergency({
    this.firstname,
    this.lastname,
    this.phone,
  });

  factory Emergency.fromJson(Map<String, dynamic> json) => Emergency(
    firstname: json["firstname"],
    lastname: json["lastname"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "lastname": lastname,
    "phone": phone,
  };
}

class Permission {
  String? manageVehicle;
  String? addVehicle;
  String? rentRequest;
  String? vehicleReports;
  String? paymentReport;
  String? ticketManage;

  Permission({
    this.manageVehicle,
    this.addVehicle,
    this.rentRequest,
    this.vehicleReports,
    this.paymentReport,
    this.ticketManage,
  });

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
    manageVehicle: json["manage_vehicle"],
    addVehicle: json["add_vehicle"],
    rentRequest: json["rent_request"],
    vehicleReports: json["vehicle_reports"],
    paymentReport: json["payment_report"],
    ticketManage: json["ticket_manage"],
  );

  Map<String, dynamic> toJson() => {
    "manage_vehicle": manageVehicle,
    "add_vehicle": addVehicle,
    "rent_request": rentRequest,
    "vehicle_reports": vehicleReports,
    "payment_report": paymentReport,
    "ticket_manage": ticketManage,
  };
}

class Spouse {
  String? has;
  String? name;
  String? number;

  Spouse({
    this.has,
    this.name,
    this.number,
  });

  factory Spouse.fromJson(Map<String, dynamic> json) => Spouse(
    has: json["has"],
    name: json["name"],
    number: json["number"],
  );

  Map<String, dynamic> toJson() => {
    "has": has,
    "name": name,
    "number": number,
  };
}

class Tax {
  String? federalIncome;
  String? stateIncome;
  String? medicareTax;
  String? country;

  Tax({
    this.federalIncome,
    this.stateIncome,
    this.medicareTax,
    this.country,
  });

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
    federalIncome: json["federal_income"],
    stateIncome: json["state_income"],
    medicareTax: json["medicare_tax"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "federal_income": federalIncome,
    "state_income": stateIncome,
    "medicare_tax": medicareTax,
    "country": country,
  };
}
