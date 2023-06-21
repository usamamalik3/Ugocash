import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:ugocash/global.dart';
import 'package:ugocash/styles/colors.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../models/fundingsourcemodel.dart';

class AddBank extends StatefulWidget {
  const AddBank({super.key, required this.customerId});
  final String customerId;
  @override
  State<AddBank> createState() => _AddBankState();
}

class _AddBankState extends State<AddBank> {
  bool agree = false;
  bool initiated = false;
  bool verified = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController routingNumberController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController accountnumberController = TextEditingController();
  Future<void> initiatemicrodeposit(fundingID) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://www.ugoya.net/api/$fundingID/fundingSources/intiateMicroDeposit'));
    request.body = '''''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      showBottomSheet(context, fundingID);
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> verifyMicroDepositVerification(id) async {
    // Replace with your Dwolla API credentials

    // Generate two random micro deposit amounts
    double microDeposit1 = 0.05;
    double microDeposit2 = 0.09;

    // Build the request body
    Map<String, dynamic> requestBody = {
      "amount1": {"value": microDeposit1, "currency": "USD"},
      "amount2": {"value": microDeposit2, "currency": "USD"}
    };

    // Convert the request body to JSON
    String requestBodyJson = jsonEncode(requestBody);

    // Construct the API endpoint URL
    String url =
        'https://www.ugoya.net/api/$id/fundingSources/verifyMicroDeposit';

    // Prepare the request headers
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      // Send the API request

      var response = await http.post(Uri.parse(url),
          headers: headers, body: requestBodyJson);

      // Handle the API response
      if (response.statusCode == 200) {
        // Micro deposits initiated successfully
        Navigator.of(context).pop();
        Fluttertoast.showToast(
          msg: response.body,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        print('Micro deposits verified successfully');
      } else {
        // Error occurred
        print(
            'Error verificating micro deposits: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  Future<void> linkBankAccount(String customerId) async {
    final String baseUrl = 'https://www.ugoya.net/api';
    final String endpoint = '/$customerId/fundingSources/createForCustomer';
    final String url = baseUrl + endpoint;

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      "routingNumber": routingNumberController.text,
      "accountNumber": accountnumberController.text,
      "bankAccountType": "checking",
      "name": firstnameController.text,
      // Additional customer details can be included here
    });

    // final Map<String, dynamic> data = {
    //    "routingNumber": "222222226",
    // "accountNumber": "123456789",
    // "bankAccountType": "checking",
    // "name": "Jane Doe’s Checking",
    //   // Additional parameters if required
    // };

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final id = response.body.split('/').last;

      showAlertDialog(context, id);
      initiatemicrodeposit(id);
    } else {
      print('Failed to link bank account. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  String? bankvalue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Link Bank account"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          "assets/images/bank.png",
                          width: width * 0.9,
                          height: height * .2,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "Account Holder",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: firstnameController,
                            keyboardType: TextInputType.name,
                            validator: RequiredValidator(errorText: "Required"),
                            decoration: InputDecoration(
                              hintText: "Jack",
                              prefixIcon: Icon(
                                Icons.account_circle,
                                color: AppColors.textColor,
                              ),
                              label: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Account Holder First name",
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
                            controller: lastnameController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              hintText: "Last name",
                              prefixIcon: Icon(
                                Icons.account_circle,
                                color: AppColors.textColor,
                              ),
                              label: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Last name",
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                            ),
                          ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          // DropdownButtonHideUnderline(
                          //   child: DropdownButton2<String>(
                          //     isExpanded: true,

                          //     hint: Padding(
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: Text(
                          //         "Select Bank",
                          //         style: Theme.of(context).textTheme.labelMedium,
                          //       ),
                          //     ),
                          //     value: bankvalue,
                          //     items: banklist
                          //         .map((bank) => DropdownMenuItem(
                          //               value: bank,
                          //               child: Padding(
                          //                 padding: const EdgeInsets.all(8.0),
                          //                 child: Text(bank,
                          //                     style: Theme.of(context)
                          //                         .textTheme
                          //                         .labelMedium),
                          //               ),
                          //             ))
                          //         .toList(),
                          //     onChanged: (value) {
                          //       setState(() {
                          //         bankvalue = value.toString();
                          //       });
                          //     },
                          //     buttonStyleData: ButtonStyleData(
                          //       decoration: BoxDecoration(
                          //         border: Border.all(
                          //             color: AppColors.secondaryColor, width: 2),
                          //         borderRadius: BorderRadius.circular(12),
                          //       ),
                          //       height: 50,
                          //       width: width * 09,
                          //     ),
                          //     dropdownStyleData: const DropdownStyleData(
                          //       decoration:
                          //           BoxDecoration(color: AppColors.secondaryColor),
                          //       maxHeight: 200,
                          //     ),
                          //     menuItemStyleData: const MenuItemStyleData(
                          //       height: 40,
                          //     ),
                          //     dropdownSearchData: DropdownSearchData(
                          //       searchController: searchController,
                          //       searchInnerWidgetHeight: 50,
                          //       searchInnerWidget: Container(
                          //         height: 50,
                          //         padding: const EdgeInsets.only(
                          //           top: 8,
                          //           bottom: 4,
                          //           right: 8,
                          //           left: 8,
                          //         ),
                          //         child: TextFormField(
                          //           expands: true,
                          //           maxLines: null,
                          //           controller: searchController,
                          //           decoration: InputDecoration(
                          //             i20sDense: true,
                          //             contentPadding: const EdgeInsets.symmetric(
                          //               horizontal: 10,
                          //               vertical: 8,
                          //             ),
                          //             hintText: 'Search for an item...',
                          //             hintStyle:
                          //                 Theme.of(context).textTheme.titleLarge,
                          //             focusedBorder: OutlineInputBorder(
                          //                 borderRadius: BorderRadius.circular(16),
                          //                 borderSide: const BorderSide(
                          //                     width: 2.0,
                          //                     color: AppColors.textColor2)),
                          //             enabledBorder: OutlineInputBorder(
                          //                 borderRadius: BorderRadius.circular(16),
                          //                 borderSide: const BorderSide(
                          //                     width: 2.0,
                          //                     color: AppColors.textColor2)),
                          //             border: OutlineInputBorder(
                          //               borderRadius: BorderRadius.circular(16),
                          //               borderSide: const BorderSide(
                          //                   width: 2.0,
                          //                   color: AppColors.textColor2),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       searchMatchFn: (departmentlist, searchValue) {
                          //         return (departmentlist.value
                          //             .toString()io
                          //             .toLowerCase()
                          //             .contains(searchValue.toLowerCase()));
                          //       },
                          //     ),
                          //     //This to clear the search value when you close the menu
                          //     onMenuStateChange: (isOpen) {
                          //       if (!isOpen) {
                          //         searchController.clear();
                          //       }
                          //     },
                          //   ),
                          // ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: routingNumberController,
                            keyboardType: TextInputType.number,
                            validator: RequiredValidator(errorText: "Required"),
                            decoration: InputDecoration(
                              hintText: "Routing",
                              prefixIcon: const Icon(
                                Icons.code,
                                color: AppColors.textColor,
                              ),
                              label: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Routing",
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
                            controller: accountnumberController,
                            keyboardType: TextInputType.number,
                            validator: RequiredValidator(errorText: "Required"),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.credit_card,
                                color: AppColors.textColor,
                              ),
                              hintText: "145362489",
                              label: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Account Number",
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
                            controller: searchController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.account_circle_rounded,
                                color: AppColors.textColor,
                              ),
                              hintText: "username",
                              label: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "User Name",
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
                            controller: searchController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.password,
                                color: AppColors.textColor,
                              ),
                              hintText: "********",
                              label: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Password",
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: agree,
                                activeColor: AppColors.secondaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    agree = value ?? false;
                                  });
                                },
                              ),
                              Text(
                                "Save this info",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: SizedBox(
                              width: width * 0.5,
                              child: ElevatedButton(
                                onPressed: () {
                                  // _loginWithPhoneNumber(phonecontroller.text);
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    // _loginWithPhoneNumber(phonecontroller.text);
                                    linkBankAccount(widget.customerId);
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(14.0),
                                  child: Text(
                                    'Link Bank',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.textColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context, id) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Confirm two Micro-deposit of 0.05\$ and 0.09\$ to verify your bank account',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Close the bottom sheet
                  verifyMicroDepositVerification(id);
                },
                child: Text('Verify'),
              ),
            ],
          ),
        );
      },
    );
  }

  showAlertDialog(BuildContext context, id) {
    // set up the buttons

    Widget continueButton = TextButton(
      child: Text(
        "Verify micro-deposit",
        style: Theme.of(context).textTheme.labelMedium,
      ),
      onPressed: () {
        verifyMicroDepositVerification(id);
      },
    );
    Widget card = Card(
      child: Container(
        width: 25,
        height: 25,
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = const AlertDialog(
      backgroundColor: AppColors.secondaryColor,
      actionsAlignment: MainAxisAlignment.center,
      icon: Icon(
        Icons.credit_card,
        size: 40,
      ),
      title: Text("initiating microdeposit to verify"),
      actions: [
        Center(child: SizedBox(width: 50, child: CircularProgressIndicator(color: AppColors.textColor2,),))
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
