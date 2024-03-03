import 'package:flutter/material.dart';

class ColorManager {

  static Color primary = const Color(0xFF03314B);
  static Color secondary = const Color(0xFF00ACB6);
  static Color grey = const Color(0xFF999999);
  static Color seatGrey = const Color(0xFFEDEDED);
  static Color offWhite = const Color(0xFFF5F6FE);
  static Color offWhite2 = const Color(0xFFF5F5F5);
  static Color white = const Color(0xFFFFFFFF);
  static Color yellow = const Color(0xFFFED049);
  static Color red = const Color(0xFFFF4141);
  static Color darkGrey = const Color(0xff333333);
  static Color lightGrey = const Color(0xFF999999);
  static Color lightGreyCalendar = const Color(0xFFCACACA);
  static Color lightGreyCalendar2 = const Color(0xFFEDEFFF);
  static Color lightPrimary = const Color(0xff446C83);
  static Color paymentMethodGrey = const Color(0xffF9FBFC);

  static Color darkPrimary = const Color(0xFF1a3457);
  static Color lightPink = const Color(0xFFA8B2FF);
  static Color purple = const Color(0xFF6576FF);
  static Color black = const Color(0xff222222);
  static Color error = const Color(0xffff3333);
  static const primaryBlack = Color(0xFF252723);
  static const blue = Color(0xFF066CC9);
  static const primaryGreen = Color(0xFF8CC640);
  static const primaryOil = Color(0xFF046937);
  static const _blackSwatch = {
    2: Color(0xFFFDFDFD),
    5: Color(0xFFDEDFDE),
    6: Color(0xFFC9C9C8),
    7: Color(0xFF9D9E9C),
    8: Color(0xFF727371),
    9: Color(0xFF61615F),
    10: Color(0xFF474745),
    11: Color(0xFF40413E),
    12: Color(0xFF373836),
    13: Color(0xFF262724),
  };

  static const _greenSwatch = {
    300: Color(0xFFB2D97F),
    400: Color(0xFFA3D166),
    500: Color(0xFF8CC640),
    600: Color(0xFF7FB43A),
    700: Color(0xFF638D2D),
  };

  static const _oilSwatch = {
    /// This is the equivalent of n3
    3: Color(0xFFF5F9F7),
    /// This is the equivalent of n7
    7: Color(0xFF8EBCA5),
    /// This is the equivalent of n13
    13: Color(0xFF046937),
  };

  /// The primary color can be used instead of the black primary color
  static final blackSwatch = ColorSwatch(primaryBlack.value, _blackSwatch);
  /// The primary color can be used instead of the green primary color
  static final greenSwatch = ColorSwatch(primaryGreen.value, _greenSwatch);
  /// The primary color can be used instead of the oil primary color
  static final oilSwatch = ColorSwatch(primaryOil.value, _oilSwatch);
}
