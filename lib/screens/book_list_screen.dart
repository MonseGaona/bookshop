import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../model/book.dart';
import 'book_detail_screen.dart';

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  List<Book> books = [];
  TextEditingController _searchController = TextEditingController();

  Future<void> fetchBooks(String searchTerm) async {
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=$searchTerm&maxResults=4'));
    print(searchTerm + "in");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> items = data['items'];
      List<Book> fetchedBooks =
          items.map<Book>((item) => Book.fromJSON(item['volumeInfo'])).toList();
      if (mounted) {
        setState(() {
          books = fetchedBooks;
        });
      }
    } else {
      print('Failed to load books');
    }
    print(books);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 90,
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                autofocus: true,
                controller: _searchController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: AppColors.darkPink,
                    fontSize: 20,
                  ),
                  labelText: 'Buscar libros',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: AppColors.Newpink,
                      size: 30,
                    ),
                    onPressed: () {
                      String searchTerm = _searchController.text;

                      if (searchTerm.isNotEmpty) {
                        fetchBooks(searchTerm);
                      }
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: books.length,
                itemBuilder: (context, index) {
                  Book book = books[index];
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BookDetailScreen(book: book),
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
                      ),
                      SizedBox(
                        height:
                            10, // Añade espacio de 10 unidades entre los libros.
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height:
                  10, // Añade espacio de 10 unidades al final de la columna.
            ),
          ],
        ),
      ),
    );
  }
}
