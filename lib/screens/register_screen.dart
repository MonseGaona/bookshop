import 'package:bookshop/screens/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../components/user_data.dart';
import '../constants/constants.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // Validation of name field
  bool isNameValid(String name) {
    return name.isNotEmpty;
  }

  // Validation of password field
  bool isPasswordValid(String password) {
    return password.isNotEmpty && password.length >= 6;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F1E8),
      body: Stack(
        children: [
          Container(
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //     colors: [
              //       Color(0xFF333333),
              //       Color(0xFF4d4d4d),
              //     ],
              //   ),
              // ),
              ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppBar(
                    iconTheme: IconThemeData(
                      color: AppColors.Newpink,
                    ),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                  ),
                  // Logo centrado arriba
                  Image.asset(
                    'assets/GifBooks.gif',
                    height: 200,
                    width: 200,
                  ),
                  Text(
                    "Crea una cuenta",
                    style: textTheme.headlineMedium?.copyWith(
                      fontSize: 35,
                    ),
                  ),
                  // Campos de texto
                  TextField(
                    controller: _nameController,
                    style: textTheme.displayMedium,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      labelStyle: TextStyle(
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: textTheme.displayMedium,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      labelStyle: TextStyle(
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 26),
                  // Botón "Continuar"
                  Container(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        // Name validation
                        if (!isNameValid(_nameController.text)) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Nombre Inválido',
                                  style: textTheme.displayMedium,
                                ),
                                content: Text(
                                  'Por favor ingrese un nombre.',
                                  style: textTheme.displayMedium,
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'cerrar',
                                      style: TextStyle(
                                        color: AppColors.lightPink,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        // Password validation
                        else if (!isPasswordValid(_passwordController.text)) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Contraseña Inválida',
                                  style: textTheme.displayMedium,
                                ),
                                content: Text(
                                  'La contraseña debe tener al menos 6 caracteres.',
                                  style: textTheme.displayMedium,
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'cerrar',
                                      style: textTheme.displayMedium?.copyWith(
                                        color: AppColors.lightPink,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          // If both fields are valid, navigate to InfoScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                // Get the UserData object
                                final userData = Provider.of<UserData>(context,
                                    listen: false);

                                // Save the name in UserData
                                userData.setName(_nameController.text);

                                // Navigate to InfoScreen
                                return InfoScreen();
                              },
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        backgroundColor: AppColors.Newpink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        'Continuar',
                        style: textTheme.displayMedium?.copyWith(
                          letterSpacing: 1.9,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 190),
                  // Botón "Términos y Condiciones" al pie de la pantalla
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.transparent,
                    ),
                    onPressed: () {},
                    child: Text(
                      'Términos y Condiciones',
                      style: textTheme.displayMedium?.copyWith(
                        letterSpacing: 1.5,
                        color: AppColors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class ImageClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.lineTo(0, size.height);
//     path.quadraticBezierTo(
//         size.width / 4, size.height - 40, size.width / 2, size.height);
//     path.quadraticBezierTo(
//         3 * size.width / 4, size.height - 40, size.width, size.height);
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }
