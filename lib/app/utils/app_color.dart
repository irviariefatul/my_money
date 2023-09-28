import 'package:flutter/material.dart';

class AppColor {
  static LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, Color(0xFF3E8255)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static Color primaryColor = Color(0xFF3E8255);
  static Color primarySoft = Color(0xff004AAD);
  static Color primaryExtraSoft = Color.fromARGB(255, 129, 144, 177);
  static Color secondary = Color(0xFFFF7E7E);
  static Color secondarySoft = Color(0xFF9D9D9D);
  static Color secondaryExtraSoft = Color(0xFFE9E9E9);
  static Color warning = Color(0xFFFACC76);
  static Color dark = Color(0xFF737373);
  static Color lightgrey = Color(0xFFD9D9D9);
  static Color red = Color(0xFFFF5A5A); // Expense
  static Color blue = Color(0xFF779DCF);
  static Color green = Color(0xFF28DB85); // Income

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF779DCF);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF28DB85); // Income
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFFF5A5A); // Expense
  static const Color contentColorCyan = Color(0xFF50E4FF);
}
