import 'package:tracking/app/resources/fonts_manager.dart';
import 'package:flutter/cupertino.dart';

TextStyle _getTextStyle(
  double fontSize,
  FontWeight fontWeight,
  Color color,
) {
  return TextStyle(
    color: color,
    fontWeight: fontWeight,
    fontSize: fontSize,
    fontFamily: FontManager.fontFamily,
  );
}

// regular style
TextStyle getRegularStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.regular,
    color,
  );
}

// medium style
TextStyle getMediumStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.medium,
    color,
  );
}

// light style
TextStyle getLightStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.light,
    color,
  );
}

// bold style
TextStyle getBoldStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.bold,
    color,
  );
}

// semi-bold style
TextStyle getSemiBoldStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.semiBold,
    color,
  );
}

// 300-bold style
TextStyle getLightBoldStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.light,
    color,
  );
}
