import 'package:app/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseProvider extends ChangeNotifier {
  List<ModelClass> user = [];

  List<ModelClass> getAllUsers() {
    FirebaseFirestore.instance
        .collection('users')
        .snapshots(includeMetadataChanges: true)
        .listen((users) {
      print("dtls" + users.docs[0].id);
      user = users.docs.map((doc) => ModelClass.fromJson(doc.data())).toList();

      notifyListeners();
    });
    return user;
  }
}
