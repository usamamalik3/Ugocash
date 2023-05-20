import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:ugocash/styles/colors.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}
final List dummyList = List.generate(10, (index) {
    return {
      "id": "This is the dummytitle $index",
      "title": "dummy Data $index",
      "subtitle": "\$100"
    };
  });
class _TransactionHistoryState extends State<TransactionHistory> {
  TextEditingController dateInput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: const Text("Transaction history"),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: dateInput,
                style: Theme.of(context).textTheme.labelMedium,
                decoration: InputDecoration(
                  hintText: "01/01/2023",
                  label: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Transaction Date",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
                readOnly: true,
                onTap: () async {
                  var datePicked = await DatePicker.showSimpleDatePicker(
                    
                    context,
                    initialDate: DateTime(2023),
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2050),
                    dateFormat: "dd-MM-yyyy",
                    locale: DateTimePickerLocale.en_us,
                    looping: false,
                    titleText: "Transaction Date",
                    backgroundColor: AppColors.secondaryColor,
                    textColor: AppColors.textColor2
                  );
                  if (datePicked == null) {
                    return;
                  } //ternary expression to check if date is null
                  else {
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(datePicked);
                    setState(() {
                      dateInput.text = formattedDate;
                    });
                  }
                },
              ),
              SizedBox(height: 20,),
              Expanded(
                flex: 5,
                child: ListView.builder(
                    itemCount: dummyList.length,
                    itemBuilder: (context, index) => Card(
                      elevation: 6,
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                leading: const CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                       
                ),
                title: Text(dummyList[index]["id"]),
                subtitle: Text(dummyList[index]["title"]), 
                trailing: Text(dummyList[index]["subtitle"]),
                      ),
                    ),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
