import 'package:flutter/material.dart';

class AppColors {
  static const Color sigeIeYellow = Color(0xFFF1F60E);
  static const Color sigeIeBlue = Color(0xff123c75);
  static const Color dartText = Color.fromRGBO(22, 22, 22, 1);
  static const Color lightText = Color.fromARGB(255, 238, 233, 233);
  static const Color warn = Color.fromARGB(255, 231, 27, 27);
  static const Color accent = Color.fromARGB(255, 231, 85, 27);
}

class AppButtonStyles {
  static ButtonStyle warnButton = ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 231, 27, 27),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
  static ButtonStyle accentButton = ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 231, 160, 27),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
  static ButtonStyle standardButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.sigeIeYellow,
    foregroundColor: AppColors.sigeIeBlue,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
