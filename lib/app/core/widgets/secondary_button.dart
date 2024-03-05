import 'package:tracking/app/core/utils/font_utils.dart';
import 'package:tracking/app/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecondaryButton extends StatelessWidget {
  SecondaryButton({
    this.isLoading = false,
    this.icon,
    this.text,
    this.isOutLine = false,
    this.borderRadius = 8,
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
  final bool isOutLine;
  final double borderRadius;
  final double? width;
  final double? height;
  final Color? textColor;
  final VoidCallback? onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: 54.h,
        decoration: BoxDecoration(
            color: isOutLine ? null : textColor ?? ColorManager.blackSwatch[13],
            borderRadius: BorderRadius.circular(borderRadius.r),
            border: isOutLine
                ? Border.all(color: textColor ?? ColorManager.blackSwatch[13]!)
                : null),
        alignment: Alignment.center,
        padding: EdgeInsetsDirectional.only(top: 12.h, bottom: 12.h),
        child: isLoading
            ? SizedBox(
                width: 24.r,
                height: 24.r,
                child: CircularProgressIndicator(
                  color: textColor ??
                      (isOutLine ? ColorManager.blackSwatch[13] : Colors.white),
                ),
              )
            : text != null ? Text(
                text ?? "",
                style: FontUtils.bebasTextStyle.copyWith(
                  color: textColor ??
                      (isOutLine ? ColorManager.blackSwatch[13] : Colors.white),
                  fontSize: 22,
                ),
              ): icon,
      ),
    );
  }
}
