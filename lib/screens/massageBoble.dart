import 'package:app/screens/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MassageBoble extends StatelessWidget {
  const MassageBoble(
      {super.key,
      required this.message,
      required this.isMe,
      required this.isImage});
  final ChatModel message;
  final bool isMe;
  final bool isImage;

  @override
  Widget build(BuildContext context) {
    final formattedTime = DateFormat('h:mm a').format(message.time.toLocal());
    print('data' + message.chats);
    return Align(
      alignment: isMe ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        decoration: BoxDecoration(
            color: isMe
                ? const Color.fromARGB(255, 209, 209, 209).withOpacity(0.2)
                : Colors.blue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(
          top: 10,
          right: 10,
          left: 10,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                message.chats,
                style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    fontSize: 15),
              ),
              Text(
                textAlign: TextAlign.left,
                formattedTime,
                style: TextStyle(
                  fontSize: 10,
                  color: const Color.fromARGB(255, 146, 146, 146),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
