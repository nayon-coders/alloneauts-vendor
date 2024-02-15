import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:image_picker_web/image_picker_web.dart';
import 'package:intl/intl.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method
import 'package:firebase_storage/firebase_storage.dart';

  double defaultPadding = 50;

  class AppConst{

    static String converDate(date){

      // Parse the input date string
      DateTime inputDate = DateFormat("dd-MM-yyyy HH:mm:ss").parse(date);

      // Format the date in the desired output format
      String outputDateString = DateFormat("yyyy-MM-dd").format(inputDate);

      return outputDateString;
    }

    //incription password
    static String encryptPassword(String password) {
      final bytes = utf8.encode(password);
      final hash = sha256.convert(bytes);
      return hash.toString();
    }

    //conver image for firebase
    static Future<String> uploadImageToFirebaseStorage(Uint8List imageFile, String pathName) async {
      try {
        var storageReference = FirebaseStorage.instance.ref().child('$pathName/${DateTime.now().millisecondsSinceEpoch}');
        var uploadTask = storageReference.putData(imageFile);
        var downloadUrl = await (await uploadTask).ref.getDownloadURL();
        print("downloadUrl file == ${downloadUrl}");
        return downloadUrl;
      } catch (e) {
        print('Error uploading image to Firebase Storage: $e');
        return '';
      }
    }


  }