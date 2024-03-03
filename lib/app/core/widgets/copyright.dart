// // import 'package:tracking/app/core/utils/font_utils.dart';
// import 'package:tracking/app/resources/assets_manager.dart';
// import 'package:tracking/app/resources/strings_manager.g.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// class CopyRight extends StatelessWidget {
//   const CopyRight({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final textStyle = FontUtils.nexaTextStyle.copyWith(
//       color: ColorManager.blackSwatch[8],
//       fontWeight: FontWeight.w400,
//       fontSize: 10,
//     );
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SvgPicture.asset(
//           SvgManager.copyRight,
//         ),
//         SizedBox(width: 4.w),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               LocaleKeys.allRightsReserved.tr(),
//               style: textStyle,
//             ),
//             Text(
//               LocaleKeys.termsAndConditionCookies.tr(),
//               style: textStyle,
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }
