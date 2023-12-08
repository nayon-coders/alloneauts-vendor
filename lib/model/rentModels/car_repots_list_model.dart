// To parse this JSON data, do
//
//     final carReportsListModel = carReportsListModelFromJson(jsonString);

import 'dart:convert';

CarReportsListModel carReportsListModelFromJson(String str) => CarReportsListModel.fromJson(json.decode(str));

String carReportsListModelToJson(CarReportsListModel data) => json.encode(data.toJson());

class CarReportsListModel {
  final bool? success;
  final String? status;
  final int? statusCode;
  final String? message;
  final Api? api;
  final Data? data;

  CarReportsListModel({
    this.success,
    this.status,
    this.statusCode,
    this.message,
    this.api,
    this.data,
  });

  factory CarReportsListModel.fromJson(Map<String, dynamic> json) => CarReportsListModel(
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
  final List<Car>? availableCar;
  final List<Car>? assignedCar;

  Data({
    this.availableCar,
    this.assignedCar,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    availableCar: json["available_car"] == null ? [] : List<Car>.from(json["available_car"]!.map((x) => Car.fromJson(x))),
    assignedCar: json["assigned_car"] == null ? [] : List<Car>.from(json["assigned_car"]!.map((x) => Car.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "available_car": availableCar == null ? [] : List<dynamic>.from(availableCar!.map((x) => x.toJson())),
    "assigned_car": assignedCar == null ? [] : List<dynamic>.from(assignedCar!.map((x) => x.toJson())),
  };
}

class Car {
  final int? id;
  final List<String>? images;
  final AssignedCarDetails? details;
  final int? active;
  final Driver? user;
  final Driver? driver;
  final List<Report>? reports;
  final List<dynamic>? payments;

  Car({
    this.id,
    this.images,
    this.details,
    this.active,
    this.user,
    this.driver,
    this.reports,
    this.payments,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    id: json["id"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    details: json["details"] == null ? null : AssignedCarDetails.fromJson(json["details"]),
    active: json["active"],
    user: json["user"] == null ? null : Driver.fromJson(json["user"]),
    driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
    reports: json["reports"] == null ? [] : List<Report>.from(json["reports"]!.map((x) => Report.fromJson(x))),
    payments: json["payments"] == null ? [] : List<dynamic>.from(json["payments"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "details": details?.toJson(),
    "active": active,
    "user": user?.toJson(),
    "driver": driver?.toJson(),
    "reports": reports == null ? [] : List<dynamic>.from(reports!.map((x) => x.toJson())),
    "payments": payments == null ? [] : List<dynamic>.from(payments!.map((x) => x)),
  };
}

class AssignedCarDetails {
  final String? name;
  final String? price;
  final String? mileage;
  final String? location;
  final String? latitude;
  final String? longitude;
  final String? plateNo;
  final String? vtrim;
  final String? vyear;
  final String? vmodel;
  final String? vmake;
  final String? vcolor;
  final String? email;
  final String? contact;
  final String? carCode;
  final List<String>? fh;
  final List<String>? insurance;
  final List<String>? diclaration;

  AssignedCarDetails({
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

  factory AssignedCarDetails.fromJson(Map<String, dynamic> json) => AssignedCarDetails(
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

class Driver {
  final int? id;
  final String? firstName;
  final String? lastName;
  final dynamic avatar;
  final String? email;
  final dynamic emailVerifiedAt;
  final String? phone;
  final DateTime? phoneVerifiedAt;
  final DriverDetails? details;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final int? laravelThroughKey;

  Driver({
    this.id,
    this.firstName,
    this.lastName,
    this.avatar,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.phoneVerifiedAt,
    this.details,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.laravelThroughKey,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    avatar: json["avatar"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    phone: json["phone"],
    phoneVerifiedAt: json["phone_verified_at"] == null ? null : DateTime.parse(json["phone_verified_at"]),
    details: json["details"] == null ? null : DriverDetails.fromJson(json["details"]),
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    laravelThroughKey: json["laravel_through_key"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "avatar": avatar,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "phone": phone,
    "phone_verified_at": phoneVerifiedAt?.toIso8601String(),
    "details": details?.toJson(),
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "laravel_through_key": laravelThroughKey,
  };
}

class DriverDetails {
  final String? image;
  final String? email;
  final String? phone;
  final DateTime? emailVerifiedAt;
  final dynamic phoneVerifiedAt;
  final DateTime? dateOfBirth;
  final dynamic gender;
  final dynamic address;
  final dynamic apiToken;
  final dynamic deviceToken;
  final int? useEmailForContact;
  final int? status;
  final Business? business;

  DriverDetails({
    this.image,
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.apiToken,
    this.deviceToken,
    this.useEmailForContact,
    this.status,
    this.business,
  });

  factory DriverDetails.fromJson(Map<String, dynamic> json) => DriverDetails(
    image: json["image"],
    email: json["email"],
    phone: json["phone"],
    emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
    phoneVerifiedAt: json["phone_verified_at"],
    dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
    gender: json["gender"],
    address: json["address"],
    apiToken: json["api_token"],
    deviceToken: json["device_token"],
    useEmailForContact: json["use_email_for_contact"],
    status: json["status"],
    business: json["business"] == null ? null : Business.fromJson(json["business"]),
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "email": email,
    "phone": phone,
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "phone_verified_at": phoneVerifiedAt,
    "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "address": address,
    "api_token": apiToken,
    "device_token": deviceToken,
    "use_email_for_contact": useEmailForContact,
    "status": status,
    "business": business?.toJson(),
  };
}

class Business {
  final String? license;
  final String? ownerState;
  final String? businessAddress;
  final String? businessEmail;
  final String? businessPhone;
  final dynamic stripeKey;
  final dynamic stripeSecretKey;
  final int? useEmailForContact;

  Business({
    this.license,
    this.ownerState,
    this.businessAddress,
    this.businessEmail,
    this.businessPhone,
    this.stripeKey,
    this.stripeSecretKey,
    this.useEmailForContact,
  });

  factory Business.fromJson(Map<String, dynamic> json) => Business(
    license: json["license"],
    ownerState: json["owner_state"],
    businessAddress: json["business_address"],
    businessEmail: json["business_email"],
    businessPhone: json["business_phone"],
    stripeKey: json["stripe_key"],
    stripeSecretKey: json["stripe_secret_key"],
    useEmailForContact: json["use_email_for_contact"],
  );

  Map<String, dynamic> toJson() => {
    "license": license,
    "owner_state": ownerState,
    "business_address": businessAddress,
    "business_email": businessEmail,
    "business_phone": businessPhone,
    "stripe_key": stripeKey,
    "stripe_secret_key": stripeSecretKey,
    "use_email_for_contact": useEmailForContact,
  };
}

class Report {
  final int? id;
  final String? type;
  final int? amount;
  final String? date;
  final String? details;
  final String? createdAt;
  final String? updatedAt;

  Report({
    this.id,
    this.type,
    this.amount,
    this.date,
    this.details,
    this.createdAt,
    this.updatedAt,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    id: json["id"],
    type: json["type"],
    amount: json["amount"],
    date: json["date"],
    details: json["details"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "amount": amount,
    "date": date,
    "details": details,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
