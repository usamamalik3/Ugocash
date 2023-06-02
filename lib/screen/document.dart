import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ugocash/config/routes.dart';
import 'package:ugocash/global.dart';
import 'package:http/http.dart' as http;

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  void requestPermission() async {
    PermissionStatus status = await Permission.camera.request();

    if (status.isGranted) {
      print('Camera permission granted');
    } else if (status.isDenied) {
      Permission.camera.request();
      // Permission is denied
      print('Camera permission denied');
    } else if (status.isPermanentlyDenied) {
      // Permission is permanently denied
      print('Camera permission permanently denied');
    }
  }

  File? licenseDocument;

  void _uploadLicenseDocument() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    var id = GlobalVariables.customerId;
    if (pickedFile != null) {
      setState(() {
        licenseDocument = File(pickedFile.path);
      });

      //     try {
      //       final url = Uri.parse('https://www.ugoya.net/api/$id/document/createForCustomer');
      //       // final request = http.MultipartRequest('POST', url)
      //       //   // ..headers['Authorization'] = 'Bearer YOUR_API_TOKEN'
      //       //   ..files.add(await http.MultipartFile.fromPath('file', licenseDocument!.path));
      // final body = jsonEncode({
      //     "documentType":"license",
      //     "file":licenseDocument!.path,
      //     // Additional customer details can be included here
      //   });
      //       final response = await http.post(url, headers: {}, body: body);
      //       print(response.statusCode);

      //       // Handle the response
      //       print(response.body);
      //     } catch (error) {
      //       // Handle any errors
      //       print('Error uploading license document: $error');
      //     }
      Fluttertoast.showToast(
          msg: "License uploaded Successfully.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
    }
    requestPermission();
    await availableCameras().then(
        (value) => Navigator.pushNamed(context, Routes.kyc, arguments: value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload License"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (licenseDocument != null)
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(licenseDocument!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadLicenseDocument,
              child: Text('Upload License'),
            ),
          ],
        ),
      ),
    );
  }
}
