import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking/app/core/refresh_cubit/refresh_cubit.dart';
import 'package:tracking/app/core/widgets/primary_button.dart';
import 'package:tracking/app/di/injection.dart';
import 'package:tracking/app/resources/strings_manager.g.dart';
import 'package:tracking/features/home/domain/entities/cars_data_entity.dart';
import 'package:tracking/features/home/presentation/cubit/home_cubit.dart';
import 'package:tracking/features/home/presentation/screens/widgets/car_info_card.dart';
import 'package:tracking/features/home/presentation/screens/widgets/report_sheet.dart';
import 'package:tracking/features/home/presentation/screens/widgets/vehicle_routes_sheet.dart';

class CarInfoSheet extends StatefulWidget {
  const CarInfoSheet({
    super.key,
    required this.animationController,
    required this.entity,
    required this.onShowRoutePressed,
  });

  final CarsDataEntity entity;
  final Function(CarsDataEntity entity) onShowRoutePressed;
  final AnimationController animationController;

  @override
  State<CarInfoSheet> createState() => _CarInfoSheetState();

  static void show({
    required BuildContext context,
    required AnimationController animationController,
    required CarsDataEntity entity,
    required Function(CarsDataEntity entity) onShowRoutePressed,
  }) {
    showModalBottomSheet(
      transitionAnimationController: animationController,
      isDismissible: true,
      isScrollControlled: true,
      showDragHandle: true,
      enableDrag: true,
      context: context,
      useSafeArea: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.sp),
          topLeft: Radius.circular(10.sp),
        ),
      ),
      builder: (_) => Wrap(children: [
        CarInfoSheet(
          animationController: animationController,
          onShowRoutePressed: onShowRoutePressed,
          entity: entity,
        ),
      ]),
    );
  }
}

class _CarInfoSheetState extends State<CarInfoSheet> {
  final RefreshCubit refreshCubit = getIt<RefreshCubit>();
  final HomeCubit homeCubit = getIt<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(8.sp),
        topLeft: Radius.circular(8.sp),
      ),
      child: BlocBuilder(
        bloc: refreshCubit,
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
            child: Column(
              children: [
                CarInfoCard(entity: widget.entity),
                10.verticalSpace,
                BlocBuilder(
                  bloc: homeCubit,
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            PrimaryButton(
                              width: 0.35.sw,
                              text: LocaleKeys.showLastRoute.tr(),
                              isLoading: state is GetCarLocationLoadingState,
                              onPressed: () => widget.onShowRoutePressed(widget.entity),
                            ),
                            PrimaryButton(
                              width: 0.3.sw,
                              text: LocaleKeys.tripReport.tr(),
                              onPressed: () {
                                homeCubit.tracCarDeviceId = widget.entity.deviceId;
                                ReportsSheet.show(
                                  context: context,
                                  animationController: widget.animationController,
                                );
                              },
                            ),


                          ],
                        ),
                        10.verticalSpace,
                        PrimaryButton(
                          width: 0.3.sw,
                          text: LocaleKeys.vehicleRoutes.tr(),
                          onPressed: () {
                            homeCubit.tracCarDeviceId = widget.entity.deviceId;
                            VehicleRoutesSheet.show(
                              context: context,
                              animationController: widget.animationController,
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
                10.verticalSpace,
              ],
            ),
          );
        },
      ),
    );
  }
}
