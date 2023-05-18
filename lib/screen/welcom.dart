import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ugocash/config/routes.dart';
import 'package:ugocash/styles/colors.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: CircleAvatar(
              radius:70,
              
              child: Image.asset(
                "assets/images/logo.png",
                width: 150.0,
                height: 150.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 32, right: 16, bottom: 8),
            child: Text(
              'Welcome! to UgoCash',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.only(right: 40.0, left: 40.0, top: 40),
            child: ElevatedButton(
              child: Text(
                'Log In',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.black),
              ),
              onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.login);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: 40.0, left: 40.0, top: 20, bottom: 20),
            child: TextButton(
              child: Text(
                'Sign Up',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onPressed: () {
                Navigator.of(context)
                      .pushReplacementNamed(Routes.register);
              },
            ),
          ),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              'By Proceeding you agree to our\n terms of use\n and Privacy policy', textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ],
      ),
    );
  }
}
