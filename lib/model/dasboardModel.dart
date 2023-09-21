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
    api: Api.fromJson(json["api"]),
    data: Data.fromJson(json["data"]),
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
  final int? numberOfTotalCar;
  final int? numberOfRentRequest;
  final int? numberOfPendingRequest;
  final int? numberOfRejectRequest;
  final int? numberOfAssignDriver;
  final List<RentRequest> rentRequests;

  Data({
    this.numberOfTotalCar,
    this.numberOfRentRequest,
    this.numberOfPendingRequest,
    this.numberOfRejectRequest,
    this.numberOfAssignDriver,
    required this.rentRequests,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    numberOfTotalCar: json["numberOfTotalCar"],
    numberOfRentRequest: json["numberOfRentRequest"],
    numberOfPendingRequest: json["numberOfPendingRequest"],
    numberOfRejectRequest: json["numberOfRejectRequest"],
    numberOfAssignDriver: json["numberOfAssignDriver"],
    rentRequests: List<RentRequest>.from(json["rent_requests"].map((x) => RentRequest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "numberOfTotalCar": numberOfTotalCar,
    "numberOfRentRequest": numberOfRentRequest,
    "numberOfPendingRequest": numberOfPendingRequest,
    "numberOfRejectRequest": numberOfRejectRequest,
    "numberOfAssignDriver": numberOfAssignDriver,
    "rent_requests": List<dynamic>.from(rentRequests.map((x) => x.toJson())),
  };
}

class RentRequest {
  final int? requestId;
  final String? message;
  final String? status;
  final Car? car;
  final Driver? driver;

  RentRequest({
    this.requestId,
    this.message,
    this.status,
    this.car,
    this.driver,
  });

  factory RentRequest.fromJson(Map<String, dynamic> json) => RentRequest(
    requestId: json["request_id"],
    message: json["message"],
    status: json["status"],
    car: Car.fromJson(json["car"]),
    driver: Driver.fromJson(json["driver"]),
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
  final String? mileage;
  final String? plateNo;
  final String? vyear;
  final String? vcolor;
  final String? vmodel;
  final String? vmake;
  final String? image;
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
    location: Location.fromJson(json["location"]),
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
  final String? place;
  final String? longitude;
  final String? latitude;

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
  final dynamic name;
  final dynamic image;
  final String? phone;
  final String? email;

  Driver({
    this.name,
    this.image,
    this.phone,
    this.email,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    name: json["name"],
    image: json["image"],
    phone: json["phone"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "phone": phone,
    "email": email,
  };
}
