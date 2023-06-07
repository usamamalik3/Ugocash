import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ugocash/styles/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdressDetails extends StatefulWidget {
  const AdressDetails({super.key});

  @override
  State<AdressDetails> createState() => _AdressDetailsState();
}

class _AdressDetailsState extends State<AdressDetails> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  String? customerId;
  String? apartment;
  String? street;
  String? city;
  String? state;
  String? zip;
  getuser() async {
    if (user != null) {
      final DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('user')
          .doc(user!.uid)
          .get();

      setState(() {
        customerId = snap["customerid"];
        getCustomerAddressDetails(customerId!);
      });
    }
  }


Future<void> getCustomerAddressDetails(String customerId) async {


  final headers = {
 
    'Content-Type': 'application/json',
  };

  final url = 'https://www.ugoya.net/api/$customerId/customer/getById';

  final response = await http.get(Uri.parse(url), headers: headers);

  if (response.statusCode == 200) {
    final customerData = json.decode(response.body); 
    setState(() {
        city=  customerData ["city"];
    state=  customerData["state"];
    zip=  customerData["postalCode"];
    street = customerData['address1'];
    });    
 

    
  } else {
    Fluttertoast.showToast(
              msg: "Failed to fetch customer address details",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 16.0);
    throw Exception('Failed to fetch customer address details');
  }
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuser();
    //  getCustomerAddressDetails("9ed1b7fd-4287-430a-9ee0-c012b2b51dec");
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: const Text("Address")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                width: width * 0.9,
                height: height * 0.25,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Street:",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(width: 5,),
                           Text(
                            street ??"",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                       Row(
                        children: [
                          Text(
                            "Apartment#:",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(width: 5,),
                           Text(
                            apartment ?? "",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                       Row(
                        children: [
                          Text(
                            "City:",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(width: 5,),
                           Text(
                            city??"",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                        Row(
                        children: [
                          Text(
                            "State:",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(width: 5,),
                           Text(
                            state ??"",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(width: 10,),
                           Text(
                            "Zip:",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(width: 5,),
                           Text(
                            zip ??"",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: SizedBox(
                          width: width * 0.5,
                          child: ElevatedButton(
                            onPressed: () {
                              // _loginWithPhoneNumber(phonecontroller.text);
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(12)),
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Form(
                                      key: _formKey,
                                      child: Wrap(
                                        children: [
                                          TextFormField(
                                            controller: address2Controller,
                                            keyboardType:
                                                TextInputType.streetAddress,
                                            decoration: InputDecoration(
                                              hintText: "Address",
                                              label: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Address",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 75,
                                          ),
                                          TextFormField(
                                            controller: cityController,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              hintText: "Delhi",
                                              label: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "City",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 75,
                                          ),
                                          TextFormField(
                                            controller: zipcodeController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: "12345",
                                              label: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Zip code",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 75,
                                          ),
                                          TextFormField(
                                            controller: stateController,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              hintText: "Punjab",
                                              label: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "State",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 75,
                                          ),
                                          TextFormField(
                                            controller: zipcodeController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: "India",
                                              label: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Country",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium,
                                                ),
                                              ),
                                            ),
                                          ),
                                           const SizedBox(
                                            height: 75,
                                          ),
                                          Center(
                    child: SizedBox(
                      width: width * 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          // _loginWithPhoneNumber(phonecontroller.text);

                          Navigator.pushReplacementNamed(context, "/login");
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Add Address',
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
                                  );
                                },
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(14.0),
                              child: Text(
                                'Add new Address',
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
            )
          ],
        ),
      ),
    );
  }
}
