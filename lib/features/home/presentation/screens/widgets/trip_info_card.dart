import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking/app/core/widgets/alert_dialog.dart';
import 'package:tracking/app/core/widgets/primary_button.dart';
import 'package:tracking/app/di/injection.dart';
import 'package:tracking/app/resources/assets_manager.dart';
import 'package:tracking/app/resources/strings_manager.g.dart';
import 'package:tracking/app/routes/router.gr.dart';
import 'package:tracking/features/home/domain/entities/vehicle_trips_entity.dart';
import 'package:tracking/features/home/presentation/cubit/home_cubit.dart';

import '../../../../../app/core/utils/font_utils.dart';
import '../../../../../app/resources/color_manager.dart';

class TripInfoCard extends StatelessWidget {
  final VehicleTripsEntity entity;

  TripInfoCard({super.key, required this.entity});

  final HomeCubit homeCubit = getIt<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: SizedBox(
        width: 0.5.sw,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.verticalSpace,
                  Text(
                    "${LocaleKeys.startTime.tr()}: ",
                    style: FontUtils.nexaTextStyle,
                  ),
                  10.horizontalSpace,
                  Text(
                    entity.startTime,
                    style:
                        FontUtils.nexaTextStyle.copyWith(color: ColorManager.primaryOil, fontWeight: FontWeight.w600),
                    maxLines: 2,
                  ),
                  10.verticalSpace,
                  Text(
                    "${LocaleKeys.endTime.tr()}: ",
                    style: FontUtils.nexaTextStyle,
                  ),
                  10.horizontalSpace,
                  Text(
                    entity.endTime,
                    style:
                        FontUtils.nexaTextStyle.copyWith(color: ColorManager.primaryOil, fontWeight: FontWeight.w600),
                    maxLines: 2,
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
                        entity.duration.toString(),
                        // convertDoubleToTime(decimalHours: entity.duration.toString()),
                        style: FontUtils.nexaTextStyle
                            .copyWith(color: ColorManager.primaryOil, fontWeight: FontWeight.w600),
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
                        "${entity.distance} KM",
                        style: FontUtils.nexaTextStyle
                            .copyWith(color: ColorManager.primaryOil, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  Text(
                    "${LocaleKeys.startAddress.tr()}: ",
                    style: FontUtils.nexaTextStyle,
                  ),
                  10.horizontalSpace,
                  SizedBox(
                    width: 0.9.sw,
                    child: Text(
                      maxLines: 3,
                      entity.startAddress,
                      style:
                          FontUtils.nexaTextStyle.copyWith(color: ColorManager.primaryOil, fontWeight: FontWeight.w600),
                    ),
                  ),
                  10.verticalSpace,
                  Text(
                    "${LocaleKeys.endAddress.tr()}: ",
                    style: FontUtils.nexaTextStyle,
                  ),
                  10.horizontalSpace,
                  SizedBox(
                    width: 0.9.sw,
                    child: Text(
                      maxLines: 3,
                      entity.endAddress.toString(),
                      style:
                          FontUtils.nexaTextStyle.copyWith(color: ColorManager.primaryOil, fontWeight: FontWeight.w600),
                    ),
                  ),
                  10.verticalSpace,
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: BlocConsumer(
                  bloc: homeCubit,
                  listener: (context, state) {
                    if (state is GetTripInfoFailedState) {
                      alertDialog(
                        context: context,
                        image: SvgManager.infoWarning,
                        message: state.message,
                        approveButtonTitle: LocaleKeys.retry,
                        onConfirm: () {
                          homeCubit.getVehicleRoutesBetweenTwoTimes();
                        },
                      );
                    }
                  },
                  builder: (context, state) {
                    return PrimaryButton(
                      width: 0.1.sw,
                      isLoading: state is GetTripInfoLoadingState,
                      icon: const Icon(Icons.location_on_outlined),
                      onPressed: () {
                        DateTime startTime = DateTime.parse(entity.startTime);
                        DateTime endTime = DateTime.parse(entity.endTime);
                        homeCubit.fromTimeServer = startTime.toUtc().toIso8601String();
                        homeCubit.fromTimeController.text = entity.startTime;
                        homeCubit.toTimeController.text = entity.endTime;
                        homeCubit.toTimeServer = endTime.toUtc().toIso8601String();

                        context.router.push(const TripOnMapRoute());
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
