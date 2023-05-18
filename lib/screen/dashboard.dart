import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ugocash/config/routes.dart';

import '../styles/colors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _random = Random();
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // Add padding around the search bar
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  // Use a Material design search bar
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintStyle: Theme.of(context).textTheme.labelMedium,
                      hintText: 'Search...',
                      // Add a clear button to the search bar
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () => _searchController.clear(),
                            )
                          : null,
                      // Add a search icon or button to the search bar
                      prefixIcon: IconButton(
                        color: AppColors.textColor,
                        icon: Icon(Icons.search),
                        onPressed: () {
                          // Perform the search here
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                "\$10,6500",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Dashboard Balance",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Container(
                        width: width*0.4,
                        height: height*0.25,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
      "assets/icons/bank.svg",
      width: 35,
      height: 35,
      color: AppColors.textColor2,
      // semanticsLabel: 'Label'
    ),
                              SizedBox(height: 10,),
                              Text(
                                "Link Bank\n Account",
                                style: Theme.of(context).textTheme.titleLarge,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showAlertDialog(context);
                      },
                      child:   Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Container(
                        width: width*0.4,
                        height: height*0.25,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.send_to_mobile, size: 50,),
                              SizedBox(height: 10,),
                              Text(
                                "Send\n Money",
                                style: Theme.of(context).textTheme.titleLarge,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  
                    ),
                  
                  ],
                ),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                   
                    GestureDetector(
                      onTap: () {
                        // showAlertDialog(context);
                      },
                      child:   Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Container(
                        width: width*0.4,
                        height: height*0.25,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.wallet_outlined, size: 50,),
                              SizedBox(height: 10,),
                              Text(
                                "Add money\n to Wallet",
                                style: Theme.of(context).textTheme.titleLarge,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  
                    ),
                  
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Card(
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10)),
              //     child: Container(
              //       width: width * 1,
              //       height: height * 0.28,
              //       child: GridView.builder(
              //         shrinkWrap: true,
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 8, vertical: 4),
              //         itemCount: 8,
              //         itemBuilder: (ctx, i) {
              //           return Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Column(
              //               children: [
              //                 Container(
              //                   decoration: BoxDecoration(
              //                     color: Color.fromARGB(
              //                         _random.nextInt(256),
              //                         _random.nextInt(256),
              //                         _random.nextInt(256),
              //                         _random.nextInt(256)),
              //                     borderRadius:
              //                         BorderRadius.all(Radius.circular(10)),
              //                   ),
              //                   child: Icon(Icons.receipt_outlined),
              //                   width: 50,
              //                   height: 58,
              //                 ),
              //                 SizedBox(
              //                   height: 5,
              //                 ),
              //                 Text('Title',
              //                     style: Theme.of(context)
              //                         .textTheme
              //                         .labelMedium),
              //               ],
              //             ),
              //           );
              //         },
              //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //           crossAxisCount: 4,
              //           childAspectRatio: 1.5,
              //           crossAxisSpacing: 2,
              //           mainAxisSpacing: 2,
              //           mainAxisExtent: 100,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/exchange2.png",
                      width: 250,
                    ),
                    Text(
                      "Best rate, Low fees, Special Offers",
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {},
      //   label: Text(
      //     "UgoCash Now",
      //     style: TextStyle(color: AppColors.textColor),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons

    Widget continueButton = TextButton(
      child: Text(
        "click & Continue",
        style: Theme.of(context).textTheme.labelMedium,
      ),
      onPressed: () {
        Navigator.pushNamed(context, Routes.recipient);
      },
    );
    Widget card = Card(
      child: Container(
        width: 25,
        height: 25,
      ),
    );
    Widget textfield = TextFormField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:
                const BorderSide(width: 1.0, color: AppColors.textColor2)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:
                const BorderSide(width: 1.0, color: AppColors.textColor2)),
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
      title: Text("Send Money"),
      content: Text("USD"),
      actions: [
        textfield,
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
