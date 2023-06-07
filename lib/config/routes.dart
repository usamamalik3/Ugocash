

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ugocash/onboaring_screen/onboarding_screen.dart';
import 'package:ugocash/screen/document.dart';
import 'package:ugocash/screen/register/kyc.dart';
import 'package:ugocash/screen/link_method/add_bank.dart';
import 'package:ugocash/screen/link_method/add_card.dart';


import 'package:ugocash/screen/home.dart';
import 'package:ugocash/screen/link_method/add_to_wallet.dart';
import 'package:ugocash/screen/login.dart';
import 'package:ugocash/screen/register/otp.dart';
import 'package:ugocash/screen/register/phone_register.dart';
import 'package:ugocash/screen/profile/address_details.dart';
import 'package:ugocash/screen/profile/transaction_history.dart';
import 'package:ugocash/screen/register/pin_screen.dart';
import 'package:ugocash/screen/transaction/qr_code.dart';

import 'package:ugocash/screen/recipient/add_recipient.dart';
import 'package:ugocash/screen/register/confrim_pin.dart';
import 'package:ugocash/screen/register/create_pin_screen.dart';
import 'package:ugocash/screen/recipient/recipient_screen.dart';
import 'package:ugocash/screen/register.dart';
import 'package:ugocash/screen/register/register2.dart';
import 'package:ugocash/screen/transaction/qr_transaction.dart';
import 'package:ugocash/screen/welcom.dart';

import '../screen/register/kyc_screen.dart';
import '../screen/transaction/qr_scanner.dart';

class Routes {
  static const String onboarding = '/onboarding';
  static const String welcome = "/welcome";
  static const String register = '/register';
  static const String secondregister = '/secondregister';
  static const String login = '/login';
  static const String home = '/home';
   static const String qrcode = '/qrcode';
   static const String qrscanner = '/qrscanner';

  static const String pincreate = '/pincreate';
  static const String cnfrmPinScreen = '/cnfrmPinScreen';
  static const String pinscreen="/pinscreen";
  static const String recipient = "/recipient";
  static const String addrecipient = '/addrecipient';
  static const String addcard = "/addcard";
  static const String addbank = "/addbank";
  static const String confrmtranscation = "/confirmtransc";
  static const String addressdetails = "/addressdetails";
  static const String transactionhistory = "/transactionhistory";
  static const String phonenoregister = "/phoneregister";
  static const String otpscreen = "/otpscreen";
  static const String kyc = "/kyc";
  static const String kycquestion = "/kycquestion";
  static const String documentscreen = "/documentscreen";
  static const String addtowallet = "/addtowallet";
  static const String qrtransaction ="/qrtransaction";
  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case onboarding:
        return MaterialPageRoute<OnBoarding>(
            builder: (context) => const OnBoarding());
      case welcome:
        return MaterialPageRoute<WelcomeScreen>(
            builder: (context) => const WelcomeScreen());
      case register:
        return MaterialPageRoute<RegisterScreen>(
            builder: (context) => const RegisterScreen());

      case secondregister:
        return MaterialPageRoute<SecondRegister>(
            builder: (context) => SecondRegister(pin: routeSettings.arguments as String,));
      case pinscreen:
       return MaterialPageRoute<PinScreen>(builder: (context)=> PinScreen(phoneno: routeSettings.arguments as String));
      case pincreate:
        return MaterialPageRoute<PinCreationScreen>(
            builder: (context) => PinCreationScreen(phoneno: routeSettings.arguments as String,));
      case cnfrmPinScreen:
       List<dynamic> args = routeSettings.arguments as List<dynamic>;
        return MaterialPageRoute<CnfrmPinScreen>(
            builder: (context) => CnfrmPinScreen(pin: args[0], phoneno: args[1],));
      case documentscreen:
        return MaterialPageRoute<DocumentScreen>(
            builder: (context) => DocumentScreen());
       case kycquestion:
        return MaterialPageRoute<GenderIMEIScreen>(
            builder: (context) => GenderIMEIScreen());
      case kyc:
        return MaterialPageRoute<KYCScreen>(
            builder: (context) => KYCScreen(
                  cameras: routeSettings.arguments as List<CameraDescription>,
                ));
        case qrcode:
        return MaterialPageRoute<QRCodeScreen>(
            builder: (context) => QRCodeScreen(
                  information: routeSettings.arguments as String,
                ));
       case qrscanner:
        return MaterialPageRoute<QRScanPage>(
            builder: (context) =>  QRScanPage());
      case phonenoregister:
        return MaterialPageRoute<PhonenoRegister>(
            builder: (context) => const PhonenoRegister());
      case otpscreen:
      List<dynamic> args = routeSettings.arguments as List<dynamic>;
        return MaterialPageRoute(
            builder: (context) =>
                OtpScreeen(phoneno: args[0], verificationId: args[1], ));
      case qrtransaction:
        return MaterialPageRoute<QrTransaction>(
            builder: (context) =>
                QrTransaction(email: routeSettings.arguments as String,));
      case login:
        return MaterialPageRoute<LoginScreen>(
            builder: (context) => const LoginScreen());
      case home:
        return MaterialPageRoute<HomeScreen>(
            builder: (context) => const HomeScreen());
      case recipient:
        return MaterialPageRoute<RecipientScreen>(
            builder: (context) => RecipientScreen( ));
      case addrecipient:
        return MaterialPageRoute<AddRecipient>(
            builder: (context) => AddRecipient());
      case addbank:
        return MaterialPageRoute<AddBank>(
            builder: (context) => AddBank(
                  customerId: routeSettings.arguments as String,
                ));
      case addcard:
        return MaterialPageRoute<AddCard>(
            builder: (context) => const AddCard());
      // case confrmtranscation:
      //   return MaterialPageRoute<ConfirmTranscation>(
      //       builder: (context) =>  ConfirmTranscation(ciid: routeSettings.arguments as String,));
      case addressdetails:
        return MaterialPageRoute<AdressDetails>(
            builder: (context) => const AdressDetails());
      case transactionhistory:
        return MaterialPageRoute<TransferHistoryScreen>(
            builder: (context) => TransferHistoryScreen());

      default:
        return MaterialPageRoute<RegisterScreen>(
            builder: (context) => const RegisterScreen());
    }
  }
}
