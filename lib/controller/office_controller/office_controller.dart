import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/model/office_expanse/office_expanse.dart';
import 'package:vendor/utility/app_const.dart';
import 'package:vendor/view_controller/app_snackbar.dart';

class OfficeController{

  //add office expanse
  static Future<bool> addOfficeExpanse({
    required BuildContext context,
  required String date,
  required String amount,
  required String details,
})async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var userId = _pref.getString("id");
    final firestore.CollectionReference<Map<String, dynamic>> collectionRef =
    firestore.FirebaseFirestore.instance.collection('office_expanse');

    try{

      // Reference to the specific document using the userId
      DocumentReference<Map<String, dynamic>> documentRef = collectionRef.doc(userId);

      // Retrieve the current data
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await documentRef.get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Extract the current data
        Map<String, dynamic> currentData = documentSnapshot.data() ?? {};

        // Extract the current list of expenses
        List<dynamic> currentExpenseList = currentData['expanse_list'] ?? [];

        // Create a new expense item
        Map<String, dynamic> newExpenseItem = {
          'date': date,
          'amount': amount,
          'details': details,
        };

        // Add the new expense item to the list
        currentExpenseList.add(newExpenseItem);

        // Update the data with the new list of expenses
        currentData['expanse_list'] = currentExpenseList;

        // Set the updated data back to the document
        await documentRef.set(currentData);

        AppSnackBar.appSnackBar("Expanse added.", Colors.green, context);
        print('Expense item added successfully!');
        return true;

      }else{
        final data = {
          "expanse_list": [
            {
              "date": date,
              "amount": amount,
              "details": details,
            }
          ],
        };

        await collectionRef.doc("${userId}").set(data);
        print('Data added to Firestorm!');
        AppSnackBar.appSnackBar("Expanse added.", Colors.green, context);

        return true;
      }
    }catch(e){
      print("error in adding == ${e}");
      AppSnackBar.appSnackBar("Something went wrong. Please try again.", Colors.red, context);

      return false;
    }



  }

  //edit office expanse
  static Future editOfficeExpnase({
    required BuildContext context,
    required Map<String, dynamic> updatedData,
    required int index
  })async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var userId = _pref.getString("id");
    final firestore.CollectionReference<Map<String, dynamic>> collectionRef =
    firestore.FirebaseFirestore.instance.collection('office_expanse');

    // Reference to the specific document using the userId
    DocumentReference<Map<String, dynamic>> documentRef = collectionRef.doc(userId);

    // Retrieve the current data
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await documentRef.get();


    try{
    // Check if the document exists
    if (documentSnapshot.exists) {
      // Extract the current data
      Map<String, dynamic> currentData = documentSnapshot.data() ?? {};

      // Extract the current list of expenses
      List<dynamic> currentExpenseList = currentData['expanse_list'] ?? [];

      // Add the new expense item to the list
      currentExpenseList[index] = updatedData;

      // Update the data with the new list of expenses
      currentData['expanse_list'] = currentExpenseList;

      // Set the updated data back to the document
      await documentRef.set(currentData);

      AppSnackBar.appSnackBar(
          "Document updated successfully", Colors.green, context);
      print('Expense item added successfully!');
      return true;

    }


  } catch(e) {
        print('Invalid index or no documents in the collection. $e');
        AppSnackBar.appSnackBar("Something went wrong.", Colors.red, context);
      }
    }


  //add office expance cose
  static Future<bool> addOfficeExpanseCoses({required String coses, required BuildContext context})async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var userId = _pref.getString("id");
    final firestore.CollectionReference<Map<String, dynamic>> collectionRef =
    firestore.FirebaseFirestore.instance.collection('office_expanse');
    var date = DateTime.now();
    try{

      // Reference to the specific document using the userId
      DocumentReference<Map<String, dynamic>> documentRef = collectionRef.doc(userId);

      // Retrieve the current data
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await documentRef.get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Extract the current data
        Map<String, dynamic> currentData = documentSnapshot.data() ?? {};

        // Extract the current list of expenses
        List<dynamic> currentExpenseList = currentData['coses_list'] ?? [];

        // Create a new expense item
        Map<String, dynamic> newExpenseItem = {
          'coses': coses,
          "date" : DateFormat('yyyy-MM-dd').format(date)
        };

        // Add the new expense item to the list
        currentExpenseList.add(newExpenseItem);

        // Update the data with the new list of expenses
        currentData['coses_list'] = currentExpenseList;

        // Set the updated data back to the document
        await documentRef.set(currentData);

        AppSnackBar.appSnackBar("Expanse added.", Colors.green, context);
        print('Expense item added successfully!');
        return true;

      }else{
        final data = {
          "coses_list": [
            {
              "coses": coses,
              "date" : DateFormat('yyyy-MM-dd').format(date)
            }
          ],
        };

        await collectionRef.doc("${userId}").set(data);
        print('Data added to Firestorm!');
        AppSnackBar.appSnackBar("Expanse added.", Colors.green, context);

        return true;
      }
    }catch(e){
      print("e ==== ${e}");
      AppSnackBar.appSnackBar("Something went wrong. Please try again.", Colors.red, context);

      return false;
    }
  }



  //add office expanse
  static Future<OfficeExpanseListModel> getOfficeExpanse({required BuildContext context})async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var userId = _pref.getString("id");
    final firestore.CollectionReference<Map<String, dynamic>> collectionRef =
    firestore.FirebaseFirestore.instance.collection('office_expanse');
      // Reference to the specific document using the userId
      DocumentReference<Map<String, dynamic>> documentRef = collectionRef.doc(userId);

      // Retrieve the current data
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await documentRef.get();

      // Check if the document exists
      // Extract the current data
      Map<String, dynamic> currentData = documentSnapshot.data() ?? {};

      // Extract the current list of expenses
      List<dynamic> currentExpenseList = currentData['expanse_list'] ?? [];
      return OfficeExpanseListModel.fromJson(currentData);



  }

}