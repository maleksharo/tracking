import 'package:tracking/app/core/utils/font_utils.dart';
import 'package:tracking/app/core/widgets/primary_button.dart';
import 'package:tracking/app/resources/strings_manager.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// todo: use it
class ErrorView extends StatelessWidget {
  final String? errorMsg;
  final VoidCallback? onRetry;

  const ErrorView({super.key, this.errorMsg, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 300.w,
          child: Text(
            errorMsg ?? LocaleKeys.defaultError.tr(),
            style: FontUtils.nexaTextStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
          ),
        ),
        if (onRetry != null) ...[
           SizedBox(
            height: 20.h,
          ),
          PrimaryButton(
            text: LocaleKeys.retry.tr(),
            onPressed: onRetry,
          )
        ],
      ],
    );
  }
}
