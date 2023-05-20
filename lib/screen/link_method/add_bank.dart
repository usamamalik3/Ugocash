import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ugocash/styles/colors.dart';

class AddBank extends StatefulWidget {
  const AddBank({super.key});

  @override
  State<AddBank> createState() => _AddBankState();
}

class _AddBankState extends State<AddBank> {
  bool agree = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController carNameController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  List<String> banklist = ["City Bank", "Bank of America", "Bank of India"];
  String? bankvalue;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Link Bank account"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    "assets/images/bank.png",
                    width: width * 0.9,
                    height: height * .2,
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text("Account Holder", style: Theme.of(context).textTheme.labelLarge,),
                        SizedBox(height:20),
                        TextFormField(
                          controller: carNameController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Jack",
                            prefixIcon: Icon(
                              Icons.account_circle,
                              color: AppColors.textColor,
                            ),
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Account Holder name",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
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
                            hintText: "Last name",
                            prefixIcon: Icon(
                              Icons.account_circle,
                              color: AppColors.textColor,
                            ),
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Last name",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                         
                            isExpanded: true,
                            
                           hint: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text("Select Bank", style: Theme.of(context).textTheme.labelMedium, ),
                           ),
                            value: bankvalue,
                            items: banklist
                                .map((bank) => DropdownMenuItem(
                                      value: bank,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          bank,
                                          style: Theme.of(context).textTheme.labelMedium
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                bankvalue = value.toString();
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.secondaryColor, width: 2 ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              height: 50,
                              width: width * 09,
                            ),
                            dropdownStyleData: const DropdownStyleData(
                              decoration: BoxDecoration(
                                  color: AppColors.secondaryColor),
                              maxHeight: 200,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                            dropdownSearchData: DropdownSearchData(
                              searchController: searchController,
                              searchInnerWidgetHeight: 50,
                              searchInnerWidget: Container(
                                height: 50,
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 4,
                                  right: 8,
                                  left: 8,
                                ),
                                child: TextFormField(
                                  expands: true,
                                  maxLines: null,
                                  controller: searchController,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    hintText: 'Search for an item...',
                                    hintStyle:
                                        Theme.of(context).textTheme.titleMedium,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: const BorderSide(
                                            width: 2.0,
                                            color: AppColors.textColor2)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: const BorderSide(
                                            width: 2.0,
                                            color: AppColors.textColor2)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                          width: 2.0,
                                          color: AppColors.textColor2),
                                    ),
                                  ),
                                ),
                              ),
                              searchMatchFn: (departmentlist, searchValue) {
                                return (departmentlist.value
                                    .toString()
                                    .toLowerCase()
                                    .contains(searchValue.toLowerCase()));
                              },
                            ),
                            //This to clear the search value when you close the menu
                            onMenuStateChange: (isOpen) {
                              if (!isOpen) {
                                searchController.clear();
                              }
                            },
                          ),
                        ),
                          const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: expiryController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Routing",
                            prefixIcon: const Icon(
                              Icons.code,
                              color: AppColors.textColor,
                            ),
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Routing",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: searchController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.credit_card,
                              color: AppColors.textColor,
                            ),
                            hintText: "145362489",
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Account Number",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                   
                         TextFormField(
                          controller: searchController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.account_circle_rounded,
                              color: AppColors.textColor,
                            ),
                            hintText: "username",
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "User Name",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                              TextFormField(
                          controller: searchController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.password,
                              color: AppColors.textColor,
                            ),
                            hintText: "********",
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                        Row(
                          children: [
                            Checkbox(
                              value: agree,
                              activeColor: AppColors.secondaryColor,
                              onChanged: (value) {
                                setState(() {
                                  agree = value ?? false;
                                });
                              },
                            ),
                            Text(
                              "Save this info",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
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

                                showAlertDialog(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(14.0),
                                child: Text(
                                  'Link Bank',
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
      child: Text(
        "click & Continue",
        style: Theme.of(context).textTheme.labelMedium,
      ),
      onPressed: () {},
    );
    Widget card = Card(
      child: Container(
        width: 25,
        height: 25,
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: AppColors.secondaryColor,
      actionsAlignment: MainAxisAlignment.center,
      icon: Icon(
        Icons.credit_card,
        size: 40,
      ),
      title: Text("Bank details Added Succesfully"),
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
