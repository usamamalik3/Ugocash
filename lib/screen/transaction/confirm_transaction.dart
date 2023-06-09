import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ugocash/config/routes.dart';
import 'package:ugocash/global.dart';
import 'package:ugocash/styles/colors.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ConfirmTranscation extends StatefulWidget {
  ConfirmTranscation(
      {super.key,
      required this.amount,
      required this.name,
      required this.email});

  final String name;
  final double amount;
  final String email;

  @override
  State<ConfirmTranscation> createState() => _ConfirmTranscationState();
}

class _ConfirmTranscationState extends State<ConfirmTranscation> {
  TextEditingController pincontroller = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  String? fundingid;
  String? desfundingid;
  double transactionAmount = 5000;
  double fee = 0;
  String? ipAddress = "";
  bool isAmount10K = false;
  String? pin;

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

  void launchEmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'getpaid1@yahoo.com',
      query:
          'subject=Payment request&body=Transaction of ${widget.amount} from a customer having  ',
    );

    final String url = params.toString();
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch email';
    }
  }

  void calculateFee() {
    if (widget.amount <= 4999) {
      fee = 2.25;
    } else if (widget.amount <= 9999) {
      fee = 2.99;
    } else if (widget.amount >= 10000) {
      // Send email to getpaid1@yahoo.com
      setState(() {
        isAmount10K = true;
      });
      retrieveIpAddress();
      launchEmail();
      // launchUrl('mailto:getpaid1@yahoo.com?subject=Payment Request');
      return;
    }

    fee += widget.amount * 0.0203;
  }

  getuser() async {
    if (user != null) {
      final DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('user')
          .doc(user!.uid)
          .get();

      setState(() {
        fundingid = snap["fundingid"];
        pin = snap["pin"];
      });
    }
  }

  Future<String?> fetchCustomerId(String email) async {
    const url = 'https://www.ugoya.net/api/customer/getAll';
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
        (customer) => customer['email'] == email,
        orElse: () => null,
      );

      if (matchingCustomer != null) {
        final customerId = matchingCustomer['id'] as String;
        getFundingSource(customerId);
        // setState(() {
        //   descustomerrid = customerId;
        // });
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
      desfundingid = balanceLink.split("/")[4];

      // Print the extracted segment
      print('fundingid: $desfundingid');
      // Print the extracted balance link
      print('Balance Link: $balanceLink');
      return fundingid!;
    } else {
      throw Exception('Failed to fetch funding sources');
    }
  }

  Future<void> createTransaction(
    String sourceFundingSource,
    String destinationFundingSource,
    double amount,
  ) async {
    final url = 'https://www.ugoya.net/api/transfer/create';

    final body = json.encode({
      '_links': {
        'source': {
          'href':
              "https://api-sandbox.dwolla.com/funding-sources/$sourceFundingSource"
        },
        'destination': {
          'href':
              "https://api-sandbox.dwolla.com/funding-sources/$destinationFundingSource"
        },
      },
      'amount': {
        'currency': 'USD',
        'value': amount.toString(),
      },
    });

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Transaction created Successfully.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      // Navigator.pushReplacementNamed(context, Routes.home);
    } else if (response.statusCode == 400) {
      final jsonData = jsonDecode(response.body);
      final embedded = jsonData["body"]['_embedded'];

      if (embedded != null && embedded.containsKey('errors')) {
        final errors = embedded['errors'];
        if (errors.isNotEmpty && errors[0]['code'] == 'InsufficientFunds') {
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

          print('Insufficient Funds: $errorMessage');
          return;
        } else if (errors.isNotEmpty && errors[0]['code'] == 'Invalid') {
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
        }
      }
      throw Exception('Failed to create transaction');
    } else {
      print('Request: ${response.request}');
      print('Reason Phrase: ${response.reasonPhrase}');
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      throw Exception('Failed to create transaction');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuser();
    calculateFee();
    fetchCustomerId(widget.email);
    // getFundingSource(cusid);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Card(
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(12)),
            //   child: Container(
            //     height: 100,
            //     width: width * width * .9,
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           Container(
            //             width: 50,
            //             height: 50,
            //             color: Colors.grey,
            //             child: Image.asset("assets/images/bank.png"),
            //           ),
            //           SizedBox(
            //             width: 5,
            //           ),
            //           Text(
            //             "City Bank",
            //             style: Theme.of(context).textTheme.titleLarge,
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 30,
            // ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                height: 350,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Transcation Details",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Divider(
                          color: AppColors.textColor2,
                          thickness: 0.5,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "To",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              widget.name,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Divider(
                          color: AppColors.textColor2,
                          thickness: 0.5,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "email",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              widget.email,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Divider(
                          color: AppColors.textColor2,
                          thickness: 0.5,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "amount",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              widget.amount.toString(),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Divider(
                          color: AppColors.textColor2,
                          thickness: 0.5,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Transaction fee",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              fee.toString(),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Divider(
                          color: AppColors.textColor2,
                          thickness: 0.5,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total ammount",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              "\$${widget.amount + fee}",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ]),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Pin Code",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        TextFormField(
                          controller: pincontroller,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.credit_card,
                              color: AppColors.textColor2,
                            ),
                            hintText: "***",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                    width: 1.0, color: AppColors.textColor2)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                    width: 1.0, color: AppColors.textColor2)),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: width * 0.7,
                child: ElevatedButton(
                  onPressed: () {
                    // _loginWithPhoneNumber(phonecontroller.text);
                    isAmount10K
                        ? null
                        : pincontroller.text == pin
                            ? createTransaction(
                                fundingid!, desfundingid!, widget.amount)
                            : Fluttertoast.showToast(
                                msg: "Pin does not match",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                fontSize: 16.0);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      'Press to Send money',
                      style:
                          TextStyle(fontSize: 16, color: AppColors.textColor),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
