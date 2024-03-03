import 'package:tracking/app/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/font_utils.dart';

class PrimaryButton extends StatelessWidget {
   PrimaryButton({
    this.isLoading = false,
    this.icon,
    this.text,
    this.isLight = false,
    this.borderRadius = 58,
    this.width,
    this.height,
    this.textColor,
    this.backgroundColor,
    this.onPressed,
    super.key,
  }) {
    assert(
      (text != null) ^ (icon != null),
      'You should either provide the text or the icon, and not both of them',
    );
  }

  final String? text;
  final Icon? icon;
  final bool isLoading;
  final bool isLight;
  final double borderRadius;
  final double? width;
  final double? height;
  final Color? textColor;
  final VoidCallback? onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: width ?? .9.sw,
        height: height ?? 54.h,
        decoration: BoxDecoration(
          color: backgroundColor ?? (isLight ? ColorManager.primaryGreen : ColorManager.greenSwatch[500]),
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        alignment: Alignment.center,
        padding: EdgeInsetsDirectional.only(top: 12.h, bottom: 12.h),
        child: isLoading
            ? SizedBox(
                width: 24.r,
                height: 24.r,
                child: CircularProgressIndicator(
                  color: textColor ?? ColorManager.white,
                ),
              )
            : text != null
                ? Text(
                    text ?? "",
                    style: FontUtils.bebasTextStyle.copyWith(color: textColor ?? ColorManager.white, fontSize: 22),
                  )
                : icon,
      ),
    );
  }
}
