import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ugocash/config/routes.dart';
import 'package:ugocash/screen/country_choose.dart';
import 'package:ugocash/screen/home.dart';
import 'package:ugocash/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonenoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cnfrmpasswordController = TextEditingController();
  final firestoreInstance = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool agree = false;
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  Future<void> sendEmailVerification(User user) async {
    await user.sendEmailVerification();
    print('Verification email sent to ${user.email}');
  }

  bool isEmailVerified(User user) {
    return user.emailVerified;
  }

  _signup() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        await sendEmailVerification(user.user!);

        var firebaseUser = FirebaseAuth.instance.currentUser;
        await firebaseUser!.reload();
        Fluttertoast.showToast(
            msg: "user added successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, Routes.secondregister,
            arguments: [
              "",
              emailController.text,
            ]);

        // firestoreInstance.collection("users").doc(firebaseUser.uid).set({
        //   "email": emailController.text,
        //   "password": passwordController.text,
        //   "role": "user",
        // }).then((value) {
        //   print("success!");
        // });
        // ignore: use_build_context_synchronously
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "email-already-in-use":
            Fluttertoast.showToast(
                msg: e.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.white,
                textColor: Theme.of(context).primaryColor,
                fontSize: 18.0);

            return e.message;
        }
      }
    }
  }

  final String termsAndConditionsUrl =
      'https://ugocash.net/terms-and-conditions/';
  final String privacyPolicyUrl = 'https://ugocash.net/privacy-policy/';

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await canLaunchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 70,
                    child: Image.asset("assets/images/logo_nobg.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Getting started",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      "Create an account to continue! ",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: Theme.of(context).textTheme.labelMedium,
                    controller: emailController,
                    keyboardType: TextInputType.name,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      EmailValidator(errorText: "Email is not valid")
                    ]),
                    decoration: InputDecoration(
                      hintText: "abc@gmail.com",
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Email",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: Theme.of(context).textTheme.labelMedium,
                    controller: passwordController,
                    keyboardType: TextInputType.name,
                    obscureText: _isObscure1,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      MinLengthValidator(8,
                          errorText: "Password should be 8 character"),
                      PatternValidator(r'(?=._*?[#?!@$%^&*-])',
                          errorText:
                              "Password should have atleast one special character"),
                    ]),
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                          child: Icon(_isObscure1
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onTap: () {
                            setState(() {
                              _isObscure1 = !_isObscure1;
                            });
                          }),
                      hintText: "*******",
                      label: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Password",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: Theme.of(context).textTheme.labelMedium,
                    controller: cnfrmpasswordController,
                    keyboardType: TextInputType.name,
                    obscureText: _isObscure2,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Required";
                      }
                      return MatchValidator(
                              errorText: "Password doest not match")
                          .validateMatch(val, passwordController.text);
                    },
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                          child: Icon(_isObscure2
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onTap: () {
                            setState(() {
                              _isObscure2 = !_isObscure2;
                            });
                          }),
                      hintText: "*******",
                      label: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Confirm Password",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: agree,
                            activeColor: AppColors.secondaryColor,
                            onChanged: (value) {
                              setState(() {
                                agree = value ?? false;
                                value == true
                                    ? showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Confirmation', style: Theme.of(context).textTheme.labelMedium,),
                                            content: Text(
                                                'Do you agree?'),
                                            actions: [
                                              TextButton(
                                                style: Theme.of(context).textButtonTheme.style!.copyWith(backgroundColor: MaterialStatePropertyAll(AppColors.textColor2)),
                                                onPressed: () {
                                                  // Perform actions when "Agree" is pressed
                                                  Navigator.of(context).pop();
                                                   setState(() {
                                                    agree = false;
                                                  });
                                                  // Add your code here
                                                },
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  // Perform actions when "Cancel" is pressed
                                                  Navigator.of(context).pop();
                                                 
                                                  // Add your code here
                                                },
                                                child: Text('Agree', style: Theme.of(context).textTheme.titleLarge,),
                                              ),
                                            ],
                                          );
                                        },
                                      )
                                    : null;
                              });
                            },
                          ),
                          GestureDetector(
                            onTap: () => _launchURL(termsAndConditionsUrl),
                            child: Text(
                              'Terms and Conditions',
                              style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Text(
                            ' and ',
                            style: TextStyle(fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: () => _launchURL(privacyPolicyUrl),
                            child: Text(
                              'Privacy Policy,',
                              style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => _launchURL(privacyPolicyUrl),
                        child: Text(
                          'Dwolla terms and services and privacy policy',
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Center(
                    child: SizedBox(
                      width: width * 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          // _loginWithPhoneNumber(phonecontroller.text);
                          agree
                              ? _signup()
                              : Fluttertoast.showToast(
                                  msg: "Accept our terms and policy",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  fontSize: 16.0);
                          ;
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have account!",
                          style: Theme.of(context).textTheme.labelMedium),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.textColor2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: (() {
                          Navigator.pushNamed(context, Routes.login);
                        }),
                        child: Text("Login",
                            style: Theme.of(context).textTheme.labelMedium),
                      )
                    ],
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
