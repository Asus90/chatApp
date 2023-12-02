import 'dart:ui';

import 'package:app/model/model.dart';
import 'package:app/screens/Auth/chatScreen.dart';
import 'package:flutter/material.dart';

class UserItems extends StatefulWidget {
  final ModelClass user;
  final List<ModelClass> index;

  UserItems({required this.user, required this.index});

  @override
  State<UserItems> createState() => _UserItemsState();
}

class _UserItemsState extends State<UserItems> {
  @override
  Widget build(BuildContext context) {
    print("newid" + widget.user.Uid);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChatScreen(
            User: widget.user,
          ),
        ));
      },
      // onLongPress: () {
      //   print("Long press");

      //   showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return AlertDialog(
      //         actions: [
      //           TextButton(
      //             onPressed: () {
      //               print("Profile");
      //               // Close the dialog
      //               Navigator.of(context).pop();
      //             },
      //             child: IconButton(
      //                 onPressed: () {
      //                   print(widget.user.Uid);
      //                 },
      //                 icon: Icon(Icons.person_3)),
      //           ),
      //         ],
      //       );
      //     },
      //   );
      // },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
                radius: 30, backgroundImage: NetworkImage(widget.user.image)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor:
                    widget.user.IsOnline ? Colors.green : Colors.grey,
                radius: 5,
              ),
            ),
          ],
        ),
        title: Text(
          widget.user.name,
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          widget.user.lastActive,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
