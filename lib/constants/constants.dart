import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme textTheme = TextTheme(
  // Titulos
  titleLarge: GoogleFonts.cinzelDecorative(
    fontSize: 25,
    // color: Colors.black,
    // fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  ),
  titleMedium: GoogleFonts.spectralSc(
    fontSize: 20,
    color: Colors.black,
    decoration: TextDecoration.none,
  ),
  titleSmall: GoogleFonts.oxygen(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  ),
  displayLarge: GoogleFonts.spectral(
    // Titulo de los libro
    fontSize: 19,
    fontWeight: FontWeight.normal,
  ),
  displayMedium: GoogleFonts.sen(
    // Autores de los libros
    fontSize: 22,
    fontWeight: FontWeight.normal,
  ),
  displaySmall: GoogleFonts.aBeeZee(
    // Categorias de los libros
    fontWeight: FontWeight.w100,
    fontSize: 16,
  ),
  headlineLarge: GoogleFonts.beVietnamPro(
    color: AppColors.black,
    letterSpacing: 3.9,
    fontSize: 24,
  ),
  headlineMedium: GoogleFonts.lustria(
    //  Titulo de los libros relevantes
    fontSize: 17,
    color: Colors.black,
  ),
  headlineSmall: GoogleFonts.poppins(
    fontWeight: FontWeight.normal,
    fontSize: 16,
  ),
  bodyLarge: GoogleFonts.montserrat(
    // Descripcion de los libros
    fontSize: 18,
  ),
  labelLarge: GoogleFonts.inter(
    fontSize: 18,
  ),
);

class AppColors {
  static Color darkGreen = const Color(0xFF00467F);
  static Color lightGreeen = const Color(0xFFA5CC82);
  static Color darkPink = const Color(0xFFD66D75);
  static Color lightPink = const Color(0xFFE29587);
  static Color Newpink = const Color(0xFFe8c7c7);
  static Color backgroundLight = const Color(0xFFF8F1E8);
  static Color white = const Color(0xFFfafafa);
  static Color gray = Color(0xFF696464);
  static Color darkBlue = const Color(0xFF34495E);
  static Color BlueDark = const Color(0xFF84a7bd);
  static Color black = Colors.black87;
}

// class TitleLargeWithGradient extends StatelessWidget {
//   final String text;

//   TitleLargeWithGradient(this.text);

//   @override
//   Widget build(BuildContext context) {
//     return ShaderMask(
//       shaderCallback: (Rect bounds) {
//         return LinearGradient(
//           colors: [
//             AppColors.gray,
//             AppColors.Newpink,
//             AppColors.gray,
//             AppColors.Newpink,
//           ],
//           stops: [0.0, 0.3, 0.6, 1.0],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ).createShader(bounds);
//       },
//       child: Text(
//         text,
//         style: textTheme.titleLarge,
//       ),
//     );
//   }
// }
