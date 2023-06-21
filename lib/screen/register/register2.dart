import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ugocash/config/database_services.dart';
import 'package:ugocash/config/routes.dart';
import 'package:ugocash/global.dart';
import 'package:ugocash/models/user_model.dart';


import '../../styles/colors.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:network_info_plus/network_info_plus.dart';
import 'package:image_picker/image_picker.dart';

class SecondRegister extends StatefulWidget {
  const SecondRegister({
    super.key,
    this.pin,
    this.email,
  });
  final String? pin;
  final String? email;

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
  TextEditingController pincontroller = TextEditingController();
  TextEditingController businessClassificationController = TextEditingController();
  TextEditingController businessTypeController = TextEditingController();

  TextEditingController einController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;

  String apiKey = 'https://www.ugoya.net/api'; // Dwolla API key
  String documentStatus = '';
  String customerId = '';
  String errorMessage = '';
  String? fundingid;



  Future<String> getFundingSource(String customerId) async {
    final url =
        'https://www.ugoya.net/api/$customerId/fundingSources/forCustomer/get';

    final response = await http.get(
      Uri.parse(url),
      headers: {},
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      print(responseBody);
      // Extract the balance link from the funding-sources list
      String balanceLink = responseBody[0]['_links']['balance']['href'];
// Find the position of the second-to-last slash
      fundingid = balanceLink.split("/")[4];
      DatabaseServices databaseService = DatabaseServices();
      UserModel usermodel = UserModel(
          email: emailController.text,
          customerid: GlobalVariables.customerId,
          fundingid: fundingid);
      databaseService.adduser(usermodel);

      // Print the extracted segment
      print('fundingid: $fundingid');
      // Print the extracted balance link
      print('Balance Link: $balanceLink');
      return fundingid!;
    } else {
      throw Exception('Failed to fetch funding sources');
    }
  }

  Future<void> createVerifiedPersonalCustomer() async {
    String email = emailController.text;
    final url = 'https://www.ugoya.net/api/customer/verified/personal';
    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "firstName": firstnameController.text,
      "lastName": lastnameController.text,
      "email":widget.email!="" ? widget.email:emailController.text,
      "ipAddress": ipAddress,
      "type": "personal",
      "address1": address1Controller.text,
      "city": cityController.text,
      "state": stateController.text,
      "postalCode": zipcodeController.text,
      "dateOfBirth": "1970-01-01",
      "ssn": widget.pin!= "" ? widget.pin: pincontroller.text,
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
      // final responseData = jsonDecode(response.body);
      final id = responseBody
          .split('/')
          .last; // Extract the customer ID from the response
      setState(() {
        GlobalVariables.customerId = id;
      });
      // fetchCustomerId(firstnameController.text, lastnameController.text, email);
      getFundingSource(id);
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
      requestPermission();
      await availableCameras().then((value) =>
          Navigator.pushNamed(context, Routes.kyc, arguments: value));
    } else if (response.statusCode == 400) {
      final jsonData = jsonDecode(response.body);
      final embedded = jsonData["body"]['_embedded'];

      if (embedded != null && embedded.containsKey('errors')) {
        final errors = embedded['errors'];
        if (errors.isNotEmpty && errors[0]['code'] == 'Invalid') {
          final errorMessage = errors[0]['message'];
          Fluttertoast.showToast(
            msg: errorMessage,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0,
          );

          return;
        }
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Error creating customer',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );

      print('Error creating customer: ${response.statusCode}');
      print(response.body);
    }
  }

