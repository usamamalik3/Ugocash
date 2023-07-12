import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(InitialDashboardState()) {
    on<LoadDashboardEvent>((event, emit) async {
      try {
        final FirebaseAuth auth = FirebaseAuth.instance;
        User? user = FirebaseAuth.instance.currentUser;
        String? fundingid;
        String? cusid;
        String? email;

        if (user != null) {
          final DocumentSnapshot snap = await FirebaseFirestore.instance
              .collection('user')
              .doc(user.uid)
              .get();

          email = snap["email"];
          fundingid = snap["fundingid"];
          cusid = snap["customerid"];
        }

        if (fundingid != null) {
          final balance = await getBalance(fundingid);
          emit(SuccessDashboardState(email, fundingid, cusid, balance));
        } else {
          emit(ErrorDashboardState('Funding ID is null'));
        }
      } catch (e) {
        emit(ErrorDashboardState('An error occurred while loading dashboard: $e'));
      }
    });
  }

  Future<String> getBalance(String fundingSourceId) async {
    final response = await http.get(
      Uri.parse('https://www.ugoya.net/api/$fundingSourceId/fundingSources/getBalance'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String totalValue = data['value'];
      String currency = data['currency'];

      return '$totalValue $currency';
    } else {
      throw Exception('Failed to load balance');
    }
  }
}
