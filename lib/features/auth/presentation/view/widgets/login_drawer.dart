import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking/app/core/widgets/custom_text_field.dart';
import 'package:tracking/app/resources/assets_manager.dart';

import '../../../../../app/app_prefs.dart';
import '../../../../../app/core/widgets/primary_button.dart';
import '../../../../../app/di/injection.dart';
import '../../../../../app/resources/strings_manager.g.dart';

class LoginDrawer extends StatefulWidget {
  const LoginDrawer({super.key, required this.servers, required this.onApplyPressed});
  final List<String> servers;
  final Function() onApplyPressed;
  @override
  State<LoginDrawer> createState() => _LoginDrawerState();
}

class _LoginDrawerState extends State<LoginDrawer> {
  TextEditingController serverController = TextEditingController(text: "");

  final AppPreferences appPreferences = getIt<AppPreferences>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (appPreferences.getString(prefsKey: prefsBaseUrl).isEmpty) {
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
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Drawer(
        width: 300.w,
        backgroundColor: Colors.transparent,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                100.verticalSpace,
                Image.asset(ImageManager.appLogo),
                20.verticalSpace,
                Form(
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
                              Fluttertoast.showToast(msg: LocaleKeys.serverSelectedSuccessfully.tr()).then(
                                (value) async => await appPreferences
                                    .setString(prefsKey: prefsBaseUrl, value: serverController.text)
                                    .then(
                                  (value) async {
                                    await configureInjection(Environment.prod);
                                    widget.onApplyPressed();
                                  },
                                ),
                              );
                              // widget.onApplyPressed();
                            }
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
