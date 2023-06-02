import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:ugocash/global.dart';
import 'package:ugocash/styles/colors.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class AddBank extends StatefulWidget {
  const AddBank({super.key});

  @override
  State<AddBank> createState() => _AddBankState();
}

class _AddBankState extends State<AddBank> {
  bool agree = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController routingNumberController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController accountnumberController = TextEditingController();
  String? accountId;
  Future<String?> getDwollaAccountId() async {
    // final String apiKey = 'YOUR_DWOLLA_API_KEY';
    // final String apiSecret = 'YOUR_DWOLLA_API_SECRET';

    final String url = 'https://www.ugoya.net/api/root/get';

    final Map<String, String> headers = {
      // 'Authorization': 'Basic ' + base64Encode(utf8.encode('$apiKey:$apiSecret')),
      'Accept': 'application/vnd.dwolla.v1.hal+json',
    };

    final http.Response response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final String accountUrl = responseBody['_links']['account']['href'];
      accountId = accountUrl.split('/').last;
      print('Dwolla API Account ID: $accountId');
      return accountId;
    } else {
      print(
          'Failed to retrieve Dwolla API Account ID. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return '';
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
      "name": bankvalue,
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
      Fluttertoast.showToast(
          msg: "bank linked Successfully.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      showAlertDialog(context);
    } else {
      print('Failed to link bank account. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  List<String> banklist = [
    "City Bank",
    "Bank of America",
  ];
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
            child: Form(
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
                          prefixIcon: Icon(
                            Icons.account_circle,
                            color: AppColors.textColor,
                          ),
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
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,

                          hint: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Select Bank",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                          value: bankvalue,
                          items: banklist
                              .map((bank) => DropdownMenuItem(
                                    value: bank,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(bank,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              bankvalue = value.toString();
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.secondaryColor, width: 2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            height: 50,
                            width: width * 09,
                          ),
                          dropdownStyleData: const DropdownStyleData(
                            decoration:
                                BoxDecoration(color: AppColors.secondaryColor),
                            maxHeight: 200,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                          dropdownSearchData: DropdownSearchData(
                            searchController: searchController,
                            searchInnerWidgetHeight: 50,
                            searchInnerWidget: Container(
                              height: 50,
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 4,
                                right: 8,
                                left: 8,
                              ),
                              child: TextFormField(
                                expands: true,
                                maxLines: null,
                                controller: searchController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  hintText: 'Search for an item...',
                                  hintStyle:
                                      Theme.of(context).textTheme.titleLarge,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                          width: 2.0,
                                          color: AppColors.textColor2)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                          width: 2.0,
                                          color: AppColors.textColor2)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                        width: 2.0,
                                        color: AppColors.textColor2),
                                  ),
                                ),
                              ),
                            ),
                            searchMatchFn: (departmentlist, searchValue) {
                              return (departmentlist.value
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchValue.toLowerCase()));
                            },
                          ),
                          //This to clear the search value when you close the menu
                          onMenuStateChange: (isOpen) {
                            if (!isOpen) {
                              searchController.clear();
                            }
                          },
                        ),
                      ),
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
                              style: Theme.of(context).textTheme.labelMedium,
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
                              style: Theme.of(context).textTheme.labelMedium,
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
                              style: Theme.of(context).textTheme.labelMedium,
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
                                linkBankAccount(GlobalVariables.customerId);
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(14.0),
                              child: Text(
                                'Link Bank',
                                style: TextStyle(
                                    fontSize: 16, color: AppColors.textColor),
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
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons

    Widget continueButton = TextButton(
      child: Text(
        "click & Continue",
        style: Theme.of(context).textTheme.labelMedium,
      ),
      onPressed: () {},
    );
    Widget card = Card(
      child: Container(
        width: 25,
        height: 25,
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: AppColors.secondaryColor,
      actionsAlignment: MainAxisAlignment.center,
      icon: Icon(
        Icons.credit_card,
        size: 40,
      ),
      title: Text("Bank details Added Succesfully"),
      content: Text("Now you can freely pay and shop and Enjoy it"),
      actions: [
        continueButton,
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
