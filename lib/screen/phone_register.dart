import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ugocash/screen/otp.dart';

import '../config/routes.dart';
import '../styles/colors.dart';

class PhonenoRegister extends StatefulWidget {
  const PhonenoRegister({super.key});

  @override
  State<PhonenoRegister> createState() => _PhonenoRegisterState();
}

class _PhonenoRegisterState extends State<PhonenoRegister> {
  TextEditingController phonecontroller=TextEditingController();
String? countrycode;
  Future<void> sendOTP(String phoneNumber) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  

  await _auth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    verificationCompleted: (PhoneAuthCredential credential) async {
      // Automatically sign in the user on Android devices that support automatic SMS verification
      UserCredential result = await _auth.signInWithCredential(credential);
      User user = result.user!;
      print(user.uid);
    },
    verificationFailed: (FirebaseAuthException e) {
      print(e.message);
    },
    codeSent: (String verificationId, [int? resendToken]) {
      // Handle code sent callback
      // You can save the verification ID for later use
      print('Code Sent: $verificationId');
       Navigator.pushReplacementNamed(context, Routes.otpscreen, arguments: verificationId);
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      // Auto-retrieval timeout
      // You can save the verification ID for later use
      print('Timeout: $verificationId');
    },
    timeout: Duration(seconds: 60),
  );
}


  @override
  Widget build(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Register using\n Phone number",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 40,),
             Text(
              "We will sent you a 6 digit code on this number",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: 20,),
            IntlPhoneField(
              initialCountryCode: "IN",
              dropdownTextStyle: Theme.of(context).textTheme.labelMedium,
              controller: phonecontroller,
              style:  Theme.of(context).textTheme.labelMedium,
              decoration: InputDecoration(
                labelStyle: Theme.of(context).textTheme.labelMedium,
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                        width: 2.0, color: AppColors.secondaryColor)),
              ),
              onChanged: (phone) {
                print(phone.completeNumber);
                setState(() {
                 countrycode=phone.countryCode;
                 
                });
              },
              onCountryChanged: (country) {
                print('Country changed to: ' + country.name);
              },
            ),
            SizedBox(height: 20,),
             Center(
                    child: SizedBox(
                      width: width * 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          // _loginWithPhoneNumber(phonecontroller.text);
                          
                          String phoneno= countrycode!+phonecontroller.text;
                       sendOTP(phoneno);
                        
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Next',
                            style: TextStyle(
                                fontSize: 16, color: AppColors.textColor),
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
