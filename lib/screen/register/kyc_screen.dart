import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
import 'package:device_info/device_info.dart';

class GenderIMEIScreen extends StatefulWidget {
  const GenderIMEIScreen({super.key});

  @override
  _GenderIMEIScreenState createState() => _GenderIMEIScreenState();
}

class _GenderIMEIScreenState extends State<GenderIMEIScreen> {
  TextEditingController genderController = TextEditingController();
  TextEditingController imeiController = TextEditingController();
  String gender = '';
  String imei = '';
  File? licenseDocument;
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  String? customerId;
  getuser() async {
    if (user != null) {
      final DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('user')
          .doc(user!.uid)
          .get();

      setState(() {
        customerId = snap["customerid"];
      });
    }
  }

  void _uploadLicenseDocument() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    var id = GlobalVariables.customerId;
    if (pickedFile != null) {
      setState(() {
        licenseDocument = File(pickedFile.path);
      });
      var headers = {
        'Accept': 'application/vnd.dwolla.v1.hal+json',
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://www.ugoya.net/api/82bcfc0a-b3a0-4f65-8f2c-01cf5925df48/document/createForCustomer'));
      request.fields.addAll({'documentType': 'license'});
      request.files
          .add(await http.MultipartFile.fromPath('file', pickedFile.path));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    }
    //  Navigator.pushNamed(context, Routes.kyc, arguments: value);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KYC question'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: genderController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: "Gender",
                label: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Gender",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: imeiController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: "IMEI",
                label: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "IMEI",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.home, (route) => false);
                    // Navigator.pushReplacementNamed(context, Routes.home);
                    // fetchIMEI();
                  },
                  child: Text(
                    'Next',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ],
            ),

            SizedBox(height: 8.0),
            // Text('IMEI: $imei'),
          ],
        ),
      ),
    );
  }

  Future<void> fetchIMEI() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      setState(() {
        imei = androidInfo.androidId;
      });
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      setState(() {
        imei = iosInfo.identifierForVendor;
      });
    }
  }
}
