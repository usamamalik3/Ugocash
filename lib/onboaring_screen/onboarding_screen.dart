
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugocash/config/routes.dart';
import 'package:ugocash/onboaring_screen/build_page.dart';
import 'package:ugocash/styles/colors.dart';


class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  String urlImage = '';
  String title = '';
  String subtitle = '';
  final controller = PageController();
  bool isLastPage = false;
   final FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
     
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() => isLastPage = index == 1);
            },
            children: const [
              BuildPage(
                urlImage: 'assets/images/exchange.png' ,
                title: 'Leading Payment \nApplication ',
                subtitle: 'More than 100 million users with 1,000 Thousand partners and ervices in the World',
              ),
              BuildPage(
                urlImage: 'assets/images/banking.png',
                title: 'Prestige and Absolute \n Security',
                subtitle: 'Select your bank\n Link your Account \n Transfer Money\n Add Money to your Wallet',
              ),
              // BuildPage(
              //   urlImage: 'assets/images/exchange3.png',
              //   title: 'Receive "Hot" Gift from \n UgoCash Right Away.',
              //   subtitle:
              //       'Sign up now to recieve a large gift pac. Eating, watching movies & many other services.',
              // ),
              
            ],
          ),
        ),
      ),
      bottomSheet: isLastPage
          ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 30),
            child: SizedBox(
              width: 150,
              height: 50,
              child: TextButton(
                
                onPressed: () async {
                  //navigate to choose page
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('showChoose', true);
                  if(user!= null){
                     Navigator.of(context)
                      .pushReplacementNamed(Routes.home);
                  }
                  else{
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.phonenoregister);
                  }
                },
                child: Text(
                  'Get Started',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),
              ),
            ),
          )
          : Container(
            color: AppColors.backgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //skip
                  SizedBox(
                    width: size.width * 0.14,
                  ),

                  //dots
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 2,
                      effect: const WormEffect(
                        spacing: 15,
                        dotColor: AppColors.secondaryColor,
                        activeDotColor: AppColors.textColor,
                      ),
                      onDotClicked: (index) => controller.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      ),
                    ),
                  ),
                  //next
                  InkWell(
                    onTap: () => controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    ),
                    child: Text(
                      'NEXT',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
