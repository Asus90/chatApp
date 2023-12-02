import 'package:app/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final controllerPass = TextEditingController();
    final controllerEmail = TextEditingController();
    final controllerName = TextEditingController();
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
              onPressed: () {
                LoginFunction(controllerEmail.text, controllerPass.text,
                    controllerName.text, context);
              },
              icon: Icon(Icons.login),
              label: Text("Login")),
          Container(
            color: Color.fromARGB(255, 0, 157, 255).withOpacity(0.1),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width - 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        20), // Make the container circular
                    color: const Color.fromARGB(
                        255, 211, 209, 209), // Set a background color
                  ),
                  child: TextFormField(
                    controller: controllerPass,
                    decoration: InputDecoration(
                      border: InputBorder
                          .none, // Remove the border around the TextFormField
                      hintText: 'Enter your password', // Add a hint text
                      contentPadding: EdgeInsets.all(16.0), // Adjust padding
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width - 10,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(20), // Make the container circular
              color: const Color.fromARGB(
                  255, 211, 209, 209), // Set a background color
            ),
            child: TextFormField(
              controller: controllerEmail,
              decoration: InputDecoration(
                border: InputBorder
                    .none, // Remove the border around the TextFormField
                hintText: 'Enter your Email', // Add a hint text
                contentPadding: EdgeInsets.all(16.0), // Adjust padding
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width - 10,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(20), // Make the container circular
              color: const Color.fromARGB(
                  255, 211, 209, 209), // Set a background color
            ),
            child: TextFormField(
              controller: controllerName,
              decoration: InputDecoration(
                border: InputBorder
                    .none, // Remove the border around the TextFormField
                hintText: 'Enter your Name', // Add a hint text
                contentPadding: EdgeInsets.all(16.0), // Adjust padding
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> LoginFunction(emial, pass, name, ctx) async {
  final user = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: emial, password: pass);
  if (user != null) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.user?.uid)
        .set({'name': name, 'uid': FirebaseAuth.instance.currentUser!.uid});
    print("succed");
  }
  Navigator.of(ctx).pushReplacement(MaterialPageRoute(
    builder: (context) => HomeScreen(),
  ));
}
