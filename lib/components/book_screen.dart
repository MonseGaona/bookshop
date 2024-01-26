import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../model/book.dart';
import '../screens/book_detail_screen.dart';

class bookGrid extends StatefulWidget {
  const bookGrid({Key? key});

  @override
  State<bookGrid> createState() => _bookGridState();
}

class _bookGridState extends State<bookGrid> {
  Future<List<Book>> suggestBooks() async {
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=flowers&orderBy=newest&maxResults=4'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> items = data['items'];
      List<Book> suggBooks =
          items.map<Book>((item) => Book.fromJSON(item['volumeInfo'])).toList();
      return suggBooks;
    } else {
      print('Failed to load books');
      return []; // retornar una lista vacia, si hay algun error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.Newpink,
        elevation: 0,
        title: Text(
          'Libros de Flores',
          style: textTheme.displaySmall,
        ),
      ),
      body: FutureBuilder<List<Book>>(
        future: suggestBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load books'));
          } else {
            List<Book> sbooks = snapshot.data!;
            return ListView.builder(
              itemCount: sbooks.length,
              itemBuilder: (BuildContext context, int index) {
                final Book book = sbooks[index];
                return buildListItem(book);
              },
            );
          }
        },
      ),
    );
  }

  Widget buildListItem(Book book) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailScreen(book: book),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
          margin: EdgeInsets.all(10.0),
          elevation: 0.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: book.imageURL != null
                        ? Image.network(
                            book.imageURL,
                            fit: BoxFit.fill,
                            height: 200,
                          )
                        : Container(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          book.title,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.labelLarge?.copyWith(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          book.authors.join(", "),
                          style: textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
