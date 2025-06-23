import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  //  Thin (100)
  //  Light (300)
  //  Regular (400)
  //  Medium (500)
  //  SemiBold (600)
  //  Bold (700)
  //  ExtraBold (800)
  //  Black (900)

  static TextStyle poppinStyle(
      {FontWeight weight = FontWeight.w400,
      Color color = Colors.black,
      double fontSize = 14.0}) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: weight,
      color: color,
    );
  }

  static TextStyle robotoStyle(
      {FontWeight weight = FontWeight.w400,
      Color color = Colors.black,
      double fontSize = 14.0}) {
    return GoogleFonts.roboto(
      fontSize: fontSize,
      fontWeight: weight,
      color: color,
    );
  }
}
