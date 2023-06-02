import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ugocash/config/database_services.dart';
import 'package:ugocash/config/routes.dart';
import 'package:ugocash/global.dart';
import 'package:ugocash/models/user_model.dart';

import '../styles/colors.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:network_info_plus/network_info_plus.dart';
import 'package:image_picker/image_picker.dart';

class SecondRegister extends StatefulWidget {
  const SecondRegister({
    super.key,
    required this.email,
  });
  final String email;

  @override
  State<SecondRegister> createState() => _SecondRegisterState();
}

class _SecondRegisterState extends State<SecondRegister> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phonecontroller = TextEditingController();
  String? countrycode;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController dobcontroller = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;

  String apiKey = 'https://www.ugoya.net/api'; // Dwolla API key
  String documentStatus = '';
  String customerId = '';
  String errorMessage = '';
  Future<String?> fetchCustomerId(
      String firstName, String lastName, String email) async {
    final url = 'https://www.ugoya.net/api/customer/getAll';
    final headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final responseBody = response.body;
      final decodedJson = json.decode(responseBody);

      final embeddedCustomers =
          decodedJson['_embedded']['customers'] as List<dynamic>;

      final matchingCustomer = embeddedCustomers.firstWhere(
        (customer) =>
            customer['firstName'] == firstName &&
            customer['lastName'] == lastName &&
            customer['email'] == email,
        orElse: () => null,
      );

      if (matchingCustomer != null) {
        final customerId = matchingCustomer['id'] as String;
        setState(() {
          GlobalVariables.customerId = customerId;
        });
        return customerId;
      } else {
        print('Matching customer not found');
      }
    } else {
      print('Error fetching customers: ${response.statusCode}');
      print(response.body);
    }

    return null;
  }

  Future<void> createVerifiedPersonalCustomer() async {
    final url = 'https://www.ugoya.net/api/customer/verified/personal';
    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "firstName": firstnameController.text,
      "lastName": lastnameController.text,
      "email": emailController.text,
      "type": "personal",
      "address1": address1Controller.text,
      "city": cityController.text,
      "state": stateController.text,
      "postalCode": zipcodeController.text,
      "dateOfBirth": dobcontroller.text,
      "ssn": "1234"
      // Additional customer details can be included here
    });
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      print('Customer created successfully');
      final responseBody = response.body;
      print(responseBody);
      //   final responseData = jsonDecode(response.body);
      //  final id = responseData['_links']['self']['href']
      //         .split('/')
      //         .last; // Extract the customer ID from the response
      //         setState(() {
      //           GlobalVariables.customerId=id;
      //         });
      fetchCustomerId(firstnameController.text, lastnameController.text,
          emailController.text);
      DatabaseServices databaseService = DatabaseServices();
      UserModel usermodel =
          UserModel(email: widget.email, id: GlobalVariables.customerId);
      databaseService.adduser(usermodel);
      Fluttertoast.showToast(
          msg: "Customer added Successfully.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      // setState(() {
      //   // GlobalVariables.customerId=id;
      // }); // You can parse and use the response data as needed
      Navigator.pushNamed(context, Routes.documentscreen);
    } else {
      print('Error creating customer: ${response.statusCode}');
      print(response.body);
    }
  }

  Future<void> verifyDocument(String filePath) async {
    final url =
        'https://api.dwolla.com/customers/$customerId/documents'; // Dwolla API endpoint for document verification
    // Dwolla API endpoint for creating a customer
    final uri = Uri.parse(url);
    final headers = {
      'Content-Type': 'application/octet-stream',
    };

    // Read the document file and convert it to base64
    final fileBytes = await File(filePath).readAsBytes();
    final base64File = base64Encode(fileBytes);

    final response = await http.post(uri, headers: headers, body: base64File);

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      final status = responseData[
          'status']; // Extract the document verification status from the response

      setState(() {
        documentStatus = status;
      });
    } else {
      setState(() {
        documentStatus =
            'Verification Failed'; // Handle the error case appropriately
      });
    }
  }

  Future<void> createCustomer() async {
    const url =
        'https://www.ugoya.net/api/customer/unverified'; // Dwolla API endpoint for creating a customer
    final uri = Uri.parse(url);
    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'firstName': firstnameController.text,
      'lastName': lastnameController.text,
      'email': widget.email,
      'ipAddress': ipAddress,
      'businessName': businessNameController.text,
      // Additional customer details can be included here
    });

    try {
      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        //      final responseData = jsonDecode(response.body);
        //  final id = responseData['_links']['self']['href']
        //         .split('/')
        //         .last; // Extract the customer ID from the response
        //         setState(() {
        //           GlobalVariables.customerId=id;
        //         });
        print(response.body);

        fetchCustomerId(
            firstnameController.text, lastnameController.text, widget.email);
        DatabaseServices databaseService = DatabaseServices();
        UserModel usermodel =
            UserModel(email: widget.email, id: GlobalVariables.customerId);
        databaseService.adduser(usermodel);
        Fluttertoast.showToast(
            msg: "Customer added Successfully.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
        Navigator.pushNamed(context, Routes.documentscreen);
        setState(() {
          // GlobalVariables.customerId = id;

          errorMessage = '';
        });
      } else {
        setState(() {
          customerId = '';
          errorMessage =
              'Failed to create customer. Error code: ${response.statusCode}';
          print(response.bodyBytes);
        });
      }
    } catch (error) {
      setState(() {
        customerId = '';
        errorMessage = 'Failed to create customer. Error: $error';
        print(errorMessage);
      });
    }
  }

  List<String> usertype = ["Individual", "Business", "Government"];
  String? usertypevalue;
  String ipAddress = '';

  @override
  void initState() {
    super.initState();
    retrieveIpAddress();
  }

  Future<void> retrieveIpAddress() async {
    try {
      final response =
          await http.get(Uri.parse('https://api.ipify.org/?format=json'));
      if (response.statusCode == 200) {
        final ipAddressJson = response.body;
        final ipAddressData = ipAddressJson.replaceAll(RegExp('[^0-9.]'), '');
        setState(() {
          ipAddress = ipAddressData;
          print(ipAddress);
        });
      } else {
        setState(() {
          ipAddress = 'Error';
        });
      }
    } catch (e) {
      setState(() {
        ipAddress = 'Error';
      });
    }
  }

  bool value = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Fill up the other Information to complete",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      "Registeration! ",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: firstnameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "First name",
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "First name",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: lastnameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "Last name",
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Last name",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    style: Theme.of(context).textTheme.labelMedium,
                    decoration: InputDecoration(
                        hintText: "Account Type",
                        hintStyle: Theme.of(context).textTheme.labelMedium),
                    focusColor: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(12),
                    dropdownColor: AppColors.secondaryColor,
                    iconEnabledColor: AppColors.textColor,
                    isExpanded: true,
                    alignment: AlignmentDirectional.bottomEnd,
                    value: usertypevalue,
                    items: usertype.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(
                          e.toString(),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        usertypevalue = newValue.toString();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //        ElevatedButton(
                  //   child: Text('Upload Document'),
                  //   onPressed: () async {
                  //     document = await FilePicker.pickImage(source: ImageSource.gallery);
                  //   },
                  // ),
                  // ElevatedButton(
                  //   child: Text('Verify Document'),
                  //   onPressed: () async {
                  //     if (customerId == null || document == null) {
                  //       return;
                  //     }

                  //     var response = await dwolla.customers.documents.upload(
                  //       customerId: customerId,
                  //       documentType: documentType,
                  //       document: document,
                  //     );

                  //     if (response.statusCode == 200) {
                  //       print('Document verified successfully');
                  //     } else {
                  //       print('Error verifying document: ${response.statusCode}');
                  //     }
                  //   },),
                  TextFormField(
                    controller: businessNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Bussiness name",
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Bussiness name",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      /** Checkbox Widget **/
                      Checkbox(
                        value: value,
                        onChanged: (valuee) {
                          setState(() {
                            value = valuee!;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ), //SizedBox
                      const Text(
                        'click here to be verified',
                        style: TextStyle(fontSize: 17.0),
                      ), //Text
                      SizedBox(width: 10), //SizedBox
                      //Checkbox
                    ], //<Widget>[]
                  ),
                  value == true
                      ? Column(
                          children: [
                            TextFormField(
                              controller: address1Controller,
                              keyboardType: TextInputType.streetAddress,
                              decoration: InputDecoration(
                                hintText: "Address1",
                                label: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Address1",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: address2Controller,
                              keyboardType: TextInputType.streetAddress,
                              decoration: InputDecoration(
                                hintText: "Address2",
                                label: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Address2",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: cityController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "Delhi",
                                label: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "City",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: zipcodeController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "12345",
                                label: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Zip code",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: stateController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "Punjab",
                                label: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "State",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: countryController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "India",
                                label: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Country",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            IntlPhoneField(
                              initialCountryCode: "US",
                              dropdownTextStyle:
                                  Theme.of(context).textTheme.labelMedium,
                              controller: phonecontroller,
                              style: Theme.of(context).textTheme.labelMedium,
                              decoration: InputDecoration(
                                labelStyle:
                                    Theme.of(context).textTheme.labelMedium,
                                labelText: 'Phone Number',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                        width: 2.0,
                                        color: AppColors.secondaryColor)),
                              ),
                              onChanged: (phone) {
                                print(phone.completeNumber);
                                setState(() {
                                  countrycode = phone.countryCode;
                                });
                              },
                              onCountryChanged: (country) {
                                print('Country changed to: ' + country.name);
                              },
                            ),
                          ],
                        )
                      : Container(),
                  // SizedBox(width: 20,),
                  Center(
                    child: SizedBox(
                      width: width * 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          // _loginWithPhoneNumber(phonecontroller.text);
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            value == false
                                ? createCustomer()
                                : createVerifiedPersonalCustomer();
                          }
                          // Navigator.pushReplacementNamed(context, "/login");
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                                fontSize: 16, color: AppColors.textColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
