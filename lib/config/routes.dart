



import 'package:flutter/material.dart';
import 'package:ugocash/onboaring_screen/onboarding_screen.dart';
import 'package:ugocash/screen/link_method/add_bank.dart';
import 'package:ugocash/screen/link_method/add_card.dart';
import 'package:ugocash/screen/confirm_transaction.dart';

import 'package:ugocash/screen/home.dart';
import 'package:ugocash/screen/login.dart';
import 'package:ugocash/screen/otp.dart';
import 'package:ugocash/screen/phone_register.dart';
import 'package:ugocash/screen/profile/address_details.dart';
import 'package:ugocash/screen/profile/transaction_history.dart';


import 'package:ugocash/screen/recipient/add_recipient.dart';
import 'package:ugocash/screen/recipient/recipient_screen.dart';
import 'package:ugocash/screen/register.dart';
import 'package:ugocash/screen/register2.dart';
import 'package:ugocash/screen/welcom.dart';



class Routes {


static const String onboarding = '/onboarding';
static const String welcome ="/welcome";
  static const String register = '/register';
  static const String secondregister = '/secondregister';
  static const String login = '/login';
  static const String home = '/home';
  static const String recipient ="/recipient";
  static const String addrecipient ='/addrecipient';
  static const String addcard ="/addcard";
  static const String addbank = "/addbank";
  static const String confrmtranscation ="/confirmtransc";
  static const String addressdetails="/addressdetails";
  static const String transactionhistory ="/transactionhistory";
  static const String phonenoregister ="/phoneregister";
  static const String otpscreen="/otpscreen";
  Route<dynamic> generateRoute(RouteSettings routeSettings) {

    switch (routeSettings.name) {
       case onboarding:
       return MaterialPageRoute<OnBoarding>(
            builder: (context) => const OnBoarding());
      case welcome:
       return MaterialPageRoute<WelcomeScreen>(
            builder: (context) => const WelcomeScreen());
       case register:
       return MaterialPageRoute<RegisterScreen>(
            builder: (context) => const RegisterScreen());
      
       case secondregister:
       return MaterialPageRoute<SecondRegister>(
            builder: (context) =>  SecondRegister(email: routeSettings.arguments as String,));
      case phonenoregister:
       return MaterialPageRoute<PhonenoRegister>(builder: (context)=> const PhonenoRegister());
       case otpscreen:
        return MaterialPageRoute(builder: (context)=>  OtpScreeen(verificationId: routeSettings.arguments as String));
            case login:
       return MaterialPageRoute<LoginScreen>(
            builder: (context) => const LoginScreen());
             case home:
       return MaterialPageRoute<HomeScreen>(
            builder: (context) => const HomeScreen());
         case recipient:
           return MaterialPageRoute<RecipientScreen>(builder: (context) => RecipientScreen());
        case addrecipient:
           return MaterialPageRoute<AddRecipient>(builder: (context) => AddRecipient());
        case addbank: 
             return MaterialPageRoute<AddBank>(builder: (context) => const AddBank());
        case addcard: 
             return MaterialPageRoute<AddCard>(builder: (context) => const AddCard());
        case confrmtranscation:
             return MaterialPageRoute<ConfirmTranscation>(builder: (context) => const ConfirmTranscation());
         case addressdetails:
             return MaterialPageRoute<AdressDetails>(builder: (context) => const AdressDetails());
         case transactionhistory:
             return MaterialPageRoute<TransactionHistory>(builder: (context) => const TransactionHistory());

      default:
        return MaterialPageRoute<RegisterScreen>(
            builder: (context) => const RegisterScreen());
    }
  }
}
