import 'package:bookshop/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/book.dart';
import '../screens/book_detail_screen.dart';
import '../widgets/two_side_rounded_button.dart';

class AllBooksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos los Libros'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder<List<Book>>(
          future: fetchAllBooks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error al cargar libros'));
            } else {
              List<Book> allBooks = snapshot.data!;
              return ListView.builder(
                itemCount: allBooks.length,
                itemBuilder: (context, index) {
                  final Book book = allBooks[index];
                  var pressRead;
                  return Container(
                    margin: EdgeInsets.only(
                      left: 24,
                      bottom: 40,
                    ),
                    height: 245,
                    width: 202,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 221,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(29),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 10),
                                  blurRadius: 23,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Image.network(
                          book.imageURL,
                          fit: BoxFit.fill,
                          width: 150,
                        ),
                        Positioned(
                          top: 35,
                          right: 10,
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.favorite_border,
                                ),
                                onPressed: () {},
                              ),
                              // BookRating(
                              //   score: rating,
                              // ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 160,
                          child: Container(
                            height: 85,
                            width: 202,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 24),
                                  child: RichText(
                                    maxLines: 2,
                                    text: TextSpan(
                                      style:
                                          TextStyle(color: AppColors.darkPink),
                                      children: [
                                        TextSpan(
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          style: TextStyle(
                                            color: AppColors.darkPink,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  children: <Widget>[
                                    GestureDetector(
                                      child: Container(
                                        width: 101,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        alignment: Alignment.center,
                                        child: Text("Details"),
                                      ),
                                    ),
                                    Expanded(
                                      child: TwoSideRoundedButton(
                                        text: "Read",
                                        press: pressRead,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<Book>> fetchAllBooks() async {
    final response = await http.get(
      Uri.parse(
          'https://www.googleapis.com/books/v1/volumes?q=bookfree-ebookst'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> items = data['items'];
      List<Book> allBooks =
          items.map<Book>((item) => Book.fromJSON(item['volumeInfo'])).toList();
      return allBooks;
    } else {
      throw Exception('Failed to load all books');
    }
  }
}
