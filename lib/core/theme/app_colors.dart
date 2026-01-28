import 'package:flutter/material.dart';

import 'dart:ui';

class AppColors {
  static const Color background = Color(0xFF17171C);
  static const Color buttonGradStart = Color(0xFF8924E7);
  static const Color buttonGradEnd = Color(0xFF6A46F9);
  static const Color inputBackground = Color(0xFF131313);
  static const Color inputBorder = Color(0xFF87858F);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textGrey = Color(0xFF8E8E93);
}

class AppTextStyles {
  static const TextStyle title = TextStyle(
    color: AppColors.textWhite,
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle label = TextStyle(
    color: AppColors.textGrey,
    fontSize: 12,
  );

  static const TextStyle inputText = TextStyle(
    color: AppColors.textWhite,
    fontSize: 16,
  );
}