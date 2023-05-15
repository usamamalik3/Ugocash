
import 'package:flutter/material.dart';
import 'package:ugocash/screen/dashboard.dart';

import 'package:ugocash/screen/profile/account_screen.dart';
import 'package:ugocash/screen/recipient/recipient_screen.dart';
import 'package:ugocash/styles/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final PageController _pageController = PageController();
  List<Widget> screens =  [
   const Dashboard(),
  const RecipientScreen(),
   const RecipientScreen(),
    AccountScreen(),
    
  ];

  _animateToPage(int pageIndex) {
    _pageController.animateToPage(pageIndex,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        children: screens,
      ),
      bottomNavigationBar:
       Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
         
            
            currentIndex: selectedIndex,
            onTap: _animateToPage,
            showUnselectedLabels: true,
            items: const  <BottomNavigationBarItem>[
              BottomNavigationBarItem(
               backgroundColor: AppColors.secondaryColor,
                icon: Icon(Icons.dashboard),
                label: 'Dashborad',
              ),
             BottomNavigationBarItem(
                icon: Icon(Icons.credit_card),
                label: 'Card',
              ),
             
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_outlined),
                label: 'Recipient',
              ),
                BottomNavigationBarItem(
                icon: Icon(Icons.account_box),
                label: 'Profile',
              ),
          
          
            ],
          ),
        ),
      ),
    );
  }}