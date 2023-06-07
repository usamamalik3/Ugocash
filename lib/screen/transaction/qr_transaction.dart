import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:ugocash/models/recipient_model.dart';

import 'package:ugocash/screen/transaction/confirm_transaction.dart';
import 'package:ugocash/styles/colors.dart';
import 'package:http/http.dart' as http;
import '../../config/routes.dart';

class QrTransaction extends StatefulWidget {
  const QrTransaction({super.key, required this.email});
 final String email;
  @override
  State<QrTransaction> createState() => _QrTransactionState();
}

class _QrTransactionState extends State<QrTransaction> {
  final _random = Random();
  final _formKey = GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController routingController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController amountController = TextEditingController();

 


  
  List<String> customertype = [
    "Family",
    "Friend",
    "Customer",
    "Services",
    "Goods",
  ];
 
  String? customertypevalue;
  String? receivertypevalue;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchFundingSourceIdByRoutingNumber("222222226", "37be2efd-01d6-4ee1-8115-42a239395306");
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Recipients",
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 
              const SizedBox(
                height: 20,
              ),
              Card(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Recipent Info",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          style: Theme.of(context).textTheme.titleLarge,
                          controller: namecontroller,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                    width: 2.0, color: AppColors.textColor2)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                    width: 2.0, color: AppColors.textColor2)),
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Full name"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        DropdownButtonFormField(
                          style: Theme.of(context).textTheme.titleLarge,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      width: 2.0, color: AppColors.textColor2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      width: 2.0, color: AppColors.textColor2)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      width: 2.0, color: AppColors.textColor2)),
                              focusColor: AppColors.textColor2,
                              hintText: "Customer Type",
                              hintStyle:
                                  Theme.of(context).textTheme.titleLarge),
                          borderRadius: BorderRadius.circular(12),
                          dropdownColor: AppColors.secondaryColor,
                          iconEnabledColor: AppColors.textColor2,
                          isExpanded: true,
                          alignment: AlignmentDirectional.bottomEnd,
                          value: customertypevalue,
                          items: customertype.map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(e.toString()),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              customertypevalue = newValue.toString();
                            });
                          },
                        ),
                        //  
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          style: Theme.of(context).textTheme.titleLarge,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Required"),
                            EmailValidator(errorText: "Email is not valid")
                          ]),
                          controller: emailcontroller,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                    width: 2.0, color: AppColors.textColor2)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                    width: 2.0, color: AppColors.textColor2)),
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Email"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        
                        TextFormField(
                          style: Theme.of(context).textTheme.titleLarge,
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "5\$",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                    width: 2.0, color: AppColors.textColor2)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                    width: 2.0, color: AppColors.textColor2)),
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Amount"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          style: Theme.of(context).textTheme.titleLarge,
                          controller: purposeController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                    width: 2.0, color: AppColors.textColor2)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                    width: 2.0, color: AppColors.textColor2)),
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Purpose"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: width * 0.25,
                              child: TextButton(
                                onPressed: () {
                                  // _loginWithPhoneNumber(phonecontroller.text);
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();

                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ConfirmTranscation(
                                                    email: widget.email,
                                                    name: namecontroller.text,
                                                    amount: amountController
                                                        .text)));
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(14.0),
                                  child: Text(
                                    'Next',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.textColor2),
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
            ],
          ),
        )),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, "/addrecipient");
      //   },
      //   child: Icon(
      //     Icons.add,
      //     color: AppColors.textColor,
      //   ),
      // ),
    );
  }
}
