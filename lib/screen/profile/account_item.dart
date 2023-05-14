import 'package:flutter/material.dart';

class AccountItem {
  final String label;
  
  final Function(BuildContext context)  onPressed;

  AccountItem(this.label,  this.onPressed);
}

List<AccountItem> accountItems = [
  AccountItem("Sending To" ,  (context) {
    
  }),
  AccountItem("My Details", (context) {
    
  }),
  AccountItem(
      "Increase Limits", (context) {
    
  }),
  AccountItem("Payment Methods", (context) {
    
  }),
  
 
];
