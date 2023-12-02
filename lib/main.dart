import 'package:app/provider/firebase_provider.dart';
import 'package:app/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/Auth/login_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  // Note the 'async' keyword
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCW1D3azMrrUTOgzjv6sroQZnAMOQiL2go",
      appId: "1:98016927812:android:eb72647a53bfe0bec19c11",
      messagingSenderId: "98016927812",
      projectId: "new12-2ac93",
    ),
  ); // Await Firebase initialization
  final user = FirebaseAuth.instance.currentUser;

  runApp(
    MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => FirebaseProvider(),
        child: MyApp(user: user),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final User? user;

  const MyApp({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr, // Or TextDirection.rtl
      child: FutureBuilder(
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
            if (snapshot.data == true) {
              return HomeScreen();
            } else {
              return LoginScreen();
            }
          }
        },
      ),
    );
  }
}

Future<bool> _checkUserInFirestore(User? user) async {
  if (user == null) {
    return false;
  }

  final userData =
      await FirebaseFirestore.instance.collection("users").doc(user.uid).get();

  return userData.exists;
}
