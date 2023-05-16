import 'package:flutter/material.dart';

import '../styles/colors.dart';


class SecondRegister extends StatefulWidget {
  const SecondRegister({super.key});

  @override
  State<SecondRegister> createState() => _SecondRegisterState();
}

class _SecondRegisterState extends State<SecondRegister> {
 final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonenoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cnfrmpasswordController = TextEditingController();
  List<String> usertype=["Individual","Business",
"Government"];
String? usertypevalue;
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
                
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Fill up the other Information to complete",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      "Registeration! ",
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
                      hintText: "First name",
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("First name", style: Theme.of(context).textTheme.labelMedium,),
                      ),
                    ),
                  ),
                const SizedBox(
                    height: 20,
                  ),
                   TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "Last name",
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Last name", style: Theme.of(context).textTheme.labelMedium,),
                      ),
                    ),
                  ),
                const SizedBox(
                    height: 20,
                  ),
                 DropdownButtonFormField(
                  decoration: InputDecoration(hintText: "Account Type", hintStyle: Theme.of(context).textTheme.labelMedium),
               
                  focusColor: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(12),
                  dropdownColor: AppColors.secondaryColor,
                    
                        iconEnabledColor: AppColors.textColor2,
                        isExpanded: true,
                        alignment: AlignmentDirectional.bottomEnd,
                        value: usertypevalue,
                        items: usertype.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e.toString()),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            usertypevalue = newValue.toString();
                          });
                        },
                      ), 
                 const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "",
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Address1", style: Theme.of(context).textTheme.labelMedium,),
                      ),
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
                        child: Text("Address2", style: Theme.of(context).textTheme.labelMedium,),
                      ),
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
                        child: Text("City", style: Theme.of(context).textTheme.labelMedium,),
                      ),
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
                        child: Text("Zip code", style: Theme.of(context).textTheme.labelMedium,),
                      ),
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
                        child: Text("State", style: Theme.of(context).textTheme.labelMedium,),
                      ),
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
                        child: Text("Phone", style: Theme.of(context).textTheme.labelMedium,),
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

                          Navigator.pushReplacementNamed(context, "/login");
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
