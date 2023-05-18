import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ugocash/config/routes.dart';
import 'package:ugocash/models/card_model.dart';
import 'package:ugocash/screen/dashboard.dart';

import '../../models/bank_model.dart';
import '../../styles/colors.dart';



class LinkMethod extends StatefulWidget {
  const LinkMethod({super.key});

  @override
  State<LinkMethod> createState() => _LinkMethodState();
}

final _random = Random();

class _LinkMethodState extends State<LinkMethod> {
  List<CardModel> card = [
   CardModel("Paypal","assets/icons/paypal.png",Color.fromARGB(255, 115, 205, 241)),
   CardModel("Visa","assets/icons/Visa.png",Color.fromARGB(255, 157, 157, 245)),
   CardModel("MasterCard","assets/icons/mastercard.png",const Color(0xffFFEFE5)),
   CardModel("Payoneer","assets/icons/payoneer.png",const   Color(0xffFFECE5))
  ];
  List<Bank> banks = [
    Bank("City", "assets/icons/bank.png"),
    Bank("City", "assets/icons/bank.png"),
    Bank("City", "assets/icons/bank.png"),
    Bank("City", "assets/icons/bank.png"),
    Bank("City", "assets/icons/bank.png"),
    Bank("City", "assets/icons/bank.png"),
    Bank("City", "assets/icons/bank.png")
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Link Method"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                width: width*0.9,
                height: height*0.20,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Bank account",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: width * 0.5,
                              child: ElevatedButton(
                                onPressed: () {
                                  // _loginWithPhoneNumber(phonecontroller.text);
                      
                                  Navigator.pushNamed(context, Routes.addbank);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(14.0),
                                  child: Text(
                                    'Click here to Link',
                                    style: TextStyle(
                                        fontSize: 16, color: AppColors.textColor),
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
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                width: width*0.9,
                height: height*0.20,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Debit card",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: width * 0.5,
                              child: ElevatedButton(
                                onPressed: () {
                                  // _loginWithPhoneNumber(phonecontroller.text);
                      
                                  Navigator.pushNamed(context, Routes.addcard);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(14.0),
                                  child: Text(
                                    'Click here to Link',
                                    style: TextStyle(
                                        fontSize: 16, color: AppColors.textColor),
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
        ],
      ),
    );
  }
}

