import 'package:cloud_firestore/cloud_firestore.dart';

class SearchFL {
  late String _keyword = 'ffff';

  // Public method to set the keyword
  void setKeyword(String keyword) {
    _keyword = keyword;
  }

  Stream<QuerySnapshot<Object?>>? searchQr() {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');

    final Stream<QuerySnapshot<Object?>> resultStream =
        users.where('name', isEqualTo: _keyword).snapshots();
    print(resultStream);

    return resultStream;
  }
}
