import 'package:flutter/material.dart';
import 'package:ugocash/onboaring_screen/onboarding_screen.dart';
import 'package:ugocash/screen/card/add_card.dart';
import 'package:ugocash/screen/confirm_transaction.dart';

import 'package:ugocash/screen/home.dart';
import 'package:ugocash/screen/login.dart';


import 'package:ugocash/screen/recipient/add_recipient.dart';
import 'package:ugocash/screen/recipient/recipient_screen.dart';
import 'package:ugocash/screen/register.dart';
import 'package:ugocash/screen/register2.dart';



class Routes {


static const String onboarding = '/onboarding';
  static const String register = '/register';
  static const String secondregister = '/secondregister';
  static const String login = '/login';
  static const String home = '/home';
  static const String recipient ="/recipient";
  static const String addrecipient ='/addrecipient';
  static const String addcard ="/addcard";
  static const String confrmtranscation ="confirmtransc";
  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
       case onboarding:
       return MaterialPageRoute<OnBoarding>(
            builder: (context) => const OnBoarding());
    
       case register:
       return MaterialPageRoute<RegisterScreen>(
            builder: (context) => const RegisterScreen());
      
       case secondregister:
       return MaterialPageRoute<SecondRegister>(
            builder: (context) => const SecondRegister());
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
        case addcard: 
             return MaterialPageRoute<AddCard>(builder: (context) => const AddCard());
        case confrmtranscation:
             return MaterialPageRoute<ConfirmTranscation>(builder: (context) => const ConfirmTranscation());

      default:
        return MaterialPageRoute<RegisterScreen>(
            builder: (context) => const RegisterScreen());
    }
  }
}
