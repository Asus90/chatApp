import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFireServices {
  static Future<void> addTextMessage({
    required String content,
    required String receiverId,
  }) async {
    final senderId = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(senderId)
        .collection('UsersChats')
        .add({
      'chats': content,
      'time': Timestamp.now().toDate(),
      'receiverId': receiverId,
      "senderId": senderId
    });
  }
}
