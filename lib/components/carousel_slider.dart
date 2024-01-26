import 'package:bookshop/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/book.dart';
import '../screens/book_detail_screen.dart';

class carouselCard extends StatefulWidget {
  @override
  _CarouselCardState createState() => _CarouselCardState();
}

class _CarouselCardState extends State<carouselCard> {
  Future<List<Book>> fetchBooks() async {
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=bookfree-ebookst&maxResults=5'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> items = data['items'];
      List<Book> fetchedBooks =
          items.map<Book>((item) => Book.fromJSON(item['volumeInfo'])).toList();
      return fetchedBooks;
    } else {
      print('Failed to load books');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: fetchBooks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Failed to load books'));
        } else {
          List<Book> fbooks = snapshot.data!;
          return Container(
            height: 250, // la altura de las imagenes

            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: fbooks.length,
              itemBuilder: (context, index) {
                final Book book = fbooks[index];
                return buildSlider(book);
              },
            ),
          );
        }
      },
    );
  }

  Widget buildSlider(Book book) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailScreen(book: book),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            width: 150, // ancho de la imagen
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                // Imagen del libro
                book.imageURL != null
                    ? Image.network(
                        book.imageURL,
                        fit: BoxFit.fill,
                        height: 170,
                      )
                    : Container(),
                // Título del libro
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    book.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Autor del libro
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    book.authors.join(", "),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1, // ajusta según sea necesario
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
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
