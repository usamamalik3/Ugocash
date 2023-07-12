
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ugocash/models/user_model.dart';

class  DatabaseServices{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
   User? user = FirebaseAuth.instance.currentUser;
  adduser(UserModel userdata) async{
  await _db.collection("user").doc(user!.uid).set(userdata.toMap());
}
updateuser(Map<String, dynamic> userdata, String documentid) async{
  await _db.collection("user").doc(documentid).update(userdata).then((value) => {
     Fluttertoast.showToast(
            msg: "updated succesfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0),
  });

}
}