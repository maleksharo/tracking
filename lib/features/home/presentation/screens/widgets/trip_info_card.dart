import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking/app/resources/strings_manager.g.dart';
import 'package:tracking/features/home/domain/entities/vehicle_trips_entity.dart';

import '../../../../../app/core/utils/font_utils.dart';
import '../../../../../app/resources/color_manager.dart';

class TripInfoCard extends StatelessWidget {
  final VehicleTripsEntity entity;

  const TripInfoCard({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: SizedBox(
        width: 0.5.sw,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${LocaleKeys.startTime.tr()}: ",
                    style: FontUtils.nexaTextStyle,
                  ),
                  10.horizontalSpace,
                  Text(
                    entity.startTime,
                    style: FontUtils.nexaTextStyle.copyWith(color: ColorManager.primaryOil),
                  ),
                ],
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${LocaleKeys.endTime.tr()}: ",
                    style: FontUtils.nexaTextStyle,
                  ),
                  10.horizontalSpace,
                  Text(
                    entity.endTime,
                    style: FontUtils.nexaTextStyle.copyWith(color: ColorManager.primaryOil),
                  ),
                ],
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${LocaleKeys.duration.tr()}: ",
                    style: FontUtils.nexaTextStyle,
                  ),
                  10.horizontalSpace,
                  Text(
                    "${entity.duration}H",
                    style: FontUtils.nexaTextStyle.copyWith(color: ColorManager.primaryOil),
                  ),
                ],
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${LocaleKeys.distance.tr()}: ",
                    style: FontUtils.nexaTextStyle,
                  ),
                  10.horizontalSpace,
                  Text(
                    "${entity.distance}KM",
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
                    "${LocaleKeys.startAddress.tr()}: ",
                    style: FontUtils.nexaTextStyle,
                  ),
                  10.horizontalSpace,
                  SizedBox(
                    width: 0.5.sw,
                    child: Text(
                      maxLines: 3,
                      entity.startAddress,
                      style: FontUtils.nexaTextStyle.copyWith(color: ColorManager.primaryOil),
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${LocaleKeys.endAddress.tr()}: ",
                    style: FontUtils.nexaTextStyle,
                  ),
                  10.horizontalSpace,
                  SizedBox(
                    width: 0.5.sw,
                    child: Text(
                      maxLines: 3,
                      entity.endAddress.toString(),
                      style: FontUtils.nexaTextStyle.copyWith(color: ColorManager.primaryOil),
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
