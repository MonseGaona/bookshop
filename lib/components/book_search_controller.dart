import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/book.dart';

class BookSearchController {
  Future<List<Book>> fetchBooks(String searchTerm) async {
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=$searchTerm&maxResults=4'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> items = data['items'];
      List<Book> fetchedBooks =
          items.map<Book>((item) => Book.fromJSON(item['volumeInfo'])).toList();

      return fetchedBooks;
    } else {
      throw Exception('Failed to load books');
    }
  }
}
