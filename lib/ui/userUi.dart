import 'package:app/ui/callTypes/incoming.dart';
import 'package:app/ui/callTypes/missedCall.dart';
import 'package:app/ui/callTypes/outGoing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app/functions/firebase.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class UserUi extends StatefulWidget {
  const UserUi({Key? key}) : super(key: key);

  @override
  _UserUiState createState() => _UserUiState();
}

class _UserUiState extends State<UserUi> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Call History"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Incoming"),
            Tab(text: "Outgoing"),
            Tab(text: "Missed"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CallList(callType: CallType.incoming),
          CallList(callType: CallType.outgoing),
          CallList(callType: CallType.missed),
        ],
      ),
    );
  }
}

enum CallType { incoming, outgoing, missed }

class CallList extends StatelessWidget {
  final CallType callType;

  const CallList({Key? key, required this.callType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(callType.index);

    if (callType.index == 0) {
      return Incoming();
    } else if (callType.index == 1) {
      return OutGoing();
    } else {
      return MissedCall();
    }
  }
}
