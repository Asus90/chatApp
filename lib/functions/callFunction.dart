import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class callFunction {
  callconnect(number) async {
    if (number != null) {
      await FlutterPhoneDirectCaller.callNumber(number).then((value) {
        FirebaseFirestore.instance
            .collection("user")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection("dtls")
            .add({'number': number.toString()});
      });
    }
  }
}
