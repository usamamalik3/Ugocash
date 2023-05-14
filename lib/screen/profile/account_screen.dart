import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';


import '../../helpers/column_with_seprator.dart';
import '../../styles/colors.dart';
import 'account_item.dart';

class AccountScreen extends StatelessWidget {
  // final FirebaseAuth auth = FirebaseAuth.instance;

   AccountScreen({super.key});
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
              ListTile(
                leading:
                    SizedBox(width: 65, height: 65, child: getImageHeader()),
                title: Text(
                 "Malik",
                
                ),
                subtitle: Text(
                   "Usama malik ahmed",
                  
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
              SizedBox(
                height: 20,
              ),
              logoutButton( context),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget logoutButton( context) {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                  color: AppColors.textColor2),
            ),
            Container()
          ],
        ),
        onPressed: () {
          // auth.signOut();
          Navigator.pushReplacementNamed(context, "/register");
        },
      ),
    );
  }

  Widget getImageHeader() {
    String imagePath = "assets/images/banner_image.png";
    return CircleAvatar(
      radius: 5.0,
   
      backgroundColor: AppColors.primaryColor.withOpacity(0.7),
    );
  }

  Widget getAccountItemWidget(AccountItem accountItem  , context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
        
          SizedBox(
            width: 20,
          ),
          Text(
            accountItem.label,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}
