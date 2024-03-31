import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking/app/core/refresh_cubit/refresh_cubit.dart';
import 'package:tracking/app/di/injection.dart';
import 'package:tracking/features/home/domain/entities/cars_data_entity.dart';
import 'package:tracking/features/home/presentation/cubit/home_cubit.dart';
import 'package:tracking/features/home/presentation/screens/widgets/car_info_card.dart';

class CarInfoSheet extends StatefulWidget {
  const CarInfoSheet({super.key, required this.entity});

  final CarsDataEntity entity;

  @override
  State<CarInfoSheet> createState() => _CarInfoSheetState();

  static void show({
    required BuildContext context,
    required CarsDataEntity entity,
  }) {
    showModalBottomSheet(
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
            padding: EdgeInsets.symmetric(horizontal: 8.0.sp, vertical: 8.0.sp),
            child: CarInfoCard(entity: widget.entity),
          );
        },
      ),
    );
  }
}
