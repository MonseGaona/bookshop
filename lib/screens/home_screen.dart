import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/all_books_page.dart';
import '../components/book_search_controller.dart';
import '../components/search_results_page.dart';
import '../constants/constants.dart';
import '../model/book.dart';
import 'book_detail_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/book_screen.dart';

import '../components/carousel_slider.dart';
import '../components/user_data.dart';
import '../constants/constants.dart';
import '../model/book.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  TextEditingController _searchController = TextEditingController();
  BookSearchController _bookSearchController = BookSearchController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container(
              //   padding: EdgeInsets.all(2.0),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.white, // Establece el color de fondo a blanco
                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.grey.withOpacity(0.5), // Color del sombreado
                        spreadRadius: 2, // Radio de propagación
                        blurRadius: 3, // Radio de desenfoque
                        offset: Offset(0, 2), // Desplazamiento en x e y
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      autofocus: true,
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText:
                            'Buscar libros', // Cambia labelText a hintText
                        hintStyle: textTheme.headlineSmall?.copyWith(
                          color: AppColors.gray,
                          fontSize: 18,
                        ),
                        border: InputBorder
                            .none, // Elimina el borde predeterminado del TextField
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: AppColors.gray,
                          ),
                          onPressed: () {
                            String searchTerm = _searchController.text;

                            if (searchTerm.isNotEmpty) {
                              // Llamada a la lógica de búsqueda
                              fetchBooks(searchTerm);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              // contenedor con imagen y título
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Stack(
                    children: [
                      // Imagen con opacidad
                      Opacity(
                        opacity: 0.8,
                        child: Image.asset(
                          'assets/image-1.png',
                          fit: BoxFit.cover,
                          width: 380.0,
                          height: 330.0, // Ajusta la altura según tu necesidad
                        ),
                      ),
                      // Título sobre la imagen en la esquina superior izquierda
                      Positioned(
                        top: 10.0,
                        left: 10.0,
                        child: Text(
                          'Nuevos \nlibros',
                          style: textTheme.titleMedium?.copyWith(
                            color: AppColors.white,
                            fontSize: 36,
                          ),
                        ),
                      ),
                      // Botón en la esquina inferior derecha
                      Positioned(
                        bottom: 10.0,
                        right: 10.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.Newpink,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => bookGrid()),
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Libros',
                                style: textTheme.displayMedium,
                              ),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Añadir un título al CarouselCard
                      Row(
                        children: [
                          Text(
                            'Libros Gratis',
                            style: textTheme.displayMedium,
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              // Navegar a la página con todos los libros
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AllBooksPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Ver Todo',
                              style: textTheme.displayMedium?.copyWith(
                                color: AppColors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),

                      carouselCard(),
                    ],
                  ),
                ),
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(
              //     vertical: 15.0,
              //     horizontal: 8.0,
              //   ),
              //   child: Text(
              //     'Más relevantes',
              //     style: textTheme.titleSmall?.copyWith(
              //       fontWeight: FontWeight.normal,
              //     ),
              //   ),
              // ),
              // Container(
              //   child: bookGrid(),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchBooks(String searchTerm) async {
    try {
      List<Book> fetchedBooks =
          await _bookSearchController.fetchBooks(searchTerm);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultsPage(searchResults: fetchedBooks),
        ),
      );
    } catch (e) {
      print('Error fetching books: $e');
      // manejo de errores
    }
  }
}
