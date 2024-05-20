import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking/app/core/widgets/custom_text_field.dart';

import '../../../../../app/app_prefs.dart';
import '../../../../../app/core/widgets/primary_button.dart';
import '../../../../../app/di/injection.dart';
import '../../../../../app/resources/strings_manager.g.dart';

class ServersDropDownWidget extends StatefulWidget {
  const ServersDropDownWidget({super.key, required this.serversList, required this.isLogout});

  final List<String> serversList;
  final bool isLogout;

  @override
  State<ServersDropDownWidget> createState() => _ServersDropDownWidgetState();
}

class _ServersDropDownWidgetState extends State<ServersDropDownWidget> {
  TextEditingController serverController = TextEditingController(text: "");

  final AppPreferences appPreferences = getIt<AppPreferences>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if(appPreferences.getString(prefsKey: prefsBaseUrl).isEmpty) {
      serverController = TextEditingController(
      text: "https://${appPreferences.getString(prefsKey: prefsBaseUrl)}",
    );
    } else {
      serverController = TextEditingController(
        text: appPreferences.getString(prefsKey: prefsBaseUrl),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: serverController,
            hint: LocaleKeys.enterYourServer.tr(),
            isFieldObscure: false,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.done,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                errorText: LocaleKeys.fieldRequired.tr(),
              ),
            ]),
          ),
          SizedBox(height: 40.h),
          PrimaryButton(
              text: LocaleKeys.apply.tr(),
              onPressed: () async {
                if (formKey.currentState?.validate() ?? true) {
                  // if (widget.serversList.contains(serverController.text.toLowerCase())) {
                    Fluttertoast.showToast(msg: LocaleKeys.serverSelectedSuccessfully.tr()).then(
                      (value) async => await appPreferences.setString(prefsKey: prefsBaseUrl, value: serverController.text).then(
                        (value) async {
                        if (widget.isLogout) await appPreferences.logout();
                        await configureInjection(Environment.prod);
                      },
                      ),
                    );
                  // } else {
                  //   Fluttertoast.showToast(msg: LocaleKeys.serverIsWrong.tr());
                  // }
                }
              }),
        ],
      ),
    );
  }
}

extension AddBaseUrl on String {
  String addBaseUrl() {
    AppPreferences appPreferences = AppPreferences();

    return appPreferences.getString(prefsKey: prefsBaseUrl) + this;
  }
}