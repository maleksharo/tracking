import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:restart_app/restart_app.dart';
import 'package:tracking/app/app_prefs.dart';
import 'package:tracking/app/core/refresh_cubit/refresh_cubit.dart';
import 'package:tracking/app/core/utils/font_utils.dart';
import 'package:tracking/app/core/widgets/alert_dialog.dart';
import 'package:tracking/app/core/widgets/custom_text_field.dart';
import 'package:tracking/app/core/widgets/primary_button.dart';
import 'package:tracking/app/di/injection.dart';
import 'package:tracking/app/resources/assets_manager.dart';
import 'package:tracking/app/resources/color_manager.dart';
import 'package:tracking/app/resources/strings_manager.g.dart';
import 'package:tracking/app/routes/router.gr.dart';
import 'package:tracking/app/ui/form_state_mixin.dart';
import 'package:tracking/app/ui/form_utils.dart';

import '../../../../app/core/widgets/copyright.dart';
import '../auth_cubit/auth_cubit.dart';
import 'forgot_password_dialog.dart';
@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with FormStateMixin, TickerProviderStateMixin {
  final authCubit = getIt<AuthCubit>();
  final AppPreferences appPreferences = getIt<AppPreferences>();
  final refreshCubit = getIt<RefreshCubit>();
  List<String> servers = [];

  @override
  void initState() {
    super.initState();
    // authCubit.getUserInfo().then((value) {
    //   form.controllers[0].text = value.email;
    //   form.controllers[1].text = value.password;
    // });
    if (appPreferences
        .getString(prefsKey: prefsBaseUrl)
        .isEmpty) {
      authCubit.getServers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: ImageManager.splashLogo,
                child: Image.asset(ImageManager.appLogo),
              ),
              BlocConsumer<AuthCubit, LoginState>(
                bloc: authCubit,
                listener: _onLoginStateChanged,
                builder: (context, state) {
                  return Form(
                    key: form.key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        serverDropDownWidget(serversList: servers),

                        SizedBox(height: 12.h),
                        CustomTextField(
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          controller: form.controllers[0],
                          labelText: LocaleKeys.emailAddress.tr(),
                          hint: LocaleKeys.yourEmail.tr(),
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: LocaleKeys.invalidEmailAddress.tr(),
                            ),
                            FormBuilderValidators.email(
                              errorText: LocaleKeys.invalidEmailAddress.tr(),
                            ),
                          ]),
                        ),
                        SizedBox(height: 24.h),
                        CustomTextField(
                          controller: form.controllers[1],
                          labelText: LocaleKeys.password.tr(),
                          hint: LocaleKeys.password.tr(),
                          isFieldObscure: true,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.done,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.minLength(
                              8,
                              errorText: LocaleKeys.passwordMustBe8Chars.tr(),
                              allowEmpty: false,
                            )
                          ]),
                        ),
                        SizedBox(height: 4.h),
                        GestureDetector(
                          onTap: () {
                            forgotPasswordDialog(context: context);
                          },
                          child: Text(
                            LocaleKeys.forgetPassword.tr(),
                            style: FontUtils.nexaTextStyle
                                .copyWith(fontWeight: FontWeight.w700, fontSize: 16, color: ColorManager.greenSwatch),
                          ),
                        ),
                        SizedBox(height: 40.h),
                        PrimaryButton(
                          isLoading: state is LoginLoadingState,
                          backgroundColor: appPreferences
                              .getString(prefsKey: prefsBaseUrl)
                              .isEmpty ? ColorManager.grey: null,
                          text: LocaleKeys.login.tr(),
                          onPressed: appPreferences
                              .getString(prefsKey: prefsBaseUrl)
                              .isEmpty ? null:_onLoginTapped ,
                        ),
                        SizedBox(height: 12.h),
                      ],
                    ),
                  );
                },
              ),
              const Spacer(),
              const CopyRight(),
            ],
          ),
        ),
      ),
    );
  }

  void _onLoginTapped() {
    form.validate(() {
      authCubit.login(
        login: form.controllers[0].text,
        password: form.controllers[1].text,
      );
    });
  }

  void _onLoginStateChanged(
    BuildContext context,
    LoginState state,
  ) {
    if (state is LoginFailState) {
      alertDialog(
        context: context,
        image: SvgManager.infoWarning,
        message: state.message,
        approveButtonTitle: LocaleKeys.retry,
        onConfirm: _onLoginTapped,
      );
    }
    if (state is GetServersFailState) {
      alertDialog(
        context: context,
        image: SvgManager.infoWarning,
        message: state.message,
        approveButtonTitle: LocaleKeys.retry,
        onConfirm: () {},
      );
    }
    if (state is LoginSuccessState) {
      authCubit.setUserInfo(
        token: state.userEntity.token,
        email: form.controllers[0].text,
        password: form.controllers[1].text,
      );
      context.router.replace(const HomeRoute());
    }
    if (state is GetServersSuccessState) {
      servers.addAll(state.servers);
    }
  }

  Widget serverDropDownWidget({required List<String> serversList}) {
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
            appPreferences
                .getString(prefsKey: prefsBaseUrl)
                .isEmpty
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
                (value) => Restart.restartApp(),
          );
        },
      ),
    );
  }

  @override
  int numberOfFields() => 2;
}
