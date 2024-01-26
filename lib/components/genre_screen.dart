import 'dart:convert';
import 'package:bookshop/components/genre_list.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class genreScreen extends StatefulWidget {
  const genreScreen({Key? key}) : super(key: key);

  @override
  State<genreScreen> createState() => _genreScreen();
}

class _genreScreen extends State<genreScreen> {
  List<String> genres = [
    'Fiction',
    'NonFiction',
    'Mystery',
    'Romance',
    'SciFi',
    'Fantasy',
    'Horror',
    'Thriller',
    'Biography',
    'History',
    'Self-Help',
    'Cooking',
    'Science',
    'Poetry',
    'Travel',
    'Anime',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Text(
          //     "Géneros",
          //     style: GoogleFonts.sen(
          //       textStyle: TextStyle(
          //         fontSize: 27,
          //         fontWeight: FontWeight.normal,
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Dos columnas
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 4 / 5, // Tamaño mediano
                ),
                itemCount: genres.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => genreList(
                            genre: genres[index],
                            genres: genres, // Pasa la lista de géneros
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15.0), // Bordes redondeados
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              15.0,
                            ), // Bordes redondeados para la imagen
                            child: Image.asset(
                              'assets/${genres[index]}.jpg',
                              fit: BoxFit
                                  .cover, // La imagen se ajusta al tamaño del contenedor
                            ),
                          ),
                          Center(
                            child: Text(
                              genres[index],
                              style: textTheme.displaySmall?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
