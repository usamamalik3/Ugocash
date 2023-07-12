import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ugocash/config/database_services.dart';

import 'package:ugocash/config/routes.dart';
import 'package:ugocash/global.dart';
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

Future updateUser() async {
DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("user").doc(user!.uid).get();
if (documentSnapshot.exists) {
  // Map<String, dynamic> userData = documentSnapshot.data() as Map<String, dynamic>;
  
  // // Retrieve the existing values
  // String? email = userData['email'];
  // String? customerId = userData['customerid'];
  // String? fundingId = userData['fundingid'];
  // String? iMEi = userData['iMEi'];
  // String? gender = userData['gender'];
Map<String, dynamic> userdata = {};
  // Update the values
  userdata["imei"] = imeiController.text;
  userdata["gender"] = genderController.text;
  DatabaseServices databaseService=DatabaseServices();

  return await databaseService.updateuser(userdata, user!.uid);

  // Update the 'iMEi' and 'gender' fields in the document

}}

  

  void _uploadLicenseDocument() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    var id = GlobalVariables.customerId;
    if (pickedFile != null) {
      setState(() {
        licenseDocument = File(pickedFile.path);
      });
   

    // Convert the request body to JSON
    // final requestBodyJson = jsonEncode(requestBody);
        final url = Uri.parse('https://www.ugoya.net/api/$id/document/createForCustomer');
   var request = http.MultipartRequest('POST', url);
  // request.headers['Authorization'] = 'Bearer <your_access_token_here>';
  request.fields['documentType'] = "license";
  request.files.add(await http.MultipartFile.fromPath('file', licenseDocument!.path, contentType: MediaType('image', 'jpeg')));
  var response = await request.send();
    

      if (response.statusCode == 200) {
          Fluttertoast.showToast(
              msg: "license uploaded Succesfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
              msg: "license uploaded error",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 16.0);
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
                    updateUser();
                    // Navigator.pushNamedAndRemoveUntil(
                    //     context, Routes.home, (route) => false);
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
