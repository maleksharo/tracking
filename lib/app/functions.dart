import 'dart:io';
import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:tracking/app/resources/strings_manager.g.dart';

/// This function is for converting the url image to a file.
Future<File> convertImageUrlToFile(String? imageUrl) async {
  dynamic rng = Random();
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  File file = File('$tempPath${rng.nextInt(100)}.png');
  http.Response response = await http.get(Uri.parse(imageUrl.toString()));
  await file.writeAsBytes(response.bodyBytes);
  return file;
}

/// This function is for converting the path image to a file.

Future<File> convertImagePathToFile(String path) async {
  final byteData = await rootBundle.load(path);

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.create(recursive: true);
  await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

String convertFrom12To24HourTypes({required String currentTime}) {
  if (currentTime.isNotEmpty) {
    List<String> parts = currentTime.split(" ");
    List<String> time = parts[0].split(":");
    String hourStr = time[0];
    String minuteStr = time[1];
    String amPm = parts[1];

    int hour = int.parse(hourStr);

    if (amPm == "AM" && hour == 12) {
      hour = 0;
    } else if (amPm == "PM" && hour != 12) {
      hour += 12;
    }

    hourStr = hour.toString().padLeft(2, '0');
    minuteStr = minuteStr.padLeft(2, '0');

    String time24hr = "$hourStr:$minuteStr";

    return time24hr;
  } else {
    return "";
  }
}

String? compareDateValidator({required String startDateTime, required String endDateTime}) {

  DateTime startDate = DateTime.parse(startDateTime);
  DateTime endDate = DateTime.parse(endDateTime);

  if (endDate.isBefore(startDate)) {
    return LocaleKeys.endDateValidator.tr();
  }

  return null;
}
String convertDoubleToTime({required String decimalHours}) {
  int hours = double.parse(decimalHours).floor();
  int minutes = ((double.parse(decimalHours) - hours) * 60).round();
  String result = "";
  if(hours != 0){
    result = "$hours hour";
  }
  result += " ${minutes.toString().padLeft(2, '0')} minute";
  return result;
}