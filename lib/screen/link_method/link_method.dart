import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    User? user = FirebaseAuth.instance.currentUser;
    String? cusid;
    
    getuser()async{
      if(user!= null){
    final DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get();

  setState(() {
      cusid = snap["customerid"];
    ;
    });}}

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuser();  }
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
                      
                                  Navigator.pushNamed(context, Routes.addbank, arguments: cusid);
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
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Card(
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(12)),
          //     child: Container(
          //       width: width*0.9,
          //       height: height*0.20,
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    
          //           children: [
          //             Padding(
          //               padding: const EdgeInsets.all(12.0),
          //               child: Text(
          //                 "Debit card",
          //                 style: Theme.of(context).textTheme.titleLarge,
          //               ),
          //             ),
          //             Row(
          //               crossAxisAlignment: CrossAxisAlignment.end,
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 SizedBox(
          //                     width: width * 0.5,
          //                     child: ElevatedButton(
          //                       onPressed: () {
          //                         // _loginWithPhoneNumber(phonecontroller.text);
                      
          //                         Navigator.pushNamed(context, Routes.addcard);
          //                       },
          //                       child: const Padding(
          //                         padding: EdgeInsets.all(14.0),
          //                         child: Text(
          //                           'Click here to Link',
          //                           style: TextStyle(
          //                               fontSize: 16, color: AppColors.textColor),
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //               ],
          //             ),
                    
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

