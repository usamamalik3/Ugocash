import 'dart:math';

import 'package:flutter/material.dart';

import '../styles/colors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _random = Random();
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height= MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // Add padding around the search bar
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    // Use a Material design search bar
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        // Add a clear button to the search bar
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () => _searchController.clear(),
                              )
                            : null,
                        // Add a search icon or button to the search bar
                        prefixIcon: IconButton(
                          color: AppColors.textColor2,
                          icon: Icon(Icons.search),
                          onPressed: () {
                            // Perform the search here
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  "\$10,6500",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "UgoCash Balance",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Card(
                        child: Container(
                          width: 85,
                          height: 60,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.card_membership_outlined),
                              Text(
                                "Top-up",
                                style: Theme.of(context).textTheme.labelSmall,
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          width: 85,
                          height: 60,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.card_membership_outlined),
                              Text(
                                "Transfer",
                                style: Theme.of(context).textTheme.labelSmall,
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          width: 85,
                          height: 60,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.card_membership_outlined),
                              Text(
                                "Withdraw",
                                style: Theme.of(context).textTheme.labelSmall,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Container(
                    
                    width: width * 1,
                    height: height*0.28,
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      itemCount: 8,
                      itemBuilder: (ctx, i) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                           
                            children: [
                              Container( decoration: BoxDecoration(
                                color: Color.fromARGB(_random.nextInt(256), _random.nextInt(256),
                  _random.nextInt(256), _random.nextInt(256)),
                                borderRadius: BorderRadius.all(Radius.circular(10)),),
                                child: Icon(Icons.receipt_outlined),
                                width: 50,
                                height: 58,
                              ),
                              SizedBox(height: 5,),
                              Text(
                                'Title',
                                style:Theme.of(context).textTheme.labelMedium
                              ),
                            ],
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:4,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        mainAxisExtent: 100,
                      ),
                    ),
                  ),
                ),
                               ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/exchange2.png",
                        width: 250,
                      ),
                      Text(
                        "Best rate, Low fees, Special Offers",
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {},
      //   label: Text(
      //     "UgoCash Now",
      //     style: TextStyle(color: AppColors.textColor),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
