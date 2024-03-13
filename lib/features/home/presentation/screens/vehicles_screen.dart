import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking/app/core/widgets/error_view.dart';
import 'package:tracking/app/core/widgets/primary_button.dart';
import 'package:tracking/app/di/injection.dart';
import 'package:tracking/app/resources/color_manager.dart';
import 'package:tracking/app/resources/strings_manager.g.dart';
import 'package:tracking/features/home/domain/entities/cars_data_entity.dart';
import 'package:tracking/features/home/presentation/cubit/home_cubit.dart';
import 'package:tracking/features/home/presentation/screens/widgets/car_info_card.dart';
import 'package:tracking/features/home/presentation/screens/widgets/report_sheet.dart';

import '../../../../app/core/utils/font_utils.dart';

@RoutePage()
class VehiclesScreen extends StatefulWidget {
  const VehiclesScreen({super.key});

  @override
  State<VehiclesScreen> createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen> with TickerProviderStateMixin {
  final homeCubit = getIt<HomeCubit>();
  List<CarsDataEntity> carsList = [];
  late AnimationController controller;

  @override
  void initState() {
    homeCubit.getVehiclesData(firstTime: true, homeSource: false);

    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(seconds: 1);
    controller.reverseDuration = const Duration(seconds: 1);
    controller.drive(CurveTween(curve: Curves.easeIn));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.vehicles.tr()),
      ),
      body: BlocConsumer(
        bloc: homeCubit,
        listener: (context, state) {
          if (state is GetCarsDataSuccessState) {
            carsList.clear();
            carsList.addAll(state.carsDataEntity.carsList);
          }
        },
        builder: (context, state) {
          if (state is GetCarsDataFailedState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ErrorView(
                onRetry: () {
                  homeCubit.getVehiclesData();
                },
                errorMsg: state.message,
              ),
            );
          } else if (state is GetCarsDataLoadingState && state.firstTime) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0.h),
              child: LinearProgressIndicator(
                backgroundColor: ColorManager.darkGrey,
              ),
            );
          }
          return ListView.builder(
            itemCount: carsList.length,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                child: ExpansionTile(
                  title: Text(
                    carsList[index].deviceName,
                    style: FontUtils.nexaTextStyle.copyWith(color: ColorManager.primaryOil),
                  ),
                  shape: const Border(
                    top: BorderSide.none,
                    bottom: BorderSide.none,
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: CarInfoCard(
                        entity: carsList[index],
                      ),
                    ),
                    PrimaryButton(
                      width: 0.3.sw,
                      text: LocaleKeys.tripReport.tr(),
                      onPressed: () {
                        homeCubit.tracCarDeviceId = carsList[index].deviceId;
                        ReportsSheet.show(
                          context: context,
                          animationController: controller,
                        );
                      },
                    ),
                    10.verticalSpace,
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
