import 'package:auto_route/auto_route.dart';
import 'package:tracking/app/resources/assets_manager.dart';
import 'package:tracking/app/resources/color_manager.dart';
import 'package:tracking/app/resources/strings_manager.g.dart';
import 'package:tracking/app/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'svg_icon_widget.dart';


Future<void> alertDialog({
  required BuildContext context,
  required String image,
  required String message,
  bool isLottie = false,
  String approveButtonTitle = LocaleKeys.retry,
  required Function onConfirm,
  String rejectButtonTitle = LocaleKeys.cancel,
  Function? onCancel,
  bool isTwoButtons = true,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppPadding.p8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: AppPadding.p8,
                  right: AppPadding.p8,
                  left: AppPadding.p8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgIconWidget(
                      svgIcon: SvgManager.closeDialog,
                      width: AppSize.s12,
                      height: AppSize.s12,
                      onPressed: () {
                        context.router.pop();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: AppSize.s32,
              ),

              isLottie
                  ? getAnimatedImage(image)
                  : SvgIconWidget(
                      svgIcon: image,
                      width: 70.w,
                      height: 70.h,
                      onPressed: null,
                    ),
              const SizedBox(
                height: AppPadding.p20,
              ),
              Text(
                message,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: AppSize.s14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: AppPadding.p16,
              ),

              /// Buttons
              Padding(
                padding: const EdgeInsets.only(
                  bottom: AppPadding.p8,
                  right: AppPadding.p8,
                  left: AppPadding.p8,
                ),
                child: Row(
                  children: [
                    if (isTwoButtons) ...[
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: AppSize.s50,
                          child: ElevatedButton(
                            onPressed: () {
                              context.router.pop();
                              if (onCancel != null) {
                                onCancel();
                              }
                            },
                            style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                                  backgroundColor: MaterialStatePropertyAll(ColorManager.primary),
                                  elevation: const MaterialStatePropertyAll(AppSize.s0),
                                ),
                            child: Text(
                              rejectButtonTitle.tr(),
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ColorManager.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: AppSize.s8,
                      ),
                    ],
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: AppSize.s50,
                        child: ElevatedButton(
                          onPressed: () {
                            context.router.pop();
                            onConfirm();
                          },
                          style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                                backgroundColor: const MaterialStatePropertyAll(ColorManager.primaryBlue),
                                elevation: const MaterialStatePropertyAll(AppSize.s0),
                              ),
                          child: Text(
                            approveButtonTitle.tr(),
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ColorManager.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      });
}

Widget getAnimatedImage(String animationName) {
  return SizedBox(
    width: 100.w,
    height: 100.w,
    child: Lottie.asset(animationName),
  );
}

void progressDialog({required BuildContext context}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: Center(
            child: getAnimatedImage(JsonManager.loading),
          ),
        );
      });
}
