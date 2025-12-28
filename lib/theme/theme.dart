import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class BahamaTheme {
  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.poppinsTextTheme();
    
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: BahamaColors.islandBlue,
      scaffoldBackgroundColor: BahamaColors.whiteSand,
      
      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: BahamaColors.islandBlue,
        secondary: BahamaColors.warmGold,
        surface: BahamaColors.whiteSand,
        onPrimary: BahamaColors.whiteSand,
        onSecondary: BahamaColors.deepTeal,
        onSurface: BahamaColors.deepTeal,
      ),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: const IconThemeData(color: BahamaColors.deepTeal),
        titleTextStyle: GoogleFonts.poppins(
          color: BahamaColors.deepTeal,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: baseTextTheme.displayLarge?.copyWith(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: BahamaColors.deepTeal,
        ),
        displayMedium: baseTextTheme.displayMedium?.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: BahamaColors.deepTeal,
        ),
        displaySmall: baseTextTheme.displaySmall?.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: BahamaColors.deepTeal,
        ),
        headlineMedium: baseTextTheme.headlineMedium?.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: BahamaColors.deepTeal,
        ),
        headlineSmall: baseTextTheme.headlineSmall?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: BahamaColors.deepTeal,
        ),
        titleLarge: baseTextTheme.titleLarge?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: BahamaColors.deepTeal,
        ),
        titleMedium: baseTextTheme.titleMedium?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: BahamaColors.deepTeal,
        ),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: BahamaColors.deepTeal,
        ),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: BahamaColors.greyPrimary,
        ),
        bodySmall: baseTextTheme.bodySmall?.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: BahamaColors.greyPrimary,
        ),
        labelLarge: baseTextTheme.labelLarge?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: BahamaColors.deepTeal,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: BahamaColors.offWhiteMist,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: BahamaColors.islandBlue, width: 2),
        ),
        hintStyle: const TextStyle(
          color: BahamaColors.greyPrimary,
          fontFamily: 'Poppins',
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          shadowColor: BahamaColors.warmGold.withOpacity(0.3),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: 4,
        shadowColor: BahamaColors.deepTeal.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: BahamaColors.whiteSand,
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: BahamaColors.whiteSand,
        selectedItemColor: BahamaColors.islandBlue,
        unselectedItemColor: BahamaColors.greyPrimary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Tab Bar Theme
      tabBarTheme: const TabBarThemeData(
        labelColor: BahamaColors.islandBlue,
        unselectedLabelColor: BahamaColors.greyPrimary,
        indicatorColor: BahamaColors.islandBlue,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: BahamaColors.islandBlue,
        size: 24,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: BahamaColors.greyLight,
        thickness: 1,
      ),

      fontFamily: GoogleFonts.poppins().fontFamily,
    );
  }
}

