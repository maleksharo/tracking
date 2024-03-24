import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking/app/app_prefs.dart';
import 'package:tracking/app/core/widgets/svg_icon_widget.dart';
import 'package:tracking/app/di/injection.dart';
import 'package:tracking/app/resources/assets_manager.dart';
import 'package:tracking/app/resources/color_manager.dart';
import 'package:tracking/app/resources/language_manager.dart';
import 'package:tracking/app/resources/strings_manager.g.dart';
import 'package:tracking/app/routes/router.gr.dart';

import '../../../app/core/widgets/alert_dialog.dart';
import '../../auth/presentation/auth_cubit/auth_cubit.dart';
import '../../auth/presentation/view/widgets/change_server_widget.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AppPreferences appPreferences = getIt<AppPreferences>();
  final authCubit = getIt<AuthCubit>();

  List<String> servers = [];
  String? groupValue;

  @override
  void initState() {
    super.initState();
    groupValue = appPreferences.getAppLanguage();
    // if (appPreferences.getString(prefsKey: prefsBaseUrl).isEmpty) {
      authCubit.getServers();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) async {
        context.router.pushAndPopUntil(predicate: (route) => false, const HomeRoute());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.setting.tr()),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: Column(
            children: [
              Card(
                child: ExpansionTile(
                  leading: SvgIconWidget(
                    svgIcon: SvgManager.language,
                    height: 28.h,
                  ),
                  shape: const Border(
                    top: BorderSide.none,
                    bottom: BorderSide.none,
                  ),
                  subtitle: Text(
                    appPreferences.getAppLanguage() == "en" ? "English" : "العربية",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ColorManager.grey, fontSize: 10),
                  ),
                  title: Text(
                    LocaleKeys.language.tr(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ColorManager.primary),
                  ),
                  children: [
                    languageWidget(value: arabic, language: 'العربية'),
                    languageWidget(value: english, language: 'English'),
                  ],
                ),
              ),
              10.verticalSpace,
              BlocConsumer(
                bloc: authCubit,
                listener: _onGettingServersStateChanged,
                builder: (context, state) {
                  return ServersDropDownWidget(serversList: servers,isLogout: true,);
                },
              ),
              10.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget languageWidget({required String value, required String language}) {
    return ListTile(
      iconColor: ColorManager.secondary,
      selectedColor: ColorManager.secondary,
      onTap: null,
      leading: Radio<String?>(
        value: value,
        groupValue: groupValue,
        activeColor: ColorManager.secondary,
        onChanged: (language) async {
          if (language == arabic) {
            context.setLocale(arabicLocale);
          } else {
            context.setLocale(englishLocale);
          }
          groupValue = language;
          appPreferences.changeAppLanguage();
        },
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(
        language,
      ),
    );
  }

  void _onGettingServersStateChanged(
    BuildContext context,
    LoginState state,
  ) {
    if(state is GetServersLoadingState){
      progressDialog(context: context);
    }
    if (state is GetServersFailState) {
      Navigator.pop(context);
      alertDialog(
        context: context,
        image: SvgManager.infoWarning,
        message: state.message,
        approveButtonTitle: LocaleKeys.retry,
        onConfirm: () {
          authCubit.getServers();
        },
      );
    }

    if (state is GetServersSuccessState) {
      Navigator.pop(context);
      servers.addAll(state.servers);
    }
  }
}
