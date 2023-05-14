
import 'package:flutter/material.dart';

import 'package:ugocash/screen/otp.dart';
import 'package:ugocash/styles/colors.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});
  static String verificationId='';

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}


class _PhoneScreenState extends State<PhoneScreen> {
  
  @override
  Widget build(BuildContext context) {
    TextEditingController phonecontroller =TextEditingController();
//     Future<void> _loginWithPhoneNumber(phoneno) async {
      
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   String countrycode="+92";

//   String phoneNumber = countrycode+phoneno; // Replace with the user's phone number
//   // String verificationId;
  

//   await _auth.verifyPhoneNumber(
//     phoneNumber: phoneNumber,
    
//     verificationCompleted: (PhoneAuthCredential credential) async {
//       // Automatically sign in the user on Android devices that support automatic SMS verification
//       UserCredential result = await _auth.signInWithCredential(credential);
//       User user = result.user!;
//       print(user.uid);
//     },
//     verificationFailed: (FirebaseAuthException e) {
//       print(e.message);
//     },
//     codeSent: (String? verificationid, int? resendToken) async {
//       // Save the verification ID for later use
//       setState(() {
//         RegisterScreen.verificationId = verificationid!;
//       });
//     },
//     codeAutoRetrievalTimeout: (String verificationid) {
//       // Auto-retrieval timeout
//       setState(() {
//         RegisterScreen.verificationId = verificationid;
//       });
//     },
//     timeout: Duration(seconds: 60),
//   );
// }

    return  Scaffold(
       backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Column(children:  [

               Text(
                'Registration',
                style: Theme.of(context).textTheme.labelMedium
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Add your phone number. we'll send you a verification code so we know you're not robot",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 28,
              ),
              
             TextFormField(
                    controller: phonecontroller,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: AppColors.secondaryColor),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:const BorderSide(color: AppColors.secondaryColor),
                          borderRadius: BorderRadius.circular(10)),
                      prefix: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          '(+92)',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      suffixIcon: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 32,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
          ],),

             
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // _loginWithPhoneNumber(phonecontroller.text);
                  
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>const OtpScreeen()),
                    );
                  },
                 
                  child: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      'Send',
                      style: TextStyle(fontSize: 16, color: AppColors.textColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}