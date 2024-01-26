class Book {
  final String id;
  final String title;
  final String imageURL;
  final String description;
  final List<String> authors;
  final List<String> categories;
  final String? webReaderLink;
  final String? publisher;
  final String? publishedDate;
  final int? pageCount;
  final double? price;
  final String? currencyCode;
  final double
      rating; // Cambié double? a double, y proporcioné un valor predeterminado

  Book({
    required this.id,
    required this.title,
    required this.imageURL,
    required this.description,
    required this.authors,
    required this.categories,
    required this.webReaderLink,
    this.publisher,
    this.publishedDate,
    this.pageCount,
    this.price,
    this.currencyCode,
    this.rating = 0.0, // Valor predeterminado para el rating
  });

  factory Book.fromJSON(Map<String, dynamic> json) {
    String id = json['id'] ?? 'Sin ID';
    String title = json['title'] ?? 'Sin titulo';

    String imageURL;
    if (json['imageLinks'] != null && json['imageLinks']['thumbnail'] != null) {
      imageURL = json['imageLinks']['thumbnail'];
    } else {
      imageURL =
          'https://i.pinimg.com/originals/55/5c/a2/555ca28baea4ce9064d87e6a3cf301d0.png';
    }

    String description = json['description'] ?? 'Sin descripcion';

    List<String> authors;
    if (json['authors'] != null) {
      authors = List<String>.from(json['authors']);
    } else {
      authors = ['Autor desconocido'];
    }

    List<String> categories;
    if (json['categories'] != null) {
      categories = List<String>.from(json['categories']);
    } else {
      categories = ['Categoria desconocida'];
    }

    String? webReaderLink = json['webReaderLink'] ?? 'No hay link';

    String? publisher = json['publisher'];

    String? publishedDate = json['publishedDate'];

    int? pageCount = json['pageCount'];
    double? price;
    String? currencyCode;

    double rating;
    if (json['volumeInfo'] != null &&
        json['volumeInfo']['averageRating'] != null) {
      rating = (json['volumeInfo']['averageRating'] as num).toDouble();
    } else {
      rating = 0.0; // Valor predeterminado si averageRating es null
    }

    if (json['saleInfo'] != null) {
      final saleInfo = json['saleInfo'];

      if (saleInfo['listPrice'] != null) {
        price = (saleInfo['listPrice']['amount'] as num).toDouble();
      }
    }

    return Book(
      id: id,
      title: title,
      imageURL: imageURL,
      description: description,
      authors: authors,
      categories: categories,
      webReaderLink: webReaderLink,
      publisher: publisher,
      publishedDate: publishedDate,
      pageCount: pageCount,
      price: price,
      currencyCode: currencyCode,
      rating: rating,
    );
  }
}
