import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/constants.dart';
import '../model/book.dart';
import '../components/collection_provider_screen.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;

  BookDetailScreen({super.key, required this.book});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  bool isInCollection = false;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    checkCollectionStatus();
  }

  Future<void> checkCollectionStatus() async {
    List<Book> cartItems =
        Provider.of<CollectionProvider>(context, listen: false)
            .getCollectionItems();

    setState(() {
      isInCollection = cartItems.contains(widget.book);
    });
  }

  Future<void> toggleCollectionStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isInCollection = !isInCollection;
      prefs.setBool('isInCollection_${widget.book.id}', isInCollection);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7E5E5),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Center(
          child: Text(
            widget.book.title,
            style: textTheme.displayLarge?.copyWith(
              color: AppColors.black,
            ),
          ),
        ),
        backgroundColor: Color(0xFFE7E5E5),
        elevation: 0,
        actions: <Widget>[
          if (isInCollection)
            IconButton(
              icon: Icon(
                Icons.bookmark_added_outlined,
                color: AppColors.darkBlue,
              ),
              onPressed: () {
                Provider.of<CollectionProvider>(context, listen: false)
                    .removeFromCollection(widget.book);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.BlueDark,
                    content: Text(
                      'Eliminado de mi colección',
                      style: textTheme.displayMedium,
                    ),
                    duration: Duration(seconds: 2),
                  ),
                );
                checkCollectionStatus();
              },
            ),
          if (!isInCollection)
            IconButton(
              color: AppColors.black,
              icon: Icon(
                Icons.bookmark_add_rounded,
              ),
              onPressed: () {
                Provider.of<CollectionProvider>(context, listen: false)
                    .addToCollection(widget.book);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.BlueDark,
                    content: Text(
                      'Añadido a mi colección',
                      style: textTheme.displayMedium,
                    ),
                    duration: Duration(
                      seconds: 2,
                    ),
                  ),
                );
                checkCollectionStatus();
              },
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.book.imageURL != ""
                ? Image.network(
                    widget.book.imageURL,
                    width: 220, // Establece el ancho deseado
                    height: 200, // Establece la altura deseada
                  )
                : Container(
                    width: 200, // Establece el ancho deseado
                    height: 200, // Establece la altura deseada
                    child: Image.asset("assets/image-not-available.png"),
                  ),
            SizedBox(height: 15),
            Text(
              widget.book.authors.join(", "),
              style: textTheme.displayMedium,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.book.categories.join(", ")}',
                  style: textTheme.displayMedium,
                ),
                SizedBox(width: 16),
                Text(
                  '${widget.book.publishedDate}',
                  style: textTheme.displayMedium,
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: FractionallySizedBox(
                            widthFactor: 1.0,
                            child: ReadMoreText(
                              'Sinopsis: \n\n${widget.book.description}',
                              textAlign: TextAlign.justify,
                              style: textTheme.bodyLarge,
                              trimLines: 8,
                              colorClickableText: Colors.black54,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'más',
                              trimExpandedText: '   menos',
                              moreStyle: GoogleFonts.breeSerif(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              lessStyle: GoogleFonts.breeSerif(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // if (isInCart)
                          IconButton(
                            color: isLiked
                                ? AppColors.darkPink
                                : AppColors.BlueDark,
                            icon: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                            ),
                            onPressed: () {
                              setState(() {
                                isLiked = !isLiked;
                              });
                            },
                          ),
                          // if (!isInCart)
                          // IconButton(
                          //   color: AppColors.darkPink,
                          //   icon: Icon(Icons.favorite),
                          //   onPressed: () {},
                          // ),
                          if (widget.book.webReaderLink != null)
                            FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColors.BlueDark,
                              ),
                              onPressed: () async {
                                if (widget.book.webReaderLink != null) {
                                  String? webReaderLink =
                                      widget.book.webReaderLink;
                                  if (webReaderLink != null) {
                                    Uri launchUri = Uri.parse(webReaderLink);
                                    if (await canLaunchUrl(launchUri)) {
                                      await launchUrl(launchUri);
                                    } else {
                                      throw 'No se puede abrir el enlace $webReaderLink';
                                    }
                                  } else {}
                                }
                              },
                              child: Text(
                                'Leer',
                                style: textTheme.displayMedium?.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
