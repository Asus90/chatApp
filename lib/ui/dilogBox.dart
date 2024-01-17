import 'package:app/functions/callFunction.dart';
import 'package:flutter/material.dart';

class DilogBox extends StatelessWidget {
  const DilogBox({super.key});

  @override
  Widget build(BuildContext context) {
    final _TextEditingControllers = TextEditingController();

    return Dialog(
      child: Row(
        children: [
          Container(
              height: 40,
              width: 220,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _TextEditingControllers,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                callFunction().callconnect(_TextEditingControllers.text);
              },
              child: Container(
                  child: Icon(
                Icons.call,
                color: Color.fromARGB(255, 0, 55, 254),
              )),
            ),
          )
        ],
      ),
    );
  }
}
