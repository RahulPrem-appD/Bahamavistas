import 'package:flutter/material.dart';

/// BahamaVista Color Palette
/// Luxury-island, modern-minimalist aesthetic inspired by the Bahamas
class BahamaColors {
  // Primary Gradient - Bahama Sea (Sky-to-Sea wash)
  static const Color lightAqua = Color(0xFFDFF7F7);
  static const Color softSeafoam = Color(0xFFCFEFF0);
  static const Color paleTurquoise = Color(0xFFB7E4E6);

  // Primary Gradient as LinearGradient
  static const LinearGradient seaGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [lightAqua, softSeafoam, paleTurquoise],
  );

  // Island Blue - Primary Accent
  static const Color islandBlueLight = Color(0xFF6BBFC9);
  static const Color islandBlue = Color(0xFF4FAEB8);
  static const Color islandBlueDark = Color(0xFF3A98A6);

  // Sunlit Coral Yellow - CTA Buttons
  static const Color warmGold = Color(0xFFF6C15C);
  static const Color softCoralYellow = Color(0xFFF8D68C);
  static const Color ctaGradientTop = Color(0xFFF7C96B);
  static const Color ctaGradientBottom = Color(0xFFF5B953);

  static const LinearGradient ctaGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [ctaGradientTop, ctaGradientBottom],
  );

  // Sand Whites & Warm Neutrals
  static const Color whiteSand = Color(0xFFFFFFFF);
  static const Color warmShell = Color(0xFFF9F9F7);
  static const Color offWhiteMist = Color(0xFFF2F7F7);

  // Deep Ocean Teal - Text Emphasis & Icons
  static const Color deepTeal = Color(0xFF2E6F75);
  static const Color deepTealDark = Color(0xFF1F5B61);

  // Grey for Secondary Text
  static const Color greyPrimary = Color(0xFFA2A9AF);
  static const Color greySecondary = Color(0xFFC8CED3);
  static const Color greyLight = Color(0xFFE5E8EA);
}

