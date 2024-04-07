import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tracking/app/resources/color_manager.dart';
import 'package:tracking/app/resources/strings_manager.g.dart';

DateTime selectedDate = DateTime.now();
TimeOfDay selectedTime = TimeOfDay.now();

Future<DateTime?> selectDate({required BuildContext context, required int hours, required int min}) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    locale: const Locale('en', 'US'),
    firstDate: DateTime(DateTime.now().year - 1),
    lastDate: DateTime.now(),
    confirmText: LocaleKeys.ok.tr(),
    cancelText: LocaleKeys.cancel.tr(),
    helpText: LocaleKeys.selectDate.tr(),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData(
          primaryColor: ColorManager.blueSwatch,
          buttonBarTheme: const ButtonBarThemeData(
            buttonTextTheme: ButtonTextTheme.primary,
          ),
          colorScheme: ColorScheme.light(
            primary: ColorManager.blueSwatch,
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child!,
      );
    },
  );

  if (pickedDate != null) {
    selectedDate = pickedDate;
    await selectTime(context, hours: hours,min: min);
  }

  return pickedDate;
}

Future<TimeOfDay?> selectTime(BuildContext context, {required int hours, required int min}) async {
  TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: hours, minute: min),
  );

  if (pickedTime != null) {
    selectedTime = pickedTime;
  }

  return pickedTime;
}

DateTime combineDateAndTime(DateTime date, TimeOfDay time) {
  return DateTime(date.year, date.month, date.day, time.hour, time.minute);
}