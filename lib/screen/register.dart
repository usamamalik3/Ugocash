import 'package:flutter/material.dart';
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
  TextEditingController namecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
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
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Register",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Fill up the Form\n to complete Registration",
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
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("name", style: Theme.of(context).textTheme.labelMedium,),
                      ),
                    ),
                  ),
                const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: addresscontroller,
                    keyboardType: TextInputType.name,
                    decoration:  InputDecoration(
                      label: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Email",style: Theme.of(context).textTheme.labelMedium,),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: addresscontroller,
                    keyboardType: TextInputType.name,
                    decoration:  InputDecoration(
                      label: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Address",style: Theme.of(context).textTheme.labelMedium,),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: addresscontroller,
                    keyboardType: TextInputType.name,
                    decoration:  InputDecoration(
                      label: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("City",style: Theme.of(context).textTheme.labelMedium,),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: addresscontroller,
                    keyboardType: TextInputType.name,
                    decoration:  InputDecoration(
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Country", style: Theme.of(context).textTheme.labelMedium,),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
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
                            'Submit',
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
