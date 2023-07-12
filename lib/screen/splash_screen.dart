import 'dart:async';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugocash/blocs/bloc/onboarding_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ugocash/config/routes.dart';
import 'package:ugocash/onboaring_screen/onboarding_screen.dart';
import 'package:ugocash/screen/welcom.dart';

import '../styles/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late OnboardingBloc _onboardingBloc;
    User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _onboardingBloc = OnboardingBloc();
    _onboardingBloc.add(StartTimerEvent());

    const delay = Duration(seconds: 3);
    Future.delayed(delay, () => onTimerFinished());
  }
  

  void onTimerFinished() async {
   
        
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

    if (hasSeenOnboarding) {
        if (user != null) {
                      Navigator.of(context).pushReplacementNamed(Routes.home);
                    } else {
                      Navigator.of(context)
                          .pushReplacementNamed(Routes.welcome);
                    }
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.textColor2,
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width * 0.5,
                height: width * 0.35,
                child: Image.asset("assets/images/logo.png"),
              ),
              SizedBox(height: 30),
              Column(
                children: [
                  Text(
                    'Payment Solutions\nPay & Get Paid',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: width * 0.65,
                    height: width * 0.5,
                    child: Image.asset("assets/images/welcome.jpg"),
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
