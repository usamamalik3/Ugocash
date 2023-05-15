import 'package:flutter/material.dart';

import '../styles/colors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Dashboard",)),
        
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              
              
              children: [
               Text("\$10,6500"),
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      
                      
                      Image.asset("assets/images/exchange2.png", width: 250,),
                      Text("Best rate, Low fees, Special Offers", style: Theme.of(context).textTheme.titleMedium,)
                    ],
                  ),
                  
                ),
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      
                      
                      Image.asset("assets/images/exchange.png", width: 250,),
                      Text("Best rate, Low fees, Special Offers", style: Theme.of(context).textTheme.titleMedium,)
                    ],
                  ),
                  
                ),
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      
                      
                      Image.asset("assets/images/exchange.png", width: 250,),
                      Text("Best rate, Low fees, Special Offers", style: Theme.of(context).textTheme.titleMedium,)
                    ],
                  ),
                  
                ),
        
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: () {
        
      },
      label: Text("UgoCash Now" ,  style: TextStyle(color: AppColors.textColor),),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }
}