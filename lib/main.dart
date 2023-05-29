import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ugocash/screen/login.dart';
import 'package:ugocash/screen/register.dart';
import 'package:ugocash/screen/register2.dart';

import 'package:ugocash/screen/splash_screen.dart';
import 'package:ugocash/screen/welcom.dart';

import 'package:ugocash/styles/theme.dart';

import 'config/routes.dart';
import 'onboaring_screen/onboarding_screen.dart';


void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UgoCash',
    debugShowCheckedModeBanner: false,
       onGenerateRoute: Routes().generateRoute,
      theme: themeData,
      home: RegisterScreen(),
    );
  }
}
