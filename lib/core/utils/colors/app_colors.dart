// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class AppColors {
  static const Color baseColor = Color(0xffF7881F);
  static const Color white = Color(0xffFFFFFF);
  static const Color white2 = Color(0xffFAFAFA);
  static const Color white3 = Color(0xffF3F3F3);

  static const Color tansparent = Color.fromARGB(0, 250, 250, 250);
  static const Color black = Color(0xff353535);
  static const Color black0 = Color.fromARGB(255, 0, 0, 0);

  static const Color red = Color(0xffF73D17);
  static const Color kLightRedColor = Color(0xffFEF1F2);
  static const Color navyBlue = Color(0xff0473C0);
  static const Color green = Color(0xff4CAF50);
  static const Color gray = Color(0xff717171);

  static const Color bgMessage = Color(0xffBEDCF6);

  static const Color border = Color(0xffDFE0DF);

  static const Color pink = Color(0xFFFF4550);
  static Color pink100 = pink.withOpacity(.1);
  static Color pink300 = pink.withOpacity(.3);
  static Color pink400 = pink.withOpacity(.4);

  static const MaterialColor appTheme = MaterialColor(
    0xffF7881F,
    <int, Color>{
      50: Color(0xFFFAECE0),
      100: Color(0xFFFAD9BA),
      200: Color(0xFFF6C08E),
      300: Color(0xFFF1A761),
      400: Color(0xFFEE943F),
      500: Color(0xffF7881F),
      600: Color(0xFFDE7A1C),
      700: Color(0xFFCB6F18),
      800: Color(0xFFB96414),
      900: Color(0xFF9B520C),
    },
  );
}
