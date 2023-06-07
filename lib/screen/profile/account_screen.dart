import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:ugocash/config/routes.dart';

import '../../helpers/column_with_seprator.dart';
import '../../styles/colors.dart';
import 'account_item.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  String? customerId;
  getuser() async {
    if (user != null) {
      final DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('user')
          .doc(user!.uid)
          .get();

      setState(() {
        customerId = snap["customerid"];
        fetchCustomerDetails(customerId);
      });
    }
  }

  String name = "";

  String email = "";

  Future<void> fetchCustomerDetails(customerId) async {
    String apiUrl = 'https://www.ugoya.net/api/$customerId//customer/getById';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          // 'Authorization': basicAuth,
          // 'Content-Type': 'application/vnd.dwolla.v1.hal+json',
        },
      );

      if (response.statusCode == 200) {
        dynamic jsonData = jsonDecode(response.body);
        setState(() {
          name = jsonData['firstName'];
          email = jsonData['email'];
        });
      } else {
        print(
            'Failed to get customer details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred while retrieving customer details: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    ListTile(
                      leading: SizedBox(
                          width: 65, height: 65, child: getImageHeader()),
                      title: Text(
                        name!,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      subtitle: Text(
                        email!,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "General",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Column(
                      children: getChildrenWithSeperator(
                        widgets: accountItems.map((e) {
                          return getAccountItemWidget(e, context);
                        }).toList(),
                        seperator: Divider(
                          thickness: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: getChildrenWithSeperator(
                    widgets: accountItems2.map((e) {
                      return getAccountItemWidget(e, context);
                    }).toList(),
                    seperator: Divider(
                      thickness: 1,
                    ),
                  ),
                ),
              ),
              logoutButton(context),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget logoutButton(context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 25),
          minimumSize: const Size.fromHeight(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.logout_outlined,
              color: AppColors.textColor,
            ),
            // SizedBox(
            //   width: 20,
            //   height: 20,
            //   child: SvgPicture.asset(
            //     "assets/icons/account_icons/logout_icon.svg",
            //   ),
            // ),
            Text(
              "Log Out",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor),
            ),
            Container()
          ],
        ),
        onPressed: () {
          auth.signOut();
          Navigator.pushReplacementNamed(context, Routes.phonenoregister);
        },
      ),
    );
  }

  Widget getImageHeader() {
    String imagePath = "assets/images/banner_image.png";
    return CircleAvatar(
      radius: 5.0,
      backgroundColor: AppColors.primaryColor.withOpacity(0.5),
    );
  }

  Widget getAccountItemWidget(AccountItem accountItem, context) {
    return InkWell(
      onTap: () {
        accountItem.onPressed(context);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          children: [
            accountItem.icon,
            SizedBox(
              width: 10,
            ),
            Text(
              accountItem.label,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
