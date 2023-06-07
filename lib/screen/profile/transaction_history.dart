import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TransferHistoryScreen extends StatefulWidget {
  const TransferHistoryScreen({super.key});

  @override
  _TransferHistoryScreenState createState() => _TransferHistoryScreenState();
}

class _TransferHistoryScreenState extends State<TransferHistoryScreen> {
  String? customerId; // Replace with the customer ID you want to retrieve transfer history for
  List<dynamic> transferHistory = [];
 User? user = FirebaseAuth.instance.currentUser;
 
  getuser() async {
    if (user != null) {
      final DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('user')
          .doc(user!.uid)
          .get();

      setState(() {
        customerId = snap["customerid"];
        fetchTransferHistory(customerId);
      });
    }
  }
  @override
  void initState() {
    super.initState();
    getuser();
  }

  Future<void> fetchTransferHistory(customerId) async {
    String apiUrl = 'https://www.ugoya.net/api/$customerId/transfer/forCustomer/get';
  

    // String credentials = base64.encode(utf8.encode('$apiKey:$apiSecret'));
    // String basicAuth = 'Basic $credentials';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
         
        },
      );

      if (response.statusCode == 200) {
      
          dynamic jsonData = jsonDecode(response.body);
          transferHistory = jsonData;
          print(transferHistory);
      
      } else {
        print('Failed to get transfer history. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred while retrieving transfer history: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: transferHistory.length,
          itemBuilder: (BuildContext context, int index) {
            final transfer = transferHistory[index];
            return Card(
              child: ListTile(
                horizontalTitleGap: 10,
                minVerticalPadding: 10.0,
                title: Text('Amount: ${transfer['amount']['value']}',style: Theme.of(context).textTheme.titleLarge),
                 subtitle: Text('Transfer ID: ${transfer['id']}', style: Theme.of(context).textTheme.titleLarge,),
               
                trailing: Text('Status: ${transfer['status']}',style: Theme.of(context).textTheme.titleLarge),
              ),
            );
          },
        ),
      ),
    );
  }
}


