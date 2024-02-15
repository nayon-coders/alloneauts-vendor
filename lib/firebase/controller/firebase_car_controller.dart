import 'package:cloud_firestore/cloud_firestore.dart';import 'package:firebase_auth/firebase_auth.dart';import 'package:flutter/cupertino.dart';import '../model/firebase_car_model.dart';class FirebaseCarRentController{  ///  ///  /// '=============== firebase instance =====  static final FirebaseAuth _auth = FirebaseAuth.instance;  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;  ///////// ======== add car for vendor ===============  static Future<bool> addCar({required Map<String,dynamic> data, required BuildContext context})async{    try{      ///      /// ========== existing data ====      DocumentSnapshot<Map<String, dynamic>> existingData = await _firestore.collection("vendor").doc("vendor_${_auth.currentUser!.email}").collection("cars").doc("cars").get();      ///      /// ======== Now check, if the existing data is exist or not ===========      if(existingData.exists){        //make a car list to store existing        List existingCarList = existingData.data()!["cars"];        //create a new list for update data        List updateList = [];        //assign the existing data into the new list        updateList = existingCarList;        //now add update data from vendor        updateList.add(            {              "active_status" : true,              "assign_status" : false,              "car_info" : {                "name" : "${data!["cars"][0]["car_info"]["name"]}",                "plate_no" : data!["cars"][0]["car_info"]["plate_no"],                "price" : data!["cars"][0]["car_info"]["price"],                "vmake" : data!["cars"][0]["car_info"]["vmake"],                "vmodel" : data!["cars"][0]["car_info"]["vmodel"],                "vyear" : data!["cars"][0]["car_info"]["vyear"],                "vcolor" : data!["cars"][0]["car_info"]["vcolor"],                "vtrim" : data!["cars"][0]["car_info"]["vtrim"],                "location" : data!["cars"][0]["car_info"]["location"],                "latitude" : "23.727009",                "longitude" : "90.4219455",                "email" : data!["cars"][0]["car_info"]["email"],                "contact" : data!["cars"][0]["car_info"]["phone"],                "mileage" : data!["cars"][0]["car_info"]["mileage"],                "images" : {                  "carImage" : data!["cars"][0]["car_info"]["images"]["carImage"],                  "driverDiclaration" : data!["cars"][0]["car_info"]["images"]["driverDiclaration"],                  "fh1" : data!["cars"][0]["car_info"]["images"]["fh1"],                  "insurance": data!["cars"][0]["car_info"]["images"]["insurance"],                },              },              "vendor_info" : {                "vendor_id" : "vendor_${_auth!.currentUser!.email}"              },              "assign_driver_info" : {},              "create_at" :  data!["cars"][0]["create_at"]            }        );        //now make a map type variable to upload this into the firebase        var updateData = {          "cars" : updateList        };        ///====== now store update list into firebase =======        await _firestore.collection("vendor").doc("vendor_${_auth.currentUser!.email}").collection("cars").doc("cars").set(updateData);      }else{        await _firestore.collection("vendor").doc("vendor_${_auth.currentUser!.email}").collection("cars").doc("cars").set(data);      }      return true;    }catch(e){      return false;    }  }  ///////// =========== get all car  static Future<FirebaseCarModel> getAllCar()async{    DocumentSnapshot<Map<String, dynamic>> existingData = await _firestore.collection("vendor").doc("vendor_${_auth.currentUser!.email}").collection("cars").doc("cars").get();    Map<String, dynamic> data = existingData.data()!  as Map<String, dynamic>;    print("data ====== ${data}");    return FirebaseCarModel.fromJson(data);  }}