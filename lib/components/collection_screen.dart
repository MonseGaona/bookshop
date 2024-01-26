import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../model/book.dart';
import 'collection_provider_screen.dart';
import '../screens/book_detail_screen.dart';

class CollectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Book> cartItems =
        Provider.of<CollectionProvider>(context).getCollectionItems();

    return Scaffold(
      body: cartItems.length == 0
          ? Container(
              margin: EdgeInsets.all(30),
              child: Text(
                "No se encontraron libros.",
                style: textTheme.titleLarge?.copyWith(
                  color: Colors.black38,
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.only(
                top: 20.0,
                bottom: 5.0,
              ),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                Book book = cartItems[index];
                return ListTile(
                  leading: book.imageURL != null
                      ? Container(
                          width: 50,
                          height: 80,
                          child: Image.network(
                            book.imageURL,
                            fit: BoxFit.fill,
                          ),
                        )
                      : Container(),
                  title: Text(
                    book.title,
                    style: GoogleFonts.sen(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFD66D75),
                    ),
                    onPressed: () {
                      // Remover el libro al presionar el boton.
                      Provider.of<CollectionProvider>(context, listen: false)
                          .removeFromCollection(book);
                    },
                    child: Text(
                      'Remover',
                      style: GoogleFonts.sen(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  onTap: () {
                    // Navegar a BookDetailPage.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailScreen(book: book),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
