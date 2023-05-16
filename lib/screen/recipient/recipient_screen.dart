import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ugocash/models/recipient_model.dart';
import 'package:ugocash/styles/colors.dart';

import '../../config/routes.dart';

class RecipientScreen extends StatefulWidget {
  const RecipientScreen({super.key});

  @override
  State<RecipientScreen> createState() => _RecipientScreenState();
}

class _RecipientScreenState extends State<RecipientScreen> {
  final _random = Random();
  final _formKey = GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  @override
  List<Recipient> recipient = [
    Recipient("name1", Icon(Icons.account_circle_outlined)),
    Recipient("name1", Icon(Icons.account_circle_outlined)),
    Recipient("name1", Icon(Icons.account_circle_outlined)),
    Recipient("name1", Icon(Icons.account_circle_outlined)),
   
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
                          "Recipient",
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
                          itemCount: recipient.length,
                          itemBuilder: (ctx, i) {
                            return GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, Routes.addcard),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              _random.nextInt(256),
                                              _random.nextInt(256),
                                              _random.nextInt(256),
                                              _random.nextInt(256)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        width: 60,
                                        height: 58,
                                        child: recipient[i].icon),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(recipient[i].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall),
                                  ],
                                ),
                              ),
                            );
                          },
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
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
              SizedBox(
                height: 20,
              ),
              Card(
                child: Form(
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
                            "Recipent Contact Info",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                         TextFormField(
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
                              child: Text("name"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
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
                              child: Text("Card number"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
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
                              child: Text("Enter note"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                         
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            
                            SizedBox(
                              width: width * 0.25,
                              child: TextButton(
                                onPressed: () {
                                  // _loginWithPhoneNumber(phonecontroller.text);

                                  //  Navigator.pushReplacementNamed(context, "/home");
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
