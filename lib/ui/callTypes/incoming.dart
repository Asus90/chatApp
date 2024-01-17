import 'dart:convert';

import 'package:app/bloc/bloc/call_bloc.dart';
import 'package:app/functions/callFunction.dart';
import 'package:app/ui/dilogBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Incoming extends StatefulWidget {
  const Incoming({Key? key});

  @override
  State<Incoming> createState() => _IncomingState();
}

class _IncomingState extends State<Incoming> {
  @override
  void initState() {
    BlocProvider.of<CallBloc>(context).add(CallEvent.started());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallBloc, CallState>(
      builder: (context, state) {
        if (state != null) {
          // Assuming state.result is a List of models
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state
                      .result.length, // Use itemCount instead of itemBuilder
                  itemBuilder: (context, index) {
                    return Container(
                      child: ListTile(
                        title: Text(""),
                        subtitle: Text(state.result[index].number.toString()),
                        trailing: TextButton(
                          onPressed: () {
                            callFunction()
                                .callconnect(state.result[index].number);
                          },
                          child: Text("Call"),
                        ),
                      ),
                    );
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DilogBox();
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 8), // Added margin
                  child: Icon(
                    Icons.dialpad,
                    size: 30,
                  ),
                ),
              ),
            ],
          );
        } else {
          return SizedBox(); // Return an empty widget or loading indicator
        }
      },
    );
  }
}
