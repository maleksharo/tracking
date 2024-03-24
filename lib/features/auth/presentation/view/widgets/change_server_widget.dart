import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

import '../../../../../app/app_prefs.dart';
import '../../../../../app/di/injection.dart';
import '../../../../../app/resources/color_manager.dart';

class ServersDropDownWidget extends StatelessWidget {
  ServersDropDownWidget({super.key, required this.serversList, required this.isLogout});

  final List<String> serversList;
  final bool isLogout;
  final AppPreferences appPreferences = getIt<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      key: GlobalKey(),
      child: DropdownButton2(
        style: TextStyle(color: ColorManager.darkGrey),
        isExpanded: true,
        dropdownStyleData: DropdownStyleData(
          maxHeight: 250,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
          ),
          offset: const Offset(20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        buttonStyleData: ButtonStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: ColorManager.blackSwatch[5]!,
            ),
            color: ColorManager.white,
          ),
        ),
        hint: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Text(
            appPreferences.getString(prefsKey: prefsBaseUrl).isEmpty
                ? 'Select server'
                : appPreferences.getString(prefsKey: prefsBaseUrl),
          ),
        ),
        items: serversList.map<DropdownMenuItem<String>>((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Text(
                item,
                style: TextStyle(color: ColorManager.darkGrey),
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) async {
          await appPreferences.setString(prefsKey: prefsBaseUrl, value: "$newValue.").then(
                (value) async{
                  if(isLogout) await appPreferences.logout();
                  return Restart.restartApp();
                },
              );
        },
      ),
    );
  }
}
