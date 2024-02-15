// To parse this JSON data, do
//
//     final singleCarReportsModel = singleCarReportsModelFromJson(jsonString);

import 'dart:convert';

SingleCarReportsModel singleCarReportsModelFromJson(String str) => SingleCarReportsModel.fromJson(json.decode(str));

String singleCarReportsModelToJson(SingleCarReportsModel data) => json.encode(data.toJson());

class SingleCarReportsModel {
  final bool? success;
  final String? status;
  final int? statusCode;
  final String? message;
  final Api? api;
  final Data? data;

  SingleCarReportsModel({
    this.success,
    this.status,
    this.statusCode,
    this.message,
    this.api,
    this.data,
  });

  factory SingleCarReportsModel.fromJson(Map<String, dynamic> json) => SingleCarReportsModel(
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
  final int? id;
  final List<String>? images;
  final DataDetails? details;
  final int? active;
  final Driver? user;
  final Driver? driver;
  final List<SingleCarReport>? reports;
  final List<dynamic>? payments;

  Data({
    this.id,
    this.images,
    this.details,
    this.active,
    this.user,
    this.driver,
    this.reports,
    this.payments,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    details: json["details"] == null ? null : DataDetails.fromJson(json["details"]),
    active: json["active"],
    user: json["user"] == null ? null : Driver.fromJson(json["user"]),
    driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
    reports: json["reports"] == null ? [] : List<SingleCarReport>.from(json["reports"]!.map((x) => SingleCarReport.fromJson(x))),
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

class DataDetails {
  final String? name;
  final String? plateNo;
  final String? price;
  final String? vmake;
  final String? vmodel;
  final String? vyear;
  final String? color;
  final String? vcolor;
  final String? vtrim;
  final dynamic location;
  final String? latitude;
  final String? longitude;
  final String? email;
  final String? contact;
  final String? mileage;
  final String? carCode;
  final List<String>? fh;
  final List<String>? insurance;
  final List<String>? diclaration;

  DataDetails({
    this.name,
    this.plateNo,
    this.price,
    this.vmake,
    this.vmodel,
    this.vyear,
    this.color,
    this.vcolor,
    this.vtrim,
    this.location,
    this.latitude,
    this.longitude,
    this.email,
    this.contact,
    this.mileage,
    this.carCode,
    this.fh,
    this.insurance,
    this.diclaration,
  });

  factory DataDetails.fromJson(Map<String, dynamic> json) => DataDetails(
    name: json["name"],
    plateNo: json["plate_no"],
    price: json["price"],
    vmake: json["vmake"],
    vmodel: json["vmodel"],
    vyear: json["vyear"],
    color: json["color"],
    vcolor: json["vcolor"],
    vtrim: json["vtrim"],
    location: json["location"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    email: json["email"],
    contact: json["contact"],
    mileage: json["mileage"],
    carCode: json["car_code"],
    fh: json["fh"] == null ? [] : List<String>.from(json["fh"]!.map((x) => x)),
    insurance: json["insurance"] == null ? [] : List<String>.from(json["insurance"]!.map((x) => x)),
    diclaration: json["diclaration"] == null ? [] : List<String>.from(json["diclaration"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "plate_no": plateNo,
    "price": price,
    "vmake": vmake,
    "vmodel": vmodel,
    "vyear": vyear,
    "color": color,
    "vcolor": vcolor,
    "vtrim": vtrim,
    "location": location,
    "latitude": latitude,
    "longitude": longitude,
    "email": email,
    "contact": contact,
    "mileage": mileage,
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
  final String? avatar;
  final String? email;
  final DateTime? emailVerifiedAt;
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
    emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
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
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
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

class SingleCarReport {
  final int? id;
  final String? type;
  final int? amount;
  final String? date;
  final String? details;
  final String? createdAt;
  final String? updatedAt;

  SingleCarReport({
    this.id,
    this.type,
    this.amount,
    this.date,
    this.details,
    this.createdAt,
    this.updatedAt,
  });

  factory SingleCarReport.fromJson(Map<String, dynamic> json) => SingleCarReport(
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

