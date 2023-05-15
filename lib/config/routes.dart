import 'package:flutter/material.dart';
import 'package:ugocash/onboaring_screen/onboarding_screen.dart';

import 'package:ugocash/screen/home.dart';
import 'package:ugocash/screen/login.dart';


import 'package:ugocash/screen/recipient/add_recipient.dart';
import 'package:ugocash/screen/register.dart';



class Routes {


static const String onboarding = '/onboarding';
  static const String register = '/register';
  static const String login = '/login';
  static const String home = '/home';
  static const String addrecipient ='/addrecipient';
  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
       case onboarding:
       return MaterialPageRoute<OnBoarding>(
            builder: (context) => const OnBoarding());
    
       case register:
       return MaterialPageRoute<RegisterScreen>(
            builder: (context) => const RegisterScreen());
            case login:
       return MaterialPageRoute<LoginScreen>(
            builder: (context) => const LoginScreen());
             case home:
       return MaterialPageRoute<HomeScreen>(
            builder: (context) => const HomeScreen());
        case addrecipient:
           return MaterialPageRoute<AddRecipient>(builder: (context) => AddRecipient());

      default:
        return MaterialPageRoute<RegisterScreen>(
            builder: (context) => const RegisterScreen());
    }
  }
}
