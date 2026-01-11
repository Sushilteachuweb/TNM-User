import 'package:flutter/material.dart';

class AppColors {
  // Base Colors

  static const Color background = Color(0xFFF4F6FA);
  static const Color primary = Color(0xFF0056D2);
  static const Color secondary = Color(0xFF7B61FF); // a nice purple
  static const Color accent = Color(0xFFFFC107); // amber

  static const Color buttonText = Colors.white;
  static const Color textFieldFill = Color(0xFFEDE7F6);
  static const Color searchIcon = Color(0xFF9E9E9E);
  static const Color skillChipBackground = Color(0xFFFF9800);
  static const Color skillChipText = Colors.white;

  // Text
  static const Color headingText = Color(0xFF212121);
  static const Color bodyText = Color(0xFF4A4A4A);


  // Input Fields

  static const Color textFieldBorder = Color(0xFFD1C4E9);

  // Icons

  static const Color iconColor = Color(0xFF616161);

  // Chips

  // Buttons
  static const Color buttonPrimary = Color(0xFF0056D2);
  static const Color buttonSecondary = Color(0xFF7B61FF);
  static const Color buttonDisabled = Color(0xFFBDBDBD);

  // Feedback
  static const Color success = Color(0xFF4CAF50); // green
  static const Color warning = Color(0xFFFFC107); // yellow
  static const Color error = Color(0xFFF44336);   // red
  static const Color info = Color(0xFF2196F3);    // blue

  // Borders & Dividers
  static const Color divider = Color(0xFFE0E0E0);
  static const Color border = Color(0xFFBDBDBD);

  // Gradients (used with decoration or ShaderMask)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0056D2), Color(0xFF3F8CFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient purpleGradient = LinearGradient(
    colors: [Color(0xFF7B61FF), Color(0xFFB388FF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}














