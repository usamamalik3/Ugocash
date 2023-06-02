import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ugocash/global.dart';
import 'package:ugocash/styles/colors.dart';
import 'package:http/http.dart' as http;

class ConfirmTranscation extends StatefulWidget {
  const ConfirmTranscation({super.key, required this.ciid});
  final String ciid;

  @override
  State<ConfirmTranscation> createState() => _ConfirmTranscationState();
}

class _ConfirmTranscationState extends State<ConfirmTranscation> {
  Future<String> createTransaction(String sourceFundingSource,
      String destinationFundingSource, double amount) async {
    final url = 'https://api.dwolla.com/transfers';

    final body = json.encode({
      'amount': {
        'currency': 'USD',
        'value': amount.toString(),
      },
      '_links': {
        'source': {'href': sourceFundingSource},
        'destination': {'href': destinationFundingSource},
      },
    });

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': "application/json",
      },
      body: body,
    );

    if (response.statusCode == 201) {
      final responseBody = json.decode(response.body);
      final transferId = responseBody['_links']['self']['href'];
      return transferId;
    } else {
      throw Exception('Failed to create transaction');
    }
  }

  String cusid = GlobalVariables.customerId;

  Future<Map<String, dynamic>> getFundingSource(String customerId) async {
    final url = 'https://api.dwolla.com/customers/$cusid/funding-sources';

    final response = await http.get(
      Uri.parse(url),
      headers: {},
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return responseBody;
    } else {
      throw Exception('Failed to fetch funding sources');
    }
  }

  Future<Map<String, dynamic>> getdestinationFundingSource(
      String customerId) async {
    String desid = widget.ciid;

    final url = 'https://api.dwolla.com/customers/$desid/funding-sources';

    final response = await http.get(
      Uri.parse(url),
      headers: {},
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return responseBody;
    } else {
      throw Exception('Failed to fetch funding sources');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                height: 100,
                width: width * width * .9,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey,
                        child: Image.asset("assets/images/bank.png"),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "City Bank",
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Transcation Details",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Divider(
                          color: AppColors.textColor2,
                          thickness: 0.5,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "To",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              "Dummy",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Divider(
                          color: AppColors.textColor2,
                          thickness: 0.5,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "credit card",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              "Dummy",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Divider(
                          color: AppColors.textColor2,
                          thickness: 0.5,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Transaction fee",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              "Dummy",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Divider(
                          color: AppColors.textColor2,
                          thickness: 0.5,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total ammount",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              "\$125489",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ]),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Transfer pin",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.credit_card,
                              color: AppColors.textColor2,
                            ),
                            hintText: "***",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                    width: 1.0, color: AppColors.textColor2)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                    width: 1.0, color: AppColors.textColor2)),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: width * 0.7,
                child: ElevatedButton(
                  onPressed: () {
                    // _loginWithPhoneNumber(phonecontroller.text);

                    Navigator.pushReplacementNamed(context, "/login");
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      'Press to transfer money',
                      style:
                          TextStyle(fontSize: 16, color: AppColors.textColor),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
