import 'package:flutter/material.dart';
import 'package:ugocash/config/routes.dart';
import 'package:ugocash/screen/country_choose.dart';
import 'package:ugocash/screen/home.dart';
import 'package:ugocash/styles/colors.dart';

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
                      "Getting started",
                      style: Theme.of(context).textTheme.titleLarge,
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
                  const SizedBox(
                    height: 20,
                  ),
                
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
                            'Sign up',
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
