import 'package:flutter/material.dart';

class AccountItem {
   String label;
   Icon icon;
   Function(BuildContext context)  onPressed;

  AccountItem(this.label,  this.onPressed, this.icon);
}

List<AccountItem> accountItems = [
  AccountItem("Address" ,  (context) {
    
  }, Icon(Icons.home),),
  AccountItem("Transaction history", (context) {
    
  }, Icon(Icons.receipt),),
  AccountItem(
      "Contract", (context) {
    
  }, Icon(Icons.group),),
 
  
  
 
];

List<AccountItem> accountItems2 = [
  AccountItem("Address" ,  (context) {
    
  },Icon(Icons.settings),),
  AccountItem("Transaction history", (context) {
    
  }, Icon(Icons.help_center),),
 
  
  
 
];

