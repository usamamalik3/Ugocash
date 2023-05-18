
import 'package:flutter/material.dart';

class AppColors {
  //One instance, needs factory
  static AppColors? _instance;
  factory AppColors() => _instance ??= AppColors._();

  AppColors._();

  static const primaryColor = Color(0xffcaf754);
  static const secondaryColor = Color(0xff629BEF); 
    static const backgroundColor = Colors.white;

static const textColor = Colors.black;

static const textColor2 = Colors.white;
static const errorColor = Colors.red;
static const primaryfieldColor = Colors.blue;
static const dividerColor = Colors.blueGrey;
static const disabledColor = Colors.grey;
   
}
