import 'dart:async';

import 'package:flutter/material.dart';

import 'package:ugocash/config/routes.dart';

import '../styles/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

     const delay = Duration(seconds: 3);
     Future.delayed(delay, () => onTimerFinished());
  }

  void onTimerFinished() {
    Navigator.of(context).pushReplacementNamed(Routes.onboarding);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.textColor2,
      body: Padding(
        padding: const EdgeInsets.only(top:16.0),
        child: Center(
          child: Column(
         
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               SizedBox(
                width: width* .5,
                height:  width* .35,
                child: Image.asset("assets/images/logo.png")
                        ),
                        SizedBox(height: 30,),
              Column(
                children: [
                  Text('Payment Solutions\n Pay & Get Paid', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium,),
                SizedBox(height: 30,),
                SizedBox(
                width: width* .65,
                height:  width* .5,
                child: Image.asset("assets/images/welcome.jpg")
                        ),
                ],
              ),
              
             
            ],
          ),
        ),
      ),
    );
  }
}
