import 'package:app/failure/failure.dart';
import 'package:app/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseFunction {
  Future<Either<MainFailure, List<model>>> firebaseGetData() async {
    try {
      final user = FirebaseAuth.instance.currentUser?.uid;
      final data = await FirebaseFirestore.instance
          .collection('user')
          .doc(user)
          .collection("dtls")
          .get();

      if (data != null) {
        // Convert QuerySnapshot to List<Model>
        final List<model> result =
            data.docs.map((DocumentSnapshot<Map<String, dynamic>> doc) {
          return model.fromJson(doc.data()!);
        }).toList();
        print(result[0].number);

        return right(result);
      } else {
        return Left(MainFailure.serverFailure());
      }
    } catch (e) {
      print(e.toString());
      return left(MainFailure.ClientFailure());
    }
  }
}
