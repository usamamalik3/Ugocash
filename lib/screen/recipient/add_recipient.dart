

import 'package:flutter/material.dart';
import 'package:ugocash/screen/country_choose.dart';
import 'package:ugocash/screen/home.dart';
import 'package:ugocash/styles/colors.dart';

class AddRecipient extends StatefulWidget {
  const AddRecipient({super.key});

  @override
  State<AddRecipient> createState() => _AddRecipientState();
}

class _AddRecipientState extends State<AddRecipient> {
   final _formKey = GlobalKey<FormState>();
   TextEditingController namecontroller = TextEditingController();
   TextEditingController addresscontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new Recipient"),
      ),
      body:  SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("Recipent Contact Info", style: Theme.of(context).textTheme.headline6,),
                  ),
                 
                   const SizedBox(height: 10,),
                  TextFormField(
                    controller: namecontroller,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("name"),
                      ),
                    
                    ),
                    
          
                  ),
                 const SizedBox(height: 10,),
                  
                    
                    
                    
          
                 
                   const SizedBox(height: 10,),
                   TextFormField(
                    controller: addresscontroller,
                    keyboardType: TextInputType.name,
                    decoration:const InputDecoration(
                      label: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Email"),
                      ),
                    ),),
                     const SizedBox(height: 10,),
                   TextFormField(
                    controller: addresscontroller,
                    keyboardType: TextInputType.name,
                    decoration:const InputDecoration(
                      label: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Phone no"),
                      ),
                    ),),
                     const SizedBox(height: 10,),
                     const SizedBox(height: 10,),
                   TextFormField(
                    controller: addresscontroller,
                    keyboardType: TextInputType.name,
                    decoration:const InputDecoration(
                      label: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Address"),
                      ),
                    ),),
                     const SizedBox(height: 10,),
                   TextFormField(
                    controller: addresscontroller,
                    keyboardType: TextInputType.name,
                    decoration:const InputDecoration(
                      label: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("City"),
                      ),
                    ),),
                     const SizedBox(height: 10,),
                   TextFormField(
                    controller: addresscontroller,
                    keyboardType: TextInputType.name,
                    decoration:const InputDecoration(
                      label: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Zip code"),
                      ),
                    ),),
                     const SizedBox(height: 10,),
                   TextFormField(
                    controller: addresscontroller,
                    keyboardType: TextInputType.name,
                    decoration:const InputDecoration(
                      label: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("State"),
                      ),
                    ),),
                     const SizedBox(height: 10,),
                   TextFormField(
                    controller: addresscontroller,
                    keyboardType: TextInputType.name,
                    decoration:const InputDecoration(
                      label: Text("Country"),
                    ),),
                    SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                      width: width*0.25,
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: AppColors.backgroundColor),
                        onPressed: () {
                          // _loginWithPhoneNumber(phonecontroller.text);
                        
                        //  Navigator.pushReplacementNamed(context, "/home");
                        },
                       
                        child: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Cancel',
                            style: TextStyle(fontSize: 16, color: AppColors.textColor),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                  SizedBox(
                      width: width*0.25,
                      child: TextButton(
                        onPressed: () {
                          // _loginWithPhoneNumber(phonecontroller.text);
                        
                        //  Navigator.pushReplacementNamed(context, "/home");
                        },
                       
                        child: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Save',
                            style: TextStyle(fontSize: 16, color: AppColors.textColor2),
                          ),
                        ),
                      ),
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