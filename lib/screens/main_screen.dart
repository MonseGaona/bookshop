import 'package:flutter/material.dart';

import '../components/genre_screen.dart';
import '../screens/book_list_screen.dart';
import '../components/collection_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../constants/constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Define the pages here
  List<Widget> pages = [
    homeScreen(),
    BookListScreen(),
    genreScreen(),
    CollectionScreen(),
    ProfileScreen(),
  ];

  void onTap(int index) {
    if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    } else {
      setState(() {
        currentIndex = index;
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            color: AppColors.Newpink,
            icon: Icon(
              Icons.menu_rounded,
            ),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          Spacer(),
          IconButton(
            color: AppColors.Newpink,
            icon: Icon(Icons.account_circle),
            onPressed: () {
              onTap(4);
            },
          ),
        ],
        iconTheme: IconThemeData(
          size: 50,
          color: AppColors.Newpink,
        ),
        title: Center(
          child: Text(
            '',
            style: textTheme.titleLarge?.copyWith(
              color: AppColors.black,
            ),
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/image-2.jpg',
                  ), // imagen
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 1.0, top: 1.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.white, // Color del icono
                    onPressed: () {
                      Navigator.of(context)
                          .pop(); // Cierra el Drawer al hacer clic en la flecha
                    },
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Inicio',
                style: textTheme.headlineSmall,
              ),
              leading: Icon(Icons.home),
              onTap: () => onTap(0),
            ),
            ListTile(
              title: Text(
                'Búsqueda',
                style: textTheme.headlineSmall,
              ),
              leading: Icon(Icons.search),
              onTap: () => onTap(1),
            ),
            ListTile(
              title: Text(
                'Géneros',
                style: textTheme.headlineSmall,
              ),
              leading: Icon(Icons.menu_book_sharp),
              onTap: () => onTap(2),
            ),
            ListTile(
              title: Text(
                'Colección',
                style: textTheme.headlineSmall,
              ),
              leading: Icon(Icons.favorite),
              onTap: () => onTap(3),
            ),
          ],
        ),
      ),
      body: pages[currentIndex],
    );
  }
}
