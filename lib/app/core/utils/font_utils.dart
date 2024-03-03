
import 'package:tracking/app/resources/color_manager.dart';
import 'package:flutter/material.dart';

abstract class FontUtils {
  static TextStyle get nexaTextStyle => TextStyle(
        fontFamily: 'Nexa',
        color: ColorManager.blackSwatch[10]!,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
        fontSize: 16,
      );

  static TextStyle get bebasTextStyle => TextStyle(
        fontFamily: 'BebasNeue',
        color: ColorManager.blackSwatch[10]!,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
        fontSize: 16,
      );

  static TextStyle get montserratTextStyleWhite => TextStyle(
        fontFamily: 'Montserrat',
        color: ColorManager.blackSwatch[10]!,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
        fontSize: 16,
      );
}
