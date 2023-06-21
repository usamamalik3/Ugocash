import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ugocash/config/routes.dart';
import 'package:http/http.dart' as http;
import 'package:ugocash/screen/link_method/add_to_wallet.dart';
import '../styles/colors.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? totalValue;
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  String? fundingid;
  String? cusid;
  String? email;
  getuser() async {
    if (user != null) {
      final DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('user')
          .doc(user!.uid)
          .get();

      setState(() {
        email = snap["email"];
        fundingid = snap["fundingid"];
        cusid = snap["customerid"];
       getBalance(fundingid);
      });

      
    }
  }

  Future<String> getBalance(String? fundingSourceId) async {
    final response = await http.get(
        Uri.parse(
            'https://www.ugoya.net/api/$fundingSourceId/fundingSources/getBalance'),
        headers: {
          'Content-Type': 'application/json',
        });

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
         totalValue = data['value'];
      String currency = data['currency'];
      });
     
      // print('Total value: $totalValue $currency');

      if (totalValue == "0.00") {
        print('Total is null');
      }

      
      return totalValue!;
    } else {
      throw Exception('Failed to load balance');
    }
  }


  final _random = Random();
  TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuser();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Dashboard", style: Theme.of(context).textTheme.titleLarge,), actions: [
        InkWell(
          onTap: (){
            
            Navigator.pushNamed(context, Routes.qrscanner,);
          
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.qr_code_scanner),
          ),
        ),
        
         InkWell(
          onTap:(){
            Navigator.pushNamed(context, Routes.qrcode, arguments: email);
          },
           child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.qr_code),
                 ),
         )
      ],),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     // Add padding around the search bar
              //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //     // Use a Material design search bar
              //     child: TextField(
              //       controller: _searchController,
              //       decoration: InputDecoration(
              //         hintStyle: Theme.of(context).textTheme.labelMedium,
              //         hintText: 'Search...',
              //         // Add a clear button to the search bar
              //         suffixIcon: _searchController.text.isNotEmpty
              //             ? IconButton(
              //                 icon: Icon(Icons.clear),
              //                 onPressed: () => _searchController.clear(),
              //               )
              //             : null,
              //         // Add a search icon or button to the search bar
              //         prefixIcon: IconButton(
              //           icon: Icon(Icons.search),
              //           onPressed: () {
              //             // Perform the search here
              //           },
              //         ),
              //         border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(20.0),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            Card(
               shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children:[  fundingid == "" || fundingid == null || totalValue== null
                      ? CircularProgressIndicator(color: AppColors.textColor2)
                      :  Text(
                          "$totalValue \$",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Dashboard Balance",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),]),
              ),
            ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.addbank,
                            arguments: cusid);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Container(
                          width: width * 0.4,
                          height: height * 0.25,
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
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Link Bank\n Account",
                                  style: Theme.of(context).textTheme.titleLarge,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showBottomSheet(context);
                        // showAlertDialog(context);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Container(
                          width: width * 0.4,
                          height: height * 0.25,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.send_to_mobile,
                                  size: 50,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
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
                        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>  AddToWallet(customerid: cusid!,fundingid: fundingid!,)));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Container(
                          width: width * 0.4,
                          height: height * 0.25,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.wallet_outlined,
                                  size: 50,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
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
        style: Theme.of(context).textTheme.titleLarge,
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
      style: Theme.of(context).textTheme.titleLarge,
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
      content: Text("USD", style: Theme.of(context).textTheme.titleLarge,),
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
   void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext ctx) {
        return ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.account_balance_wallet),
                  title: Text('Send from Balance'),
                  onTap: () {
                    // Perform action for sending from balance
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.credit_card),
                  title: Text('Send from Funding Source'),
                  onTap: () {
                    // Perform action for sending from funding source
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
