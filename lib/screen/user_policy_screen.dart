import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ugocash/config/routes.dart';
import 'package:ugocash/styles/colors.dart';

class UserPolicy extends StatefulWidget {
  @override
  _UserPolicyState createState() => _UserPolicyState();
}

class _UserPolicyState extends State<UserPolicy> {
  String eulaContent = '';

  @override
  void initState() {
    super.initState();
    loadEulaContent();
  }

  Future<void> loadEulaContent() async {
    String eulaText = await rootBundle.loadString('assets/userpolicy.txt');
    setState(() {
      eulaContent = eulaText;
    });
  }

  bool agree = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Policies'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: eulaContent!=""? Column(
          children: [
            Text(eulaContent),
            SizedBox(
              height: 10,
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
                Text("I have read the terms and contions"),
              ],
            ),
            SizedBox(
              width: width * 0.5,
              child: ElevatedButton(
                onPressed: () {
                  // _loginWithPhoneNumber(phonecontroller.text);
                  agree
                      ? Navigator.pushReplacementNamed(context, Routes.register)
                      : null;
                  
                },
                child: const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Text(
                    'Agree',
                    style: TextStyle(fontSize: 16, color: AppColors.textColor),
                  ),
                ),
              ),
            ),
          ],
        ):Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
