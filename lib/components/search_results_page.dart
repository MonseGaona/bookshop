import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../model/book.dart';
import '../screens/book_detail_screen.dart';

import 'package:flutter/material.dart';

class SearchResultsPage extends StatelessWidget {
  final List<Book> searchResults;

  SearchResultsPage({required this.searchResults});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados de Búsqueda'),
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          Book book = searchResults[index];
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailScreen(book: book),
                ),
              );
            },
            leading: book.imageURL != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      width: 45,
                      height: 70,
                      child: Image.network(
                        book.imageURL,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                : Container(),
            title: Text(
              book.title,
              style: textTheme.headlineSmall,
            ),
          );
        },
      ),
    );
  }
}
