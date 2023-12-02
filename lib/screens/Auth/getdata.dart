import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<QuerySnapshot<Map<String, dynamic>>> getdata(id) async {
  final data = await FirebaseFirestore.instance
      .collection("users")
      .doc()
      .collection("chats")
      .get();
  return data;
}
