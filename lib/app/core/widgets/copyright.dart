import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking/app/resources/strings_manager.g.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../resources/color_manager.dart';

class CopyRight extends StatelessWidget {
  const CopyRight({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          thickness: 1,
          color: ColorManager.grey,
          endIndent: 30.w,
          indent: 30.w,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.poweredBy.tr(),
              style: TextStyle(
                color: ColorManager.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            5.horizontalSpace,
            InkWell(
              onTap: () async {
                Uri url = Uri.parse("http://www.itieit.com/");
                await launchUrl(url, mode: LaunchMode.externalApplication);
              },
              child: const Text(
                "ITieIt.com",
                style: TextStyle(
                  color: ColorManager.primaryBlue,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: ColorManager.primaryBlue,
                ),
              ),
            ),
          ],
        ),
        10.verticalSpace,
      ],
    );
  }
}
