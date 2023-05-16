import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ugocash/config/routes.dart';
import 'package:ugocash/models/card_model.dart';
import 'package:ugocash/screen/dashboard.dart';

import '../../models/bank_model.dart';



class LinkCard extends StatefulWidget {
  const LinkCard({super.key});

  @override
  State<LinkCard> createState() => _LinkCardState();
}

final _random = Random();

class _LinkCardState extends State<LinkCard> {
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
        title: Text("Link a card"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Bank account",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  Container(
                    width: width * 1,
                    height: height * 0.28,
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      itemCount: banks.length,
                      itemBuilder: (ctx, i) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(
                                      _random.nextInt(256),
                                      _random.nextInt(256),
                                      _random.nextInt(256),
                                      _random.nextInt(256)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Image.asset(banks[i].iconpath),
                                width: 60,
                                height: 58,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(banks[i].name,
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                            ],
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        mainAxisExtent: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "International card",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  Container(
                    width: width * 1,
                    height: height * 0.18,
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      itemCount: card.length,
                      itemBuilder: (ctx, i) {
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(context, Routes.addcard),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: card[i].color,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  width: 60,
                                  height: 58,
                                  child: Image.asset(card[i].iconpath, width: 25, height: 25,),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(card[i].name,
                                    style:
                                        Theme.of(context).textTheme.labelSmall),
                              ],
                            ),
                          ),
                        );
                      },
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 1.5,
                        mainAxisSpacing: 1,
                        mainAxisExtent: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

