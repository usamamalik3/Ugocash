import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../styles/colors.dart';


class SecondRegister extends StatefulWidget {
  const SecondRegister({super.key});

  @override
  State<SecondRegister> createState() => _SecondRegisterState();
}

class _SecondRegisterState extends State<SecondRegister> {
 final _formKey = GlobalKey<FormState>();
 TextEditingController phonecontroller=TextEditingController();
String? countrycode;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  
  List<String> usertype=["Individual","Business",
"Government"];
String? usertypevalue;
 
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
                      style: Theme.of(context).textTheme.labelLarge,
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
                    controller: firstnameController,
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
                    controller: lastnameController,
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
                  style: Theme.of(context).textTheme.labelMedium,
                  decoration: InputDecoration(hintText: "Account Type", hintStyle: Theme.of(context).textTheme.labelMedium),
               
                  focusColor: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(12),
                  dropdownColor: AppColors.secondaryColor,
                    
                        iconEnabledColor: AppColors.textColor,
                        isExpanded: true,
                        alignment: AlignmentDirectional.bottomEnd,
                        value: usertypevalue,
                        items: usertype.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e.toString(), style: Theme.of(context).textTheme.labelMedium,),
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
                    controller: address1Controller,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      hintText: "Address1",
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
                    controller: address2Controller,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      hintText: "Address2",
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
                    controller: cityController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Delhi",
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
                    controller: zipcodeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "12345",
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
                    controller: stateController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Punjab",
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
                    controller: zipcodeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "India",
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Country", style: Theme.of(context).textTheme.labelMedium,),
                      ),
                    ),
                  ),

                   const SizedBox(
                    height: 20,
                  ),
                   IntlPhoneField(
              initialCountryCode: "IN",
              dropdownTextStyle: Theme.of(context).textTheme.labelMedium,
              controller: phonecontroller,
              style:  Theme.of(context).textTheme.labelMedium,
              decoration: InputDecoration(
                labelStyle: Theme.of(context).textTheme.labelMedium,
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                        width: 2.0, color: AppColors.secondaryColor)),
              ),
              onChanged: (phone) {
                print(phone.completeNumber);
                setState(() {
                 countrycode=phone.countryCode;
                 
                });
              },
              onCountryChanged: (country) {
                print('Country changed to: ' + country.name);
              },
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
