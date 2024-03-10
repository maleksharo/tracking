import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking/app/core/widgets/error_view.dart';
import 'package:tracking/app/di/injection.dart';
import 'package:tracking/app/resources/color_manager.dart';
import 'package:tracking/app/resources/strings_manager.g.dart';
import 'package:tracking/features/home/domain/entities/cars_data_entity.dart';
import 'package:tracking/features/home/presentation/cubit/home_cubit.dart';
import 'package:tracking/features/home/presentation/screens/widgets/car_info_card.dart';

@RoutePage()
class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final homeCubit = getIt<HomeCubit>();
  List<CarsDataEntity> carsList = [];

  @override
  void initState() {
    super.initState();
    homeCubit.getVehiclesData(firstTime: true,homeSource: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.reports.tr()),
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
                child: Padding(
                  padding:  EdgeInsets.all(8.0.sp),
                  child: CarInfoCard(
                    entity: carsList[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
