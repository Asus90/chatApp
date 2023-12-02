import 'package:app/screens/Auth/searchFL.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomSearchWidget extends StatelessWidget {
  final List<String> searchTerms = [
    "Apple",
    "Banana",
    "Mango",
    "Pear",
    "Watermelons",
    "Blueberries",
    "Pineapples",
    "Strawberries"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: CustomSearchBody(searchTerms: searchTerms),
    );
  }
}

class CustomSearchBody extends StatelessWidget {
  final List<String> searchTerms;

  const CustomSearchBody({Key? key, required this.searchTerms})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchFL searchFL = SearchFL();
    final conlroller = TextEditingController();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: conlroller,
            decoration: InputDecoration(
              hintText: 'Search...',
              suffixIcon: IconButton(
                onPressed: () {
                  searchFL.setKeyword(conlroller.text);
                },
                icon: Icon(Icons.search),
              ),
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<Object?>>(
            stream: searchFL.searchQr(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              final List<QueryDocumentSnapshot<Object?>> documents =
                  snapshot.data!.docs;
              print("id" + documents[0].id);
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  var result = documents[index]['name'];
                  return ListTile(
                    title: Text(result),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
