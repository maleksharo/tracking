import 'package:tracking/app/resources/color_manager.dart';
import 'package:tracking/app/resources/strings_manager.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

DateTime selectedDate = DateTime.now();

Future<DateTime?> selectDate(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    locale: const Locale('en', 'US'),
    firstDate: DateTime(1950),
    lastDate: DateTime.now().add(const Duration(days: 365)),
    confirmText: LocaleKeys.ok.tr(),
    cancelText: LocaleKeys.cancel.tr(),
    helpText: LocaleKeys.selectDate.tr(),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData(
          primaryColor: ColorManager.greenSwatch,
          buttonBarTheme: const ButtonBarThemeData(
            buttonTextTheme: ButtonTextTheme.primary,
          ),
          colorScheme: ColorScheme.light(
            primary: ColorManager.greenSwatch,
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child!,
      );
    },
  );

  return pickedDate;
}
