import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ugocash/styles/colors.dart';

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
                      Text(
                        "Street address",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        "+91315-4587623",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "130 Avenue Flushing NY",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        "Default Address",
                        style: Theme.of(context).textTheme.labelMedium,
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
