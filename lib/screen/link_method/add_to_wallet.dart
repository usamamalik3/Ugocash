import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ugocash/screen/link_method/confirm_to_wallet.dart';

import '../../styles/colors.dart';

class AddToWallet extends StatefulWidget {
  const AddToWallet({
    super.key,
    required this.fundingid,
    required this.customerid,
  });
  final String fundingid;
  final String customerid;

  @override
  State<AddToWallet> createState() => _AddToWalletState();
}

class _AddToWalletState extends State<AddToWallet> {
  TextEditingController ammountController =TextEditingController();
  String? accountId;
  String? bankid;
  String? bankname;
  String? status;
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> fetchFundingSources(customerid) async {
    final url =
        'https://www.ugoya.net/api/${customerid!}/fundingSources/forCustomer/get';

    try {
      final response = await http.get(Uri.parse(url), headers: {});

      if (response.statusCode == 200) {
        print(response.body);
        final jsonData = jsonDecode(response.body);
        print(jsonData);
        setState(() {
          bankname = jsonData[0]["name"];
          bankid = jsonData[0]["id"];
          status = jsonData[0]["status"];
        });

        // print(embedded);

        // if (embedded != null && embedded.containsKey('funding-sources')) {
        //   setState(() {
        //     _bankList = List<Map<String, dynamic>>.from(embedded['funding-sources']);
        //   });
        // }
        // else{
        //   print("no bank added");
        // }
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error fetching funding sources: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchFundingSources(widget.customerid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select bank"),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child:bankname==null? Column(
          children: [
            InkWell(
              onTap: (){
                showAlertDialog(context);
              },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                child: ListTile(
                  title: Text('Account Name: $bankname', style: Theme.of(context).textTheme.titleLarge,),
                  subtitle: Text('status: $status',style: Theme.of(context).textTheme.labelMedium,),
                  trailing: Icon(Icons.monetization_on_outlined),
                ),
              ),
            ),
          ],
        ):CircularProgressIndicator(),
      ),
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
        // Navigator.pushNamed(context, Routes.recipient);
            Navigator.push(
            context, MaterialPageRoute(builder: (context) =>  ConfirmToWallet(amount: ammountController.text, name: bankname!)));
      },
    );
    Widget card = Card(
      child: Container(
        width: 25,
        height: 25,
      ),
    );
    Widget textfield = TextFormField(
      controller: ammountController,
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
      title: Text("Add Money"),
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
}
