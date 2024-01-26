import 'package:bookshop/components/user_data.dart';
import 'package:bookshop/screens/info_screen.dart';
import 'package:bookshop/screens/login_screen.dart';
import 'package:bookshop/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/collection_provider_screen.dart';
import 'constants/constants.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CollectionProvider()),
        ChangeNotifierProvider(create: (context) => UserData()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 2.0).animate(_controller);

    // Inicia la animación cuando la pantalla se carga
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F1E8),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Parte superior de la pantalla (centrada)
          Expanded(
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: Container(
                width: double.infinity,
                child: Center(
                  child: Image.asset(
                    'assets/background-image.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ),

          // Parte inferior de la pantalla
          FadeTransition(
            opacity: _opacityAnimation,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Text(
                  //   'Hola',
                  //   style: TextStyle(
                  //     fontSize: 24.0,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Redirigir al loginscreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      // shape: RoundedRectangleBorder(
                      //   side: BorderSide(
                      //     color: Colors.black,
                      //     width: 2.0,
                      //   ),
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                    ),
                    child: Text(
                      'Bienvenido',
                      style: textTheme.headlineLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 26.0),
        ],
      ),
    );
  }
}
