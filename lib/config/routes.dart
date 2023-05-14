import 'package:flutter/material.dart';
import 'package:ugocash/screen/country_choose.dart';
import 'package:ugocash/screen/home.dart';
import 'package:ugocash/screen/otp.dart';
import 'package:ugocash/screen/phone_screen.dart';
import 'package:ugocash/screen/recipient/add_recipient.dart';



class Routes {


static const String choosecountry = '/choosecountry';
  static const String phonescreen = '/phonescreen';
  static const String otpscreen = '/otpscreen';
  static const String home = '/home';
  static const String addrecipient ='/addrecipient';
  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
       case choosecountry:
       return MaterialPageRoute<CountryChoose>(
            builder: (context) => const CountryChoose());
      case phonescreen:
       return MaterialPageRoute<PhoneScreen>(
            builder: (context) => const PhoneScreen());
       case otpscreen:
       return MaterialPageRoute<OtpScreeen>(
            builder: (context) => const OtpScreeen());
             case home:
       return MaterialPageRoute<HomeScreen>(
            builder: (context) => const HomeScreen());
        case addrecipient:
           return MaterialPageRoute<AddRecipient>(builder: (context) => AddRecipient());

      default:
        return MaterialPageRoute<PhoneScreen>(
            builder: (context) => const PhoneScreen());
    }
  }
}
