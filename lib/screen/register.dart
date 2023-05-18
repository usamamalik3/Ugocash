import 'package:flutter/material.dart';
import 'package:ugocash/config/routes.dart';
import 'package:ugocash/screen/country_choose.dart';
import 'package:ugocash/screen/home.dart';
import 'package:ugocash/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  
 
 bool
  _isObscure1= true;
  bool _isObscure2= true;
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
                    controller: emailController,
                    keyboardType: TextInputType.name,
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
                    
                    controller: phonenoController,
                    keyboardType: TextInputType.name,
                    decoration:  InputDecoration(
                      // prefixIcon: Icon(Icons.phone_android,),
                      // prefixIconColor: AppColors.textColor2,
                      hintText: "+911567899342",
                      label: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Phone no",style: Theme.of(context).textTheme.labelMedium,),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.name,
                    obscureText: _isObscure1,
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
                    controller: cnfrmpasswordController,
                    keyboardType: TextInputType.name,
                    obscureText: _isObscure2,
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

                          Navigator.pushReplacementNamed(context, Routes.secondregister);
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
                            GestureDetector(
                              child: const FaIcon(
                                FontAwesomeIcons.google, size: 30,
                                color: AppColors.secondaryColor,),
                              onTap: () {
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
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.phone, size: 30,
                                color: AppColors.secondaryColor,),
                              onTap: () {
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
                            GestureDetector(
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
