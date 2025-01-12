import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking/app/di/injection.dart';
import 'package:tracking/app/resources/strings_manager.g.dart';
import 'package:tracking/features/home/domain/entities/cars_data_entity.dart';
import 'package:tracking/features/home/presentation/cubit/home_cubit.dart';

import '../../../../../app/core/utils/font_utils.dart';
import '../../../../../app/resources/color_manager.dart';

class CarInfoCard extends StatelessWidget {
  final CarsDataEntity entity;

  CarInfoCard({super.key, required this.entity});

  final homeCubit = getIt<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        10.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${LocaleKeys.deviceName.tr()}: ",
              style: FontUtils.nexaTextStyle,
            ),
            10.horizontalSpace,
            Text(
              entity.deviceName,
              style: FontUtils.nexaTextStyle.copyWith(color: ColorManager.primaryOil),
            ),
          ],
        ),
        10.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${LocaleKeys.status.tr()}: ",
              style: FontUtils.nexaTextStyle,
            ),
            10.horizontalSpace,
            Text(
              entity.status,
              style: FontUtils.nexaTextStyle.copyWith(color: ColorManager.primaryOil),
            ),
            10.horizontalSpace,
            Image.asset(
              homeCubit.detectCarColorPath(carStatus: entity.status),
              width: 30.w,
              height: 30.w,
            ),
          ],
        ),
        10.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${LocaleKeys.driverName.tr()}: ",
              style: FontUtils.nexaTextStyle,
            ),
            10.horizontalSpace,
            Text(
              entity.driverEntity.name,
              style: FontUtils.nexaTextStyle.copyWith(color: ColorManager.primaryOil),
            ),
          ],
        ),
        10.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${LocaleKeys.lastLocation.tr()}: ",
              style: FontUtils.nexaTextStyle,
            ),
            10.horizontalSpace,
            SizedBox(
              width: 0.45.sw,
              child: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                entity.lastAddress,
                style: FontUtils.nexaTextStyle.copyWith(color: ColorManager.primaryOil),
              ),
            ),
          ],
        ),
        10.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${LocaleKeys.lastReportingTime.tr()}: ",
              style: FontUtils.nexaTextStyle,
            ),
            10.horizontalSpace,
            SizedBox(
              width: 0.3.sw,
              child: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                entity.dateLocalization,
                style: FontUtils.nexaTextStyle.copyWith(color: ColorManager.primaryOil),
              ),
            ),

          ],
        ),
        // 10.verticalSpace,
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     Text(
        //       "${LocaleKeys.breakDuration.tr()}: ",
        //       style: FontUtils.nexaTextStyle,
        //     ),
        //     10.horizontalSpace,
        //     Text(
        //       entity.breakDuration.toString(),
        //       style: FontUtils.nexaTextStyle.copyWith(color: ColorManager.primaryOil),
        //     ),
        //   ],
        // ),
        10.verticalSpace,
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     Text(
        //       "${LocaleKeys.lastUpdate.tr()}: ",
        //       style: FontUtils.nexaTextStyle,
        //     ),
        //     10.horizontalSpace,
        //     Text(
        //       formatDateTime(entity.lastUpdate,),
        //
        //       style: FontUtils.nexaTextStyle.copyWith(color: ColorManager.primaryOil),
        //     ),
        //   ],
        // ),
      ],
    );
  }
  String formatDateTime(String inputString) {
    if(inputString.isNotEmpty){
      DateTime dateTime = DateTime.parse(inputString);
      String formattedDateTime = DateFormat("yyyy-MM-dd HH:mm").format(dateTime);
      return formattedDateTime;
    }
    return 'Not available';
  }
}
