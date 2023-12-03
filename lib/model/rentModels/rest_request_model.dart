// To parse this JSON data, do
//
//     final rentRequestListModel = rentRequestListModelFromJson(jsonString);

import 'dart:convert';

RentRequestListModel rentRequestListModelFromJson(String str) => RentRequestListModel.fromJson(json.decode(str));

String rentRequestListModelToJson(RentRequestListModel data) => json.encode(data.toJson());

class RentRequestListModel {
  final bool? success;
  final String? status;
  final int? statusCode;
  final String? message;
  final Api? api;
  final Data? data;

  RentRequestListModel({
    this.success,
    this.status,
    this.statusCode,
    this.message,
    this.api,
    this.data,
  });

  factory RentRequestListModel.fromJson(Map<String, dynamic> json) => RentRequestListModel(
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
  final List<Request>? requests;

  Data({
    this.requests,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    requests: json["requests"] == null ? [] : List<Request>.from(json["requests"]!.map((x) => Request.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "requests": requests == null ? [] : List<dynamic>.from(requests!.map((x) => x.toJson())),
  };
}

class Request {
  final int? requestId;
  final String? message;
  final String? status;
  final Car? car;
  final Driver? driver;

  Request({
    this.requestId,
    this.message,
    this.status,
    this.car,
    this.driver,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
    requestId: json["request_id"],
    message: json["message"],
    status: json["status"],
    car: json["car"] == null ? null : Car.fromJson(json["car"]),
    driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
  );

  Map<String, dynamic> toJson() => {
    "request_id": requestId,
    "message": message,
    "status": status,
    "car": car?.toJson(),
    "driver": driver?.toJson(),
  };
}

class Car {
  final int? carId;
  final String? name;
  final int? price;
  final dynamic mileage;
  final dynamic plateNo;
  final dynamic vyear;
  final dynamic vcolor;
  final dynamic vmodel;
  final dynamic vmake;
  final dynamic image;
  final Location? location;

  Car({
    this.carId,
    this.name,
    this.price,
    this.mileage,
    this.plateNo,
    this.vyear,
    this.vcolor,
    this.vmodel,
    this.vmake,
    this.image,
    this.location,
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
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
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
    "location": location?.toJson(),
  };
}

class Location {
  final dynamic place;
  final dynamic longitude;
  final dynamic latitude;

  Location({
    this.place,
    this.longitude,
    this.latitude,
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
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? streetAddress;
  final String? city;
  final String? state;
  final String? zipcode;
  final String? homePhone;
  final String? callPhone;
  final String? socialSecurityNumber;
  final String? birthDate;
  final String? maritalStatus;
  final Spouse? spouse;
  final Emergency? emergency;
  final Tax? tax;
  final String? employeeType;
  final String? startDate;
  final Permission? permission;
  final String? document;
  final dynamic avatar;

  Driver({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.streetAddress,
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
    this.document,
    this.avatar,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phone: json["phone"],
    streetAddress: json["street_address"],
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
    document: json["document"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "street_address": streetAddress,
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
    "document": document,
    "avatar": avatar,
  };
}

class Emergency {
  final String? firstname;
  final String? lastname;
  final String? phone;

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
  final String? manageVehicle;
  final String? addVehicle;
  final String? rentRequest;
  final String? vehicleReports;
  final String? paymentReport;
  final String? ticketManage;

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
  final String? has;
  final String? name;
  final String? number;

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
  final String? federalIncome;
  final String? stateIncome;
  final String? medicareTax;
  final String? country;

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
