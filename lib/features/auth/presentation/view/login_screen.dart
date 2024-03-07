import 'package:auto_route/auto_route.dart';
import 'package:tracking/app/core/refresh_cubit/refresh_cubit.dart';
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
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../auth_cubit/auth_cubit.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with FormStateMixin, TickerProviderStateMixin {
  final authCubit = getIt<AuthCubit>();

  final refreshCubit = getIt<RefreshCubit>();

  // @override
  // void initState() {
  //   super.initState();
    // authCubit.getUserInfo().then((value) {
    //   form.controllers[0].text = value.email;
    //   form.controllers[1].text = value.password;
    // });
  // }

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
                        SizedBox(height: 32.h),
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
                            /// todo: update
                            FormBuilderValidators.minLength(
                              3,
                              errorText: LocaleKeys.passwordMustBeSixChars.tr(),
                              allowEmpty: false,
                            )
                          ]),
                        ),
                        // SizedBox(height: 32.h),
                        // GestureDetector(
                        //   onTap: _onForgetPasswordTapped,
                        //   child: Text(
                        //     LocaleKeys.forgetPassword.tr(),
                        //     style: FontUtils.nexaTextStyle.copyWith(
                        //         fontWeight: FontWeight.w700,
                        //         fontSize: 16,
                        //         color: ColorManager.oilSwatch[13]),
                        //   ),
                        // ),
                        SizedBox(height: 40.h),
                        PrimaryButton(
                          isLoading: state is LoginLoadingState,
                          text: LocaleKeys.login.tr(),
                          onPressed: _onLoginTapped,
                        ),
                        SizedBox(height: 40.h),
                        // Row(
                        //   children: [
                        //     Text(
                        //       LocaleKeys.dontHaveAccountYet.tr(),
                        //       style: FontUtils.nexaTextStyle.copyWith(
                        //         color: ColorManager.blackSwatch[9],
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.w400,
                        //       ),
                        //     ),
                        //     SizedBox(width: 8.w),
                        //     GestureDetector(
                        //       onTap: _onRegisterTapped,
                        //       child: Text(
                        //         LocaleKeys.register.tr(),
                        //         style: FontUtils.nexaTextStyle.copyWith(
                        //             fontWeight: FontWeight.w700,
                        //             fontSize: 16,
                        //             color: ColorManager.oilSwatch[13]),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  );
                },
              ),
              // const Spacer(),
              // const CopyRight(),
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
    if (state is LoginSuccessState) {
      authCubit.setUserInfo(
        token: state.userEntity.token,
        email: form.controllers[0].text,
        password: form.controllers[1].text,
      );
      context.router.replace(const HomeRoute());
    }
  }

  @override
  int numberOfFields() => 2;
}
