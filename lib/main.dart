import 'package:app/bloc/bloc/call_bloc.dart';
import 'package:app/login/login.dart';
import 'package:app/ui/ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final user = FirebaseAuth.instance.currentUser;
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CallBloc>(create: (context) => CallBloc()),
        // Add other BlocProviders if needed
      ],
      child: MyApp(user: user),
    ),
  );
}

class MyApp extends StatelessWidget {
  final User? user;
  const MyApp({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Main(user: user),
    );
  }
}

class Main extends StatelessWidget {
  final User? user;
  const Main({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
      future: _checkUserInFirestore(user),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          );
        } else {
          if (snapshot.data != null) {
            return Ui();
          } else {
            return LoginScreen();
          }
        }
      },
    );
  }
}

Future<Object> _checkUserInFirestore(User? user) async {
  if (user == null) {
    return false;
  }

  final userData = await FirebaseFirestore.instance
      .collection("user")
      .doc(user.uid)
      .collection("uids")
      .get();

  return userData;
}
