import 'package:flutter/material.dart';
import 'package:ugocash/styles/colors.dart';

class RecipientScreen extends StatefulWidget {
  const RecipientScreen({super.key});

  @override
  State<RecipientScreen> createState() => _RecipientScreenState();
}

class _RecipientScreenState extends State<RecipientScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:   Text(
              "Recipients",
             
            ),),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
            Card(
              
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            radius: 30,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.person,
                                size: 30,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(width: 20,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children:  [
                              Text(
                                "name",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                             
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () async {
                            //   DatabaseService databaseService = DatabaseService();
                            //   final result = await showDialog<bool>(
                            //             context: context,
                            //             builder: (context) => AlertDialog(
                            //               title: const Text('ڈیلیٹ?'),
                            //               content: const Text('کیا آپ واقعی ڈیلیٹ کرنا چاہتے ہیں۔'),
                            //               actions: [
                            //                 TextButton(
                            //                   onPressed: () => Navigator.pop(context, false),
                            //                   child: const Text('منسوخ'),
                            //                 ),
                            //                 TextButton(
                            //                   onPressed: () => Navigator.pop(context, true),
                            //                   child: const Text('ڈیلیٹ'),
                            //                 ),
                            //               ],
                            //             ),
                            //           );

                            //           if (result == null || !result) {
                            //             return;
                            //           }
                            //  await databaseService.deletebody(documentid);
                          },
                          icon: Icon(Icons.delete)),
                    ],
                  ),
                ))
        ],
      ),
          )),
          floatingActionButton: FloatingActionButton(onPressed: () {
            Navigator.pushNamed(context, "/addrecipient");
            
          },
          child: Icon(Icons.add, color: AppColors.textColor,),),
    );
  }
}
