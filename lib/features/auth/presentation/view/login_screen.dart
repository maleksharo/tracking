import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
import 'package:tracking/features/auth/presentation/view/widgets/login_drawer.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    form.controllers[0].text = appPreferences.getString(prefsKey: prefsEmail);
    form.controllers[1].text = appPreferences.getString(prefsKey: prefsPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      onDrawerChanged: (value) {
        if(value == false) {
          Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()),
          ModalRoute.withName(LoginRoute.name),
        );
        }
      },
      bottomNavigationBar: const CopyRight(),
      backgroundColor: ColorManager.white,
      drawer: LoginDrawer(
        servers: servers,
        onApplyPressed: () {
          _scaffoldKey.currentState!.closeDrawer();
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: ColorManager.darkPrimary,
                  ),
                ),
                SizedBox(height: 10.h),
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
                          CustomTextField(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            controller: form.controllers[0],
                            hint: LocaleKeys.yourEmail.tr(),
                            autoValidateMode: AutovalidateMode.onUserInteraction,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: LocaleKeys.fieldRequired.tr(),
                              ),
                              FormBuilderValidators.email(
                                errorText: LocaleKeys.invalidEmailAddress.tr(),
                              ),
                            ]),
                          ),
                          SizedBox(height: 24.h),
                          CustomTextField(
                            controller: form.controllers[1],
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
                          SizedBox(height: 8.h),
                          GestureDetector(
                            onTap: () {
                              forgotPasswordDialog(context: context);
                            },
                            child: Text(
                              LocaleKeys.forgetPassword.tr(),
                              style: FontUtils.nexaTextStyle
                                  .copyWith(fontWeight: FontWeight.w700, fontSize: 16, color: ColorManager.blueSwatch),
                            ),
                          ),
                          SizedBox(height: 40.h),
                          PrimaryButton(
                            isLoading: state is LoginLoadingState,
                            backgroundColor:
                            appPreferences.getString(prefsKey: prefsBaseUrl).isEmpty ? ColorManager.grey : null,
                            text: LocaleKeys.login.tr(),
                            onPressed: appPreferences.getString(prefsKey: prefsBaseUrl).isEmpty ? null : _onLoginTapped,
                          ),
                          SizedBox(height: 12.h),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
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
    if (state is LoginSuccessState) {
      authCubit.setUserInfo(
        token: state.userEntity.token,
        email: form.controllers[0].text,
        password: form.controllers[1].text,
      );
      context.router.replace(const HomeRoute());
    }

    if (state is LoginFailState) {
      alertDialog(
        context: context,
        image: SvgManager.infoWarning,
        message: state.message,
        approveButtonTitle: LocaleKeys.retry,
        onConfirm: _onLoginTapped,
      );
    }
    // if(state is GetServersLoadingState){
    //   progressDialog(context: context);
    // }
    // if (state is GetServersFailState) {
    //   Navigator.pop(context);
    //   alertDialog(
    //     context: context,
    //     image: SvgManager.infoWarning,
    //     message: state.message,
    //     approveButtonTitle: LocaleKeys.retry,
    //     onConfirm: () {
    //       authCubit.getServers();
    //     },
    //   );
    // }

    // if (state is GetServersSuccessState) {
    //   Navigator.pop(context);
    //   servers.addAll(state.servers);
    // }
  }

  @override
  int numberOfFields() => 2;
}
