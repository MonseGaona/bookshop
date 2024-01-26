import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../model/book.dart';
import '../screens/book_detail_screen.dart';

class genreList extends StatefulWidget {
  final String genre;

  const genreList({required this.genre, required List<String> genres});

  @override
  State<genreList> createState() => _genreListState();
}

class _genreListState extends State<genreList> {
  List<Book> books = [];
  bool isLoading = true;

  Future<void> fetchGenre(String genre) async {
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=subject:$genre&maxResults=5'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> items = data['items'];
      List<Book> fetchedBooks =
          items.map<Book>((item) => Book.fromJSON(item['volumeInfo'])).toList();

      if (mounted) {
        setState(() {
          books = fetchedBooks;
          isLoading = false;
        });
      }
    } else {
      print('Failed to load books');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchGenre(widget.genre);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          widget.genre,
          style: textTheme.titleMedium,
        ),
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
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
                            builder: (context) => BookDetailScreen(book: book),
                          ),
                        );
                      },
                      contentPadding: EdgeInsets.all(10),
                      title: Container(
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Imagen con bordes redondeados
                            Container(
                              margin: EdgeInsets.all(15),
                              width: 150,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  book.imageURL,
                                  width: 150,
                                  height: 221,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            // Título y Descripción
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      book.title,
                                      style: textTheme.displaySmall?.copyWith(
                                        fontSize: 18,
                                        color: AppColors.black,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      book.description,
                                      maxLines: 4, // Limitar a cuatro líneas
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: AppColors.black,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // IconButton(
                            //   color: AppColors.white,
                            //   onPressed: () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) =>
                            //             BookDetailScreen(book: book),
                            //       ),
                            //     );
                            //   },
                            //   icon: Icon(
                            //     Icons.arrow_forward_ios_rounded,
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                    Divider(color: AppColors.black), // Línea divisoria
                  ],
                );
              },
            ),
    );
  }
}
