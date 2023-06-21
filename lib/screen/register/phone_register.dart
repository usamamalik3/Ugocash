import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ugocash/screen/register/otp.dart';

import '../../config/routes.dart';
import '../../styles/colors.dart';

class PhonenoRegister extends StatefulWidget {
  const PhonenoRegister({super.key});

  @override
  State<PhonenoRegister> createState() => _PhonenoRegisterState();
}

class _PhonenoRegisterState extends State<PhonenoRegister> {
  TextEditingController phonecontroller=TextEditingController();
String? countrycode;
 bool isSendingOTP = false;


  Future<void> sendOTP(String phoneNumber) async {
     setState(() {
      isSendingOTP = true;
    });
  FirebaseAuth _auth = FirebaseAuth.instance;
  

  await _auth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    verificationCompleted: (PhoneAuthCredential credential) async {
      // Automatically sign in the user on Android devices that support automatic SMS verification
     try {
            final UserCredential userCredential =
                await _auth.signInWithCredential(credential);

            if (userCredential.user != null) {
              // Existing user authentication successful
              Navigator.pushNamed(context, Routes.pincreate, arguments: phoneNumber);
              print('Existing user authentication successful');
              
              // Proceed with your logic
            } else {
              // Existing user authentication failed
              print('Existing user authentication failed');
              // Show an error message or handle the failure
            }
          } catch (e) {
            // Error during existing user authentication
            print('Error during existing user authentication: $e');
          }
    },
    verificationFailed: (FirebaseAuthException e) {
        setState(() {
         String?   errorMessage = e.message;
            isSendingOTP = false;
             Fluttertoast.showToast(
            msg: errorMessage!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
          });
        
    },
    codeSent: (String verificationId, [int? resendToken]) {
      // Handle code sent callback
      // You can save the verification ID for later use
      print('Code Sent: $verificationId');
  //      FirebaseFirestore.instance.collection("users").doc(phoneNumber).set(
  // {
  //   "pin" : "",
   
  //   }
  // );
       Navigator.pushReplacementNamed(context, Routes.otpscreen, arguments: [phoneNumber, verificationId]);
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
              initialCountryCode: "US",
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
                      child: 
                       ElevatedButton(
                  onPressed: isSendingOTP
                      ? null
                      : () {
                          String phoneno= countrycode!+phonecontroller.text;
                        sendOTP(phoneno);
                        
                        },
                  child: isSendingOTP
                      ? CircularProgressIndicator() // Show CircularProgressIndicator while sending OTP
                      : Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Next',
                            style: TextStyle(fontSize: 16, color: AppColors.textColor),
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
