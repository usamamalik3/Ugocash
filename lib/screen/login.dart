import 'package:flutter/material.dart';
import 'package:ugocash/screen/country_choose.dart';
import 'package:ugocash/screen/home.dart';
import 'package:ugocash/styles/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
 bool _isObscure1= true;
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
       backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50,
                      child: Image.asset("assets/images/logo_nobg.png"),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Let's Sign You In",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      "Welcome back, you've been missed! ",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: namecontroller,
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
                      hintText: "********",
                      label: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Confirm Password",style: Theme.of(context).textTheme.labelMedium,),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                
                  Center(
                    child: SizedBox(
                      width: width * 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          // _loginWithPhoneNumber(phonecontroller.text);

                          Navigator.pushReplacementNamed(context, "/home");
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Sign in',
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
          ),
        ),
      ),
    );
  }
}
