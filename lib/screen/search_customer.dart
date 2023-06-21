import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class SearchCustomer extends StatefulWidget {
  @override
  _SearchCustomerState createState() => _SearchCustomerState();
}

class _SearchCustomerState extends State<SearchCustomer> {
  String _email = '';
  List<dynamic> _fundingSources = [];
  bool _isLoading = false;

  Future<void> _searchFundingSources() async {
    setState(() {
      _isLoading = true;
    });

    // TODO: Replace with your Dwolla API endpoint and credentials
    final String apiUrl = 'https://api.dwolla.com/v2/customers';
    final String apiKey = 'YOUR_API_KEY';
    final String apiSecret = 'YOUR_API_SECRET';

    final String authString = base64.encode(utf8.encode('$apiKey:$apiSecret'));
    final Map<String, String> headers = {
      'Authorization': 'Basic $authString',
    };

    final response = await http.get(Uri.parse('$apiUrl?search=$_email'), headers: headers);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        _fundingSources = responseData['_embedded']['funding-sources'];
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      // Handle error
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Funding Sources'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Email',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchFundingSources();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _fundingSources.isEmpty
                    ? Center(child: Text('No funding sources found.'))
                    : ListView.builder(
                        itemCount: _fundingSources.length,
                        itemBuilder: (context, index) {
                          final fundingSource = _fundingSources[index];
                          return ListTile(
                            title: Text(fundingSource['bankName']),
                            subtitle: Text(fundingSource['type']),
                            trailing: Text('\$${fundingSource['balance']['value']}'),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
