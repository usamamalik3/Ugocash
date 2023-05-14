import 'package:flutter/material.dart';

import 'package:ugocash/screen/splash_screen.dart';

import 'package:ugocash/styles/theme.dart';

import 'config/routes.dart';

void main() async {
  //  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
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
      home: SplashScreen(),
    );
  }
}