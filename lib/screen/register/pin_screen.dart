import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:ugocash/config/routes.dart';

import '../../styles/colors.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key, required this.phoneno});
 final   String phoneno;

  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final _formKey = GlobalKey<FormState>();

  int _pinAttempts = 0;
  final int _maxPinAttempts = 3;
  bool _isLoginLocked = false;
    OtpFieldController? _pinController = OtpFieldController();
  String? pincode;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
   
      verifyPin(pincode!);
    }
  }

  Future<void> verifyPin(String pin) async {
    if (_isLoginLocked) {
      // Show a message or perform an action indicating login is locked
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:  Text('Login Locked', style: Theme.of(context).textTheme.labelLarge,),
            content:  Text('Please try again later.', style: Theme.of(context).textTheme.labelLarge),
            actions: <Widget>[
              TextButton(
                child:  Text('OK', style: Theme.of(context).textTheme.titleLarge,),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('pins').doc(widget.phoneno).get();

    if (snapshot.exists) {
      String correctPin = snapshot.data()!['pin'];

      if (pin == correctPin) {
        // Navigate to the home screen or perform any other action
        Navigator.pushReplacementNamed(context, Routes.home);
      } else {
        setState(() {
          _pinAttempts++;
        });

        if (_pinAttempts >= _maxPinAttempts) {
          // Lock the login for a specific duration
          _isLoginLocked = true;
          const loginLockDuration = Duration(minutes: 5);
          Future.delayed(loginLockDuration, () {
            setState(() {
              _isLoginLocked = false;
              _pinAttempts = 0;
            });
          });

          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title:  Text('PIN Verification Failed', style: Theme.of(context).textTheme.labelLarge,),
                content:  Text('Maximum PIN entry attempts exceeded. Login is locked for 5 minutes.',style: Theme.of(context).textTheme.labelLarge),
                actions: <Widget>[
                  TextButton(
                    child:  Text('OK',style: Theme.of(context).textTheme.titleLarge),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title:  Text('PIN Verification Failed', style: Theme.of(context).textTheme.labelLarge,),
                content:  Text('Incorrect PIN. Please try again.', style: Theme.of(context).textTheme.labelLarge),
                actions: <Widget>[
                  TextButton(
                    child:  Text('OK',style: Theme.of(context).textTheme.titleLarge),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:  Text('Error', style: Theme.of(context).textTheme.labelLarge,),
            content:  Text('Error Athentication! Please try again.', style: Theme.of(context).textTheme.labelLarge),
            actions: <Widget>[
              TextButton(
                child:  Text('OK',style: Theme.of(context).textTheme.titleLarge),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PIN Verification'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text("Enter Your 4-Digit Pin code", style: Theme.of(context).textTheme.labelLarge,),
                  SizedBox(height: 30,),
                 OTPTextField(
            
                otpFieldStyle: OtpFieldStyle(
                    borderColor: AppColors.textColor2,
                    enabledBorderColor: AppColors.secondaryColor),
                    obscureText: true,
                controller: _pinController,
                length: 4,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 45,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 15,
                style:
                    const TextStyle(fontSize: 17, color: AppColors.textColor),
                onChanged: (pin) {
                  print("Changed: $pin");
                },
                onCompleted: (pin) {
                  // _submitOTP(pin);
                  setState(() {
                    pincode = pin;
                  });
                  print("Completed: $pin");
                }),
            
                  const SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child:  Text('Verify' , style: Theme.of(context).textTheme.labelLarge,),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
