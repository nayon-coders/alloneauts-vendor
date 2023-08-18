// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final bool success;
  final String status;
  final int statusCode;
  final String message;
  final Api api;
  final Data data;

  LoginModel({
    required this.success,
    required this.status,
    required this.statusCode,
    required this.message,
    required this.api,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
  final String token;
  final User user;

  Data({
    required this.token,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user": user.toJson(),
  };
}

class User {
  final int id;
  final String image;
  final String name;
  final String username;
  final String email;
  final String phone;
  final DateTime dateOfBirth;
  final dynamic gender;
  final dynamic address;
  final int useEmailForContact;

  User({
    required this.id,
    required this.image,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    required this.useEmailForContact,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    image: json["image"],
    name: json["name"],
    username: json["username"],
    email: json["email"],
    phone: json["phone"],
    dateOfBirth: DateTime.parse(json["date_of_birth"]),
    gender: json["gender"],
    address: json["address"],
    useEmailForContact: json["use_email_for_contact"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "name": name,
    "username": username,
    "email": email,
    "phone": phone,
    "date_of_birth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "address": address,
    "use_email_for_contact": useEmailForContact,
  };
}
