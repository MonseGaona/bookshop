import 'package:bookshop/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:bookshop/screens/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  PageController _pageController = PageController(initialPage: 0);

  List<Map<String, dynamic>> pages = [
    {
      'image': 'assets/image-5.jpg',
      'text':
          'Library Moon te permite buscar, descubrir y acceder a una gran variedad de géneros, autores y temas literarios, todo con solo unos toques en tu pantalla.',
    },
    // <a href="https://www.freepik.com/free-ai-image/antique-book-collection-old-bookshelf-generated-by-ai_48639768.htm#fromView=search&term=bibliotek&page=1&position=36&track=ais_ai_generated&regularType=ai">Image By vecstock</a>
    {
      'image': 'assets/image-3.jpg',
      'text':
          'Puedes crear una lista para llevar un registro de los libros que deseas leer en el futuro.',
    },
    // <a href="https://www.freepik.com/free-ai-image/view-heart-shape-made-from-book-pages_69857466.htm#fromView=search&term=books+background&page=3&position=3&track=ais_ai_generated&regularType=ai">Image By freepik</a>
    // {
    //   'image': 'assets/image-3.jpg',
    //   'text':
    //       'Busca, descubre y accede a una gran variedad de géneros, autores y temas literarios, todo con solo unos toques en tu pantalla.',
    // },
  ];

  int currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void goToMainScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: pages.length,
        onPageChanged: (page) {
          setState(() {
            currentPage = page;
          });
        },
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: index == currentPage ? 0.7 : 1.0,
                  child: Image.asset(
                    pages[index]['image'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        pages[index]['text'],
                        style: textTheme.displayMedium?.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkPink,
                      ),
                      onPressed: () {
                        if (currentPage == pages.length - 1) {
                          goToMainScreen();
                        } else {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        }
                      },
                      child: Text(
                        currentPage == pages.length - 1
                            ? 'Continuar'
                            : 'Siguiente',
                        style: textTheme.displayMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
