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
  
 bool _isObscure1= true;
  bool _isObscure2= true;
  static Future<User?> signInWithGoogle(context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
         Fluttertoast.showToast(
            msg: "user added successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
        Navigator.pushNamed(context, Routes.secondregister);
        

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
             Navigator.pushNamed(context, Routes.secondregister);

        user = userCredential.user;
        
    
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
           Fluttertoast.showToast(
            msg: "account-exists-with-different-credential",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
        }
        else if (e.code == 'invalid-credential') {
          // handle the error here
          Fluttertoast.showToast(
            msg: "invalid-credential",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
        }
      } catch (e) {
        // handle the error here
        Fluttertoast.showToast(
            msg: "Something-Wrong",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    }

    return user;
  }

 _signup() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

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
             Navigator.pushReplacementNamed(context, Routes.secondregister);

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


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
       backgroundColor: AppColors.backgroundColor,
    
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
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
                    validator:  MultiValidator([
                        RequiredValidator(errorText: "Required"),
                        EmailValidator(errorText: "ای میل درست نہیں ہے۔")
                      ]),
                    decoration: InputDecoration(
                      hintText: "abc@gmail.com",

                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Email", style: Theme.of(context).textTheme.labelMedium,),
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
                        PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                            errorText:
                                "Password should have atleast one special character"),
                      ]),
                    decoration:  InputDecoration(
                      
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
                        child: Text("Password",style: Theme.of(context).textTheme.labelMedium,),
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
                    decoration:  InputDecoration(

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
                        child: Text("Confirm Password",style: Theme.of(context).textTheme.labelMedium,),
                      ),
                    ),
                  ),
                 
                 
                        Row(
                          children: [
                            Text("Already have account!",  style: Theme.of(context).textTheme.labelMedium),
                            TextButton(
                               style: TextButton.styleFrom(backgroundColor: AppColors.textColor2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
                              onPressed: (() {
                              
                            }), child:   Text("Login",  style: Theme.of(context).textTheme.labelMedium),)
                          ],
                        ),
                   const SizedBox(height: 10.0),
                  Center(
                    child: SizedBox(
                      width: width * 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          // _loginWithPhoneNumber(phonecontroller.text);
                          _signup();
                         
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
                   const SizedBox(height: 10.0),
                        Text("Or create account using ",  style: Theme.of(context).textTheme.labelMedium),
                        const SizedBox(height: 30.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: const FaIcon(
                                FontAwesomeIcons.google, size: 30,
                                color: AppColors.secondaryColor,),
                              onTap: () {
                                signInWithGoogle(context);
                              
                                setState(() {
                                  // showDialog(
                                  //   context: context,
                                  //   builder: (BuildContext context) {
                                  //     return ThemeHelper().alartDialog("Google Plus","You tap on GooglePlus social icon.",context);
                                  //   },
                                  // );
                                });
                              },
                            ),
                         const  SizedBox(width: 30.0,),
                            InkWell(
                              child: const FaIcon(
                                FontAwesomeIcons.phone, size: 30,
                                color: AppColors.secondaryColor,),
                              onTap: () {
                                Navigator.pushNamed(context, Routes.phonenoregister);
                                // setState(() {
                                //   showDialog(
                                //     context: context,
                                //     builder: (BuildContext context) {
                                //       return ThemeHelper().alartDialog("Twitter","You tap on Twitter social icon.",context);
                                //     },
                                //   );
                                // });
                              },
                            ),
                           const SizedBox(width: 30.0,),
                            InkWell(
                              child: const FaIcon(
                                FontAwesomeIcons.facebook, size: 30,
                                color: AppColors.secondaryColor,),
                              onTap: () {
                                // setState(() {
                                //   showDialog(
                                //     context: context,
                                //     builder: (BuildContext context) {
                                //       return ThemeHelper().alartDialog("Facebook",
                                //           "You tap on Facebook social icon.",
                                //           context);
                                //     },
                                //   );
                                // });
                              },
                            ),
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
