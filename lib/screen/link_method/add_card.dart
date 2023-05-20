import 'package:flutter/material.dart';
import 'package:ugocash/styles/colors.dart';


class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  bool agree = false;
   final _formKey = GlobalKey<FormState>();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController carNameController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  @override
  Widget build(BuildContext context) {
   double  width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Link a card"),),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              children: [
                Image.asset("assets/images/credit.png", width: width*0.9,),
                Form(
                  key: _formKey,
                  child: Column(
                  children: [
                     TextFormField(
                          controller: carNameController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "4509 3450 4477 6879",
                             prefixIcon: Icon(Icons.keyboard, color: AppColors.textColor,),
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Card Number", style: Theme.of(context).textTheme.labelMedium,),
                            ),
                          ),
                        ),
                      const SizedBox(
                          height: 20,
                        ),
        
                        TextFormField(
                          controller: carNameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: "4509 3450 4477 6879",
                             prefixIcon: Icon(Icons.account_circle, color: AppColors.textColor,),
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Cardholder Name", style: Theme.of(context).textTheme.labelMedium,),
                            ),
                          ),
                        ),
                      const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: expiryController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "20/2022",
                             prefixIcon: Icon(Icons.credit_card, color: AppColors.textColor,),
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Expiring Month & year", style: Theme.of(context).textTheme.labelMedium,),
                            ),
                          ),
                        ),
                      const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: cvvController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.credit_card, color: AppColors.textColor,),
                            hintText: "***",
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Cvv Number", style: Theme.of(context).textTheme.labelMedium,),
                            ),
                          ),
                        ),
                      const SizedBox(
                          height: 20,
                        ),
                        Row(children: [  Checkbox(
                      value: agree,
                      
                      activeColor: AppColors.secondaryColor,
                      onChanged: (value) {
                        setState(() {
                          agree = value ?? false;
                        });
                      },
                    ),
                    Text("Save this card", style: Theme.of(context).textTheme.labelMedium,)
                    
                    ,],),

                     const SizedBox(
                      height: 20,
                    ),
                  
                    Center(
                      child: SizedBox(
                        width: width * 0.5,
                        child: ElevatedButton(
                          onPressed: () {
                            // _loginWithPhoneNumber(phonecontroller.text);

                           showAlertDialog(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Text(
                              'Link card',
                              style: TextStyle(
                                  fontSize: 16, color: AppColors.textColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
  showAlertDialog(BuildContext context) {

  // set up the buttons
 
  Widget continueButton = TextButton(
    child: Text("click & Continue", style: Theme.of(context).textTheme.labelMedium,),
    onPressed:  () {},
  );
  Widget card = Card(
    child: Container(width:25, height: 25,),
);

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: AppColors.secondaryColor,
    actionsAlignment: MainAxisAlignment.center,
    icon: Icon(Icons.credit_card, size: 40,),
    title: Text("Card Added Succesfully"),
    content: Text("Now you can freely pay and shop and Enjoy it"),
    actions: [

     
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
}