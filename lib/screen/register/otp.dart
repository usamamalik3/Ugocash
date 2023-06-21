

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:ugocash/config/routes.dart';
import 'package:ugocash/screen/register.dart';
import 'package:ugocash/styles/colors.dart';

class OtpScreeen extends StatefulWidget {
  const OtpScreeen({super.key, required this.verificationId, required this.phoneno});
final String verificationId;
final String phoneno;

  @override
  State<OtpScreeen> createState() => _OtpScreeenState();
}

class _OtpScreeenState extends State<OtpScreeen> {
  OtpFieldController otpController = OtpFieldController();
  String? pincode;
  @override
  
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    void resendOTP(String phoneNumber) async {
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
    codeSent: (String verificationId, int? resendToken) {
      // Handle code sent callback
      print('Code Sent: $verificationId');
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      // Auto-retrieval timeout
      print('Timeout: $verificationId');
    },
    timeout: Duration(seconds: 60),
  );
}
Future<void> checkDocumentExistence( String documentId) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("pins").doc(documentId).get();
   if(snapshot.exists){
    Navigator.pushReplacementNamed(context, Routes.pinscreen, arguments: documentId);
   }
   else{
     Navigator.pushReplacementNamed(context, Routes.pincreate, arguments: documentId);
    // sendOTP(documentId);
   }
  } catch (e) {
    print('Error checking document existence: $e');
    
  }
}
    
Future<void> _submitOTP(otp) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  String smsCode = otp; // Replace with the user's input
  try{
  PhoneAuthCredential credential = PhoneAuthProvider.credential(
    verificationId: widget.verificationId,
    smsCode: smsCode, 
  );
  User? userr = FirebaseAuth.instance.currentUser;
  if(userr== null){
  UserCredential result = await _auth.signInWithCredential(credential);
  User user = result.user!;
checkDocumentExistence(widget.phoneno);
  print("new user created");
  }
 

  }
  catch(e) {
    print(e);

  }}

    return Scaffold(

      appBar: AppBar(title: Text("Two-Step verification"),),
      body: Padding(
        padding: const EdgeInsets.only(top:16.0),
        child: Column(
         
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Verification Code', style: Theme.of(context).textTheme.headlineMedium,),
                   Text("we have sent you a verification code at the given phone number. Enter the pin code", style: Theme.of(context).textTheme.labelMedium,),
                ],
              ),
            ),
         
           
            OTPTextField(
              otpFieldStyle: OtpFieldStyle(borderColor: AppColors.textColor2,
              enabledBorderColor: AppColors.secondaryColor
              ),
              
                controller: otpController,
                length: 6,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 40,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 15,
                style: const TextStyle(fontSize: 17, color: AppColors.textColor),
                onChanged: (pin) {

                  print("Changed: $pin");
                },
                onCompleted: (pin) {
                  // _submitOTP(pin);
                  setState(() {
                    pincode= pin;
                  });
                  print("Completed: $pin");
                }),
             Padding(
               padding: const EdgeInsets.all(20.0),
               child: SizedBox(
                  width: width*0.5,
                  child: ElevatedButton(
                    onPressed: () {
                      // _loginWithPhoneNumber(phonecontroller.text);
                    
                     _submitOTP(pincode);
                    },
                   
                    child: const Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Text(
                        'Confirm',
                        style: TextStyle(fontSize: 16, color: AppColors.textColor),
                      ),
                    ),
                  ),
                ),
             ),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: AppColors.backgroundColor),
                onPressed: (){
                  resendOTP(widget.phoneno);
                }, child: Text("Resend Again" ,style: Theme.of(context).textTheme.labelMedium,))
          ],
        ),
      ),
    );
  }
}