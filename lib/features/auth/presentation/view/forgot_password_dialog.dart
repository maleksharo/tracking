import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:tracking/app/core/widgets/custom_text_field.dart';
import 'package:tracking/app/di/injection.dart';
import 'package:tracking/app/resources/strings_manager.g.dart';
import 'package:tracking/app/resources/values_manager.dart';
import 'package:tracking/features/auth/presentation/auth_cubit/auth_cubit.dart';

import '../../../../app/core/widgets/alert_dialog.dart';
import '../../../../app/core/widgets/primary_button.dart';
import '../../../../app/resources/assets_manager.dart';

Future<void> forgotPasswordDialog({
  required BuildContext context,
}) {
  TextEditingController emailController = TextEditingController();
  final AuthCubit authCubit = getIt<AuthCubit>();
  final formKey = GlobalKey<FormState>();
  return showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppPadding.p8),
          ),
          actions: [
            BlocConsumer(
              bloc: authCubit,
              listener: (context, state) {
                if (state is ForgotPasswordFailState) {
                  alertDialog(
                    context: context,
                    image: SvgManager.infoWarning,
                    message: state.message,
                    approveButtonTitle: LocaleKeys.retry,
                    onConfirm: (){
                      if (formKey.currentState!.validate()) {
                        authCubit.forgotPassword(login: emailController.text);
                      }
                    }
                  );
                }
                if (state is ForgotPasswordSuccessState) {
                  context.router.pop();
                  alertDialog(
                    context: context,
                    image: SvgManager.infoWarning,
                    message: state.baseResponse.message.toString(),
                    approveButtonTitle: LocaleKeys.retry,
                    onConfirm: (){


                    }
                  );
                }
              },
              builder: (context, state) {
                return Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      10.verticalSpace,
                      CustomTextField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        controller: emailController,
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
                      PrimaryButton(
                        isLoading: state is ForgotPasswordLoadingState,
                        text: LocaleKeys.ok.tr(),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            authCubit.forgotPassword(login: emailController.text);
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        );
      });
}
