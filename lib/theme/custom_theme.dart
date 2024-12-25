import 'package:afrotieapp/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static const backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFF9F7F7), AppTheme.customColor],
  );

  static const appBarGradient = LinearGradient(
    colors: [AppTheme.customColor, Color(0xFF112D4E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const fieldFillColor = Color(0xFFDBE2EF);

  static InputDecoration fieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: fieldFillColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    );
  }
}
