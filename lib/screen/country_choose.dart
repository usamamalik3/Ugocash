import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ugocash/styles/colors.dart';

class CountryChoose extends StatefulWidget {
  const CountryChoose({super.key});

  @override
  State<CountryChoose> createState() => _CountryChooseState();
}

class _CountryChooseState extends State<CountryChoose> {
  TextEditingController searchController =TextEditingController();
  List <String>countrylist= [
"Australia",
"Austria",
"Belgium"
"Canada",
"Cyprus",
"Czech Republic",
"Denmark",
"Finland",
];
  String? countryvalue;
  @override
  Widget build(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.fromLTRB(12,64,12,8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Where do you want to send money?',  style: Theme.of(context).textTheme.titleSmall,),
            SizedBox(height: 30,),
              ListTile(
                title: Text("From"),
                subtitle: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                          
                            isExpanded: true,
                           
                            
                         
                            value: countryvalue,
                               items: countrylist
                                .map((country) => DropdownMenuItem(
                                      value: country,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          country,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                countryvalue = value.toString();
                              });
                            },
                            buttonStyleData:  ButtonStyleData(
                             
                              height: 50,
                              width: width*09,
                                decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: AppColors.secondaryColor
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(16))
                            )
                            ),
                            dropdownStyleData: const DropdownStyleData(
                              maxHeight: 250,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 60,
                            ),
                            dropdownSearchData: DropdownSearchData(
                              searchController: searchController,
                              searchInnerWidgetHeight: 50,
                              searchInnerWidget: Container(
                                height: 60,
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
                                    hintStyle: const TextStyle(fontSize: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
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
              ),
              SizedBox(height: 20,),
              ListTile(
                title: Text("To"),
                subtitle: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(  
                            buttonStyleData:ButtonStyleData( 
                               height: 50,
                              width: width*09,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.secondaryColor
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(16))
                              )),
                                                 
                            isExpanded: true,               
                            value: countryvalue,
                               items: countrylist
                                .map((country) => DropdownMenuItem(
                                      value: country,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          country,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                countryvalue = value.toString();
                              });
                            },
                          
                            dropdownStyleData: const DropdownStyleData(
                              maxHeight: 250,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 60,
                            ),
                            dropdownSearchData: DropdownSearchData(
                              searchController: searchController,
                              searchInnerWidgetHeight: 50,
                              searchInnerWidget: Container(
                                height: 60,
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
                                    hintStyle: const TextStyle(fontSize: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
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
              ),
              SizedBox(height: 30,),
              
               Center(
                child: SizedBox(
                    width: width*0.5,
                    child: ElevatedButton(
                      onPressed: () {
                        // _loginWithPhoneNumber(phonecontroller.text);
                      
                      Navigator.pushNamed(context, "/phonescreen");
                      },
                     
                      child: const Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Text(
                          'Next',
                          style: TextStyle(fontSize: 16, color: AppColors.textColor),
                        ),
                      ),
                    ),
                  ),
              ),
          ],
        ),
      )),
    );
  }
}

