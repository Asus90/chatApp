import 'dart:io';

import 'package:app/provider/firebase_provider.dart';
import 'package:app/screens/Auth/search.dart';
import 'package:app/screens/userite,.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false).getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Like Chat"),
        actions: [
          Padding(
              padding: const EdgeInsets.all(4.0),
              child: FutureBuilder<String>(
                  future: DLImage(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading...");
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final data = snapshot.data;
                      print("imae  :" + data!);

                      return GestureDetector(
                        onTap: () {
                          Imaepicker();
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(data),
                        ),
                      );
                    }
                  })),
        ],
      ),
      body: Consumer<FirebaseProvider>(
        builder: (context, firebaseProvider, child) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ),
            physics: BouncingScrollPhysics(),
            itemCount: firebaseProvider.user.length,
            itemBuilder: (context, index) => UserItems(
              index: firebaseProvider.user,
              user: firebaseProvider.user[index],
            ),
          );
        },
      ),
    );
  }
}

Future Imaepicker() async {
  try {
    final result = await FilePicker.platform.pickFiles();
    if (result == null || result.files.isEmpty) {
      // User canceled the file picking
      return;
    }

    final filePath = result.files.first.path;
    if (filePath == null) {
      print('File path is null');
      return;
    }

    final fileName = result.files.first.name;
    final file = File(filePath);

    if (!file.existsSync()) {
      print('File does not exist at path: $filePath');
      return;
    }
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final path = 'file/$userId/${fileName}';
    final ref = FirebaseStorage.instance.ref().child(path);
    await ref.putFile(file);

    final ref1 = FirebaseStorage.instance.ref().getData();
    print(ref1);

    print('File uploaded successfully');
  } catch (e) {
    print('Error picking or uploading file: $e');
  }
}

Future<String> DLImage() async {
  final ref = FirebaseStorage.instance
      .ref()
      .child('file/A0NttbLyXnX1cZQnotrCXlo3IGl1/pexels-pixabay-60597.jpg');
  final downloadURL = await ref.getDownloadURL();
  return downloadURL;
}
