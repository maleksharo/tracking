import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking/app/core/utils/font_utils.dart';
import 'package:tracking/app/core/widgets/primary_button.dart';
import 'package:tracking/app/di/injection.dart';
import 'package:tracking/app/resources/color_manager.dart';
import 'package:tracking/app/resources/strings_manager.g.dart';
import 'package:tracking/features/home/domain/entities/cars_data_entity.dart';
import 'package:tracking/features/home/presentation/cubit/home_cubit.dart';
import 'package:tracking/features/home/presentation/screens/widgets/car_info_card.dart';

Future<void> carInfoDialog({
  required BuildContext context,
  required CarsDataEntity entity,
  required Function(CarsDataEntity entity) onShowRoutePressed,
}) {
  final homeCubit = getIt<HomeCubit>();
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 8.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocaleKeys.carInfo.tr(),
                          style: FontUtils.nexaTextStyle.copyWith(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () => context.router.pop(),
                          icon: Icon(
                            Icons.close,
                            color: ColorManager.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CarInfoCard(entity: entity),
                  BlocBuilder(
                    bloc:homeCubit,
                    builder: (context, state) {
                      return PrimaryButton(
                        text: LocaleKeys.showLastRoute.tr(),
                        isLoading: state is GetCarLocationLoadingState,
                        onPressed: () => onShowRoutePressed(entity),
                      );
                    },
                  ),
                ],
              ),
            ));
      });
}
