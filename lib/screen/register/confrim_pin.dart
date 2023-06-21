import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:ugocash/config/routes.dart';

import '../../styles/colors.dart';

class CnfrmPinScreen extends StatefulWidget {
  const CnfrmPinScreen({super.key, required this.pin, required this.phoneno});
 final String pin;
 final String phoneno;

  @override
  _CnfrmPinScreenState createState() => _CnfrmPinScreenState();
}

class _CnfrmPinScreenState extends State<CnfrmPinScreen> {
    OtpFieldController? _pinController = OtpFieldController();
    String? pincode;

  // void _savePin() {
  //   final String pin = _pinController.text;
  //   if (pin.length == 4) {
  //     // Save the pin to your preferred storage (e.g., SharedPreferences)
  //     print('Pin saved: $pin');
  //     // Proceed with your logic, such as navigating to the next screen
  //   } else {
  //     // Show an error message or handle the invalid pin length
  //     print('Invalid PIN length');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('confirm PIN'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter a 4-digit PIN',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
           OTPTextField(
            obscureText: true,
              otpFieldStyle: OtpFieldStyle(borderColor: AppColors.textColor2,
              enabledBorderColor: AppColors.secondaryColor
              ),
              
                controller: _pinController,
                length: 4,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 45,
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
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: (){
               if(pincode == widget.pin){
                FirebaseFirestore.instance.collection("pins").doc(widget.phoneno).set(
  {
    "pin":pincode,
  });
                Navigator.pushReplacementNamed(context, Routes.secondregister, arguments: pincode);
               }
               else{
                 Fluttertoast.showToast(
            msg: "pin does not match",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0,
          );
               }
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
