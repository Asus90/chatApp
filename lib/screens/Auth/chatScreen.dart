import 'package:app/model/model.dart';
import 'package:app/screens/chat_massages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/Auth/firestore_servicve.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.User});

  final ModelClass User;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    print("uids of yours" + FirebaseAuth.instance.currentUser!.uid);
    final controller = TextEditingController();
    return Scaffold(
      appBar: _BuildAppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ChatMessages(
                recicverId: widget.User.Uid,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: "Type here",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {
                      _sendText(context, controller.text);
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.green,
                      size: 30,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar _BuildAppBar() => AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.User.image),
              radius: 20,
            ),
            Text(
              " ${widget.User.name}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              " ${widget.User.IsOnline ? 'Online' : "Offline"}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            )
          ],
        ),
      );
  Future<void> _sendText(BuildContext context, msg) async {
    await FirebaseFireServices.addTextMessage(
      content: msg,
      receiverId: widget.User.Uid.toString(),
    );

    print(widget.User.Uid.toString());
  }
}