  Future<void> verifyDocument(String filePath) async {
    final url =  'https://api.dwolla.com/customers/$customerId/documents'; // Dwolla API endpoint for document verification
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
      final status = responseData['status']; // Extract the document verification status from the response

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

  Future<void> createbussinesCustomer() async {
    const url =        'https://www.ugoya.net/api/customer/verified/business'; // Dwolla API endpoint for creating a customer
    final uri = Uri.parse(url);
    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
     "firstName": firstnameController.text,
    "lastName": lastnameController.text,
    "email":widget.email!="" ? widget.email:emailController.text,
    "ipAddress": ipAddress,
    "type": "business",
    "dateOfBirth": "1980-01-31",
    "ssn": pincontroller.text,
    "address1": address1Controller.text,
    "city": cityController.text,
    "state": stateController.text,
    "postalCode": zipcodeController.text,
    "businessClassification": "9ed3f670-7d6f-11e3-b1ce-5404a6144203",
    "businessType": "soleProprietorship",
    "businessName": businessNameController.text,
    "ein": einController.text
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
        final responseBody = response.body;
        final id = responseBody
            .split('/')
            .last; // Extract the customer ID from the response
        setState(() {
          GlobalVariables.customerId = id;
        });
        // fetchCustomerId(firstnameController.text, lastnameController.text, email);
        // getFundingSource(id);

        getFundingSource(id);
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
      requestPermission();
      await availableCameras().then((value) =>
          Navigator.pushNamed(context, Routes.kyc, arguments: value));
  
        setState(() {
          // GlobalVariables.customerId = id;

          errorMessage = '';
        });
      }
      else if (response.statusCode == 400) {
        print(response);
        print(response.body);
      final jsonData = jsonDecode(response.body);
      final embedded = jsonData["body"]['_embedded'];

      if (embedded != null && embedded.containsKey('errors')) {
        final errors = embedded['errors'];
        if (errors.isNotEmpty && errors[0]['code'] == 'Invalid') {
          final errorMessage = errors[0]['message'];
          Fluttertoast.showToast(
            msg: errorMessage,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0,
          );

          return;
        }
      }
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

                  widget.email == null || widget.email == ""
                      ? Column(
                          children: [
                            TextFormField(
                              controller: emailController,
                              validator: MultiValidator(
                                [
                                  EmailValidator(errorText: "errorText"),
                                  RequiredValidator(errorText: "Required")
                                ],
                              ),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: "abc@gmail.com",
                                label: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Email",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      : Container(),
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
                  widget.pin == ""
                      ? Column(
                          children: [
                            TextFormField(
                              controller: pincontroller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "****",
                                label: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Pin code",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      : Container(),

                  TextFormField(
                    controller: businessNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Business name",
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Business name",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Row(
                  //   children: [
                  //     /** Checkbox Widget **/
                  //     Checkbox(
                  //       value: value,
                  //       onChanged: (valuee) {
                  //         setState(() {
                  //           value = valuee!;
                  //         });
                  //       },
                  //     ),
                  //     const SizedBox(
                  //       width: 10,
                  //     ), //SizedBox
                  //     const Text(
                  //       'click here to be verified',
                  //       style: TextStyle(fontSize: 17.0),
                  //     ), //Text
                  //     SizedBox(width: 10), //SizedBox
                  //     //Checkbox
                  //   ], //<Widget>[]
                  // ),
                  Column(
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
                              style: Theme.of(context).textTheme.labelMedium,
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
                              style: Theme.of(context).textTheme.labelMedium,
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
                          hintText: "New york",
                          label: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "City",
                              style: Theme.of(context).textTheme.labelMedium,
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
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                        ],
                        controller: stateController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "NY",
                          label: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "State",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                     usertypevalue== "Business"?  Column(
                         children: [
                           TextFormField(
                            
                            controller: businessClassificationController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintStyle:  Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.grey),
                              hintText: "9ed3f670-7d6f-11e3-b1ce-5404a6144203",
                              label: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Business Classification",
                                  style: Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                            ),
                      ),
                      SizedBox(height: 10,),
                       TextFormField(
                            inputFormatters: [
                              _EinInputFormatter(),
                            ],
                            controller: einController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "00-0000000",
                              label: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Ein",
                                  style: Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                            ),
                      ),
                         ],
                       ): Container(),
                      
                    ],
                  ),

                  // SizedBox(width: 20,),
                  Center(
                    child: SizedBox(
                      width: width * 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          // _loginWithPhoneNumber(phonecontroller.text);
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                          usertypevalue=="Business"? createbussinesCustomer()  :createVerifiedPersonalCustomer();
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

class _EinInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String formattedText = '';
    int selectionIndex = newValue.selection.end;

    // Remove all non-digit characters
    String cleanText = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (cleanText.isNotEmpty) {
      // Add the first two digits
      formattedText += cleanText.substring(0, 2);

      // Add a hyphen after the second digit if there are more digits
      if (cleanText.length > 2) {
        formattedText += '-';
      }

      // Add the remaining digits with groups of 6
      int remainingLength = cleanText.length - 2;
      for (int i = 0; i < remainingLength; i += 6) {
        int endIndex = i + 6;
        if (endIndex > remainingLength) {
          endIndex = remainingLength;
        }
        formattedText += cleanText.substring(i + 2, endIndex);
        if (endIndex != remainingLength) {
          formattedText += '-';
        }
      }
    }

    selectionIndex += formattedText.length - newValue.text.length;

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
