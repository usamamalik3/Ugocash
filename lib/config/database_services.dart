
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ugocash/models/user_model.dart';

class  DatabaseServices{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
   User? user = FirebaseAuth.instance.currentUser;
  adduser(UserModel userdata) async{
  await _db.collection("user").doc(user!.uid).set(userdata.toMap());
}
}