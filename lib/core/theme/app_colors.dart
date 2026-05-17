import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds
  static const Color background = Color(0xFFF7F8FA);
  static const Color cardBackground = Colors.white;

  // Gradients
  static const Color gradientStart = Color(0xFF6373F4); // Light purple/blue
  static const Color gradientEnd = Color(0xFF8757B3); // Darker purple

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Text
  static const Color textPrimary = Color(0xFF2D3748);
  static const Color textSecondary = Color(0xFF718096);
  static const Color textHint = Color(0xFFA0AEC0);

  // Borders & Dividers
  static const Color border = Color(0xFFE2E8F0);

  // Icons & Actions
  static const Color iconEdit = Color(0xFF4C7CE5);
  static const Color iconDelete = Color(0xFFE55353);
  static const Color iconLight = Colors.white;
}
