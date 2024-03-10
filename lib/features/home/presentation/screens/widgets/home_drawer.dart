import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking/app/core/widgets/alert_dialog.dart';
import 'package:tracking/app/core/widgets/primary_button.dart';
import 'package:tracking/app/di/injection.dart';
import 'package:tracking/app/resources/assets_manager.dart';
import 'package:tracking/app/resources/strings_manager.g.dart';
import 'package:tracking/app/routes/router.gr.dart';
import 'package:tracking/features/home/presentation/cubit/home_cubit.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({super.key});

  final homeCubit = getIt<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Drawer(
        width: 200.w,
        backgroundColor: Colors.transparent,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                100.verticalSpace,
                Image.asset(ImageManager.appLogo),
                20.verticalSpace,
                PrimaryButton(
                  text: LocaleKeys.vehicles.tr(),
                  onPressed: () {
                    context.router.push(const VehiclesRoute());
                  },
                ),
                20.verticalSpace,
                // PrimaryButton(
                //   text: LocaleKeys.reports.tr(),
                //   onPressed: () {
                //     /// TODO: Go to reports page
                //   },
                // ),
                // 20.verticalSpace,
                PrimaryButton(
                  text: LocaleKeys.setting.tr(),
                  onPressed: () {
                    context.router.push(const SettingsRoute());

                  },
                ),
                20.verticalSpace,
                PrimaryButton(
                  text: LocaleKeys.logout.tr(),
                  onPressed: () {
                    alertDialog(
                      context: context,
                      image: SvgManager.infoWarning,
                      message: LocaleKeys.askingToLogout.tr(),
                      approveButtonTitle: LocaleKeys.ok,
                      isTwoButtons: true,
                      onConfirm: () async {
                        homeCubit.logout().then((value) {
                          return context.router.replace(const LoginRoute());
                        });
                      },
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
}
