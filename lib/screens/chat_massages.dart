import 'package:app/screens/chat_model.dart';
import 'package:app/screens/massageBoble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatMessages extends StatelessWidget {
  ChatMessages({super.key, required this.recicverId});
  final String recicverId;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> initialData =
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('chats')
            .doc(recicverId)
            .collection('UsersChats')
            .orderBy('time', descending: true)
            .snapshots();

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: initialData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final data = snapshot.data;

          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: getdata(recicverId),
            builder: (context, streamSnapshot) {
              if (streamSnapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (streamSnapshot.hasError) {
                return Text('Error: ${streamSnapshot.error}');
              } else {
                final streamData = streamSnapshot.data;

                final messages = [
                  ...data!.docs.map((doc) => ChatModel.fromJson(doc.data())),
                  ...streamData!.docs.map(
                      (doc) => ChatModel.fromJson(doc.data())), // Combine data
                ];

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    print(messages.length);
                    final isMe = messages[index].senredId ==
                        FirebaseAuth.instance.currentUser!.uid;
                    print(messages[index].senredId);
                    return MassageBoble(
                      isImage: false,
                      isMe: isMe,
                      message: messages[index],
                    );
                  },
                );
              }
            },
          );
        }
      },
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getdata(id) {
    print(id);
    final user = FirebaseAuth.instance.currentUser?.uid;

    return FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("chats")
        .doc(user)
        .collection('UsersChats')
        .orderBy('time', descending: true)
        .snapshots();
  }
}
