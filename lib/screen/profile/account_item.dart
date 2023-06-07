import 'package:flutter/material.dart';
import 'package:ugocash/config/routes.dart';

class AccountItem {
   String label;
   Icon icon;
   Function(BuildContext context)  onPressed;

  AccountItem(this.label,  this.onPressed, this.icon);
}


List<AccountItem> accountItems = [
  AccountItem("Address" ,  (context) {
    Navigator.pushNamed(context, Routes.addressdetails);
    
  }, const Icon(Icons.home),),
  AccountItem("Transaction history", (context) {
    Navigator.pushNamed(context, Routes.transactionhistory);
  }, const Icon(Icons.receipt),),
  AccountItem(
      "Contract", (context) {
        // Navigator.pushNamed(context, Routes.addressdetails);
    
  }, const Icon(Icons.group),),
 
  
  
 
];

List<AccountItem> accountItems2 = [
  AccountItem("Setting" ,  (context) {
    
  }, const Icon(Icons.settings),),
  AccountItem("Help Centre", (context) {
    
  },  const Icon(Icons.help_center),),
 
  
  
 
];

