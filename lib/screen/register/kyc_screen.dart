import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:ugocash/config/routes.dart';
class GenderIMEIScreen extends StatefulWidget {
  const GenderIMEIScreen({super.key});

  @override
  _GenderIMEIScreenState createState() => _GenderIMEIScreenState();
}

class _GenderIMEIScreenState extends State<GenderIMEIScreen> {
  TextEditingController genderController=TextEditingController();
  TextEditingController imeiController=TextEditingController();
  String gender = '';
  String imei = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KYC question'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             TextFormField(
                    controller: genderController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "Gender",
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Gender",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
             TextFormField(
                    controller: imeiController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "IMEI",
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "IMEI",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.home);
                // fetchIMEI();
              },
              child: Text('Next' , style: Theme.of(context).textTheme.labelMedium,),
            ),
       
            SizedBox(height: 8.0),
            // Text('IMEI: $imei'),
          ],
        ),
      ),
    );
  }

  Future<void> fetchIMEI() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      setState(() {
        imei = androidInfo.androidId;
      });
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      setState(() {
        imei = iosInfo.identifierForVendor;
      });
    }
  }
}
