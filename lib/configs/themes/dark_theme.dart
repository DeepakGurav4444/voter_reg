import 'package:flutter/material.dart';
import 'themes.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(
          color: Colors.white,
        )),
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
    // textTheme: ThemeData.dark().textTheme.copyWith(
    //       titleMedium: GoogleFonts.roboto(color: Colors.white),
    //       titleSmall: GoogleFonts.roboto(
    //         color: Colors.white.withOpacity(.5),
    //       ),
    //       displayLarge: GoogleFonts.roboto(
    //         color: Colors.white,
    //       ),
    //       displayMedium: GoogleFonts.roboto(
    //         color: Colors.white,
    //         fontWeight: FontWeight.w400,
    //       ),
    //       headlineMedium: GoogleFonts.roboto(
    //         color: ThemeConfig.textColor6B698E,
    //       ),
    //       displaySmall: GoogleFonts.roboto(
    //         color: Colors.white,
    //         fontWeight: FontWeight.w400,
    //       ),
    //       bodyMedium: GoogleFonts.roboto(
    //         color: ThemeConfig.textColorBCBFC2,
    //       ),
    //     ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateColor.resolveWith((states) => Colors.white.withValues()),
    ),
    colorScheme: const ColorScheme.dark().copyWith(
        secondary: const Color(0xff73777a),
        primary: Colors.white,
        onPrimary: const Color(0xffA0A0A0),
        outline: Colors.black,
        onSurface: const Color(0xff202934),
        brightness: Brightness.dark,
        surface: const Color(0xff202934),
        primaryContainer: const Color(0xff2d3236),
        onPrimaryContainer: const Color(0xff5a5f62)),
    progressIndicatorTheme: const ProgressIndicatorThemeData(linearTrackColor: Colors.white, color: ThemeConfig.primaryColor),
    primaryColor: ThemeConfig.primaryColor,
    scaffoldBackgroundColor: ThemeConfig.darkBackColor);
