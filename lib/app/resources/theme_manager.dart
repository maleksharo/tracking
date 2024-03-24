import 'package:tracking/app/resources/color_manager.dart';
import 'package:tracking/app/resources/styles_manager.dart';
import 'package:tracking/app/resources/values_manager.dart';
import 'package:flutter/material.dart';

import 'fonts_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: true,

    /// main colors
    primaryColor: ColorManager.blueSwatch,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.lightGrey,
    // colorScheme: const ColorScheme.dark(),
    // brightness: Brightness.dark,
    checkboxTheme: CheckboxThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      checkColor: MaterialStatePropertyAll(ColorManager.blueSwatch[500]),
      fillColor: MaterialStatePropertyAll(ColorManager.offWhite),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    ),

    /// like disabled color color
    splashColor: ColorManager.lightPrimary,

    /// ripple effect color when you press and hold on the button or something else

    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppPadding.p8),
      ),
    ),

    /// app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppSize.s16),
          // left: Radius.circular(AppSize.s16),
        ),
      ),
      color: ColorManager.primary,
      toolbarHeight: AppSize.s75,
      elevation: AppSize.s8,
      shadowColor: ColorManager.lightPrimary,
      titleTextStyle: getRegularStyle(
        fontSize: FontSize.s16,
        color: ColorManager.offWhite,
      ),
    ),

    ///button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.lightGrey,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: getRegularStyle(color: ColorManager.offWhite, fontSize: FontSize.s17),
          backgroundColor: ColorManager.secondary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s8)),
        )),

    /// text theme
    textTheme:
    const TextTheme(
      // /// BOLD FONTS w700 - black color
      // displayLarge: getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s20),
      // displayMedium: getBoldStyle(color: ColorManager.secondary, fontSize: FontSize.s16),
      // displaySmall: getBoldStyle(color: ColorManager.white, fontSize: FontSize.s16),
      // bodySmall: getBoldStyle(color: ColorManager.white, fontSize: FontSize.s14),
      // titleSmall: getBoldStyle(color: ColorManager.darkGrey, fontSize: FontSize.s12),
      // labelSmall: getBoldStyle(color: ColorManager.secondary, fontSize: FontSize.s10),
      //
      // /// SEMI BOLD W-600
      // bodyLarge: getSemiBoldStyle(color: ColorManager.primary, fontSize: FontSize.s20),
      // bodyMedium: getSemiBoldStyle(color: ColorManager.secondary, fontSize: FontSize.s16),
      //
      // /// Medium W-500
      // titleLarge: getMediumStyle(color: ColorManager.primary, fontSize: FontSize.s20),
      // titleMedium: getMediumStyle(color: ColorManager.darkGrey, fontSize: FontSize.s14),
      //
      // /// regular W-400
      // headlineLarge: getRegularStyle(color: ColorManager.primary, fontSize: FontSize.s20),
      // headlineMedium: getRegularStyle(color: ColorManager.secondary, fontSize: FontSize.s16),
      // headlineSmall: getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s16),
      // labelMedium: getRegularStyle(color: ColorManager.darkGrey, fontSize: FontSize.s12),
      //
      // /// light W-300
      // labelLarge: getLightBoldStyle(color: ColorManager.primary, fontSize: FontSize.s24),
    ),

    /// input decoration -> text form field
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p10),

      filled: true,
      hintStyle: getRegularStyle(color: ColorManager.secondary, fontSize: FontSize.s16),
      fillColor: ColorManager.white,
      labelStyle: getMediumStyle(
        color: ColorManager.secondary,
        fontSize: FontSize.s14,
      ),
      errorStyle: getRegularStyle(color: ColorManager.error, fontSize: FontSize.s10),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.white, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.secondary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      /// focus on the border after getting the validation error
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.secondary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
    ),
    scaffoldBackgroundColor: ColorManager.offWhite,
    iconTheme: IconThemeData(color: ColorManager.white),
    iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: MaterialStateProperty.all(ColorManager.white),
        )),
    scrollbarTheme: const ScrollbarThemeData().copyWith(
      thumbColor: MaterialStateProperty.all(ColorManager.lightGrey),
      interactive: true,
    ),
  );
}
