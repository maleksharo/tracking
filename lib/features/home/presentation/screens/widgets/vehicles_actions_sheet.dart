import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart';
import 'package:tracking/app/resources/assets_manager.dart';
import 'package:tracking/app/resources/color_manager.dart';
import 'package:tracking/features/home/presentation/screens/widgets/report_sheet.dart';
import 'package:tracking/features/home/presentation/screens/widgets/vehicle_routes_sheet.dart';

import '../../../../../app/core/refresh_cubit/refresh_cubit.dart';
import '../../../../../app/core/widgets/custom_text_field.dart';
import '../../../../../app/core/widgets/primary_button.dart';
import '../../../../../app/di/injection.dart';
import '../../../../../app/resources/strings_manager.g.dart';
import '../../../domain/entities/cars_data_entity.dart';
import '../../cubit/home_cubit.dart';

class VehiclesActionsSheet extends StatefulWidget {
  final List<CarsDataEntity> carsList;
  final Function(LatLng) onCarSelected;
  final Function(CarsDataEntity entity) onShowRoutePressed;

  const VehiclesActionsSheet({
    super.key,
    required this.carsList,
    required this.onCarSelected,
    required this.onShowRoutePressed,
  });

  @override
  State<VehiclesActionsSheet> createState() => _VehiclesActionsSheetState();
}

class _VehiclesActionsSheetState extends State<VehiclesActionsSheet> {
  final homeCubit = getIt<HomeCubit>();
  final refreshCubit = getIt<RefreshCubit>();
  TextEditingController searchKeyController = TextEditingController();
  CarsDataEntity? entity;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(8.sp),
        topLeft: Radius.circular(8.sp),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.35,
        minChildSize: 0.04,
        maxChildSize: 1,
        snap: true,
        expand: false,
        snapSizes: const [0.04, 0.35, 0.5, 0.7, 1],
        builder: (context, scrollController) {
          return Scaffold(
              backgroundColor: ColorManager.lightGreyCalendar2,
              body: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageManager.sheetHolder,
                      width: 40.w,
                      height: 20.h,
                    ),
                    searchField(),
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
                                  onPressed: () {
                                    if (entity != null) {
                                      widget.onShowRoutePressed(entity!);
                                    } else {
                                      Fluttertoast.showToast(msg: "Select vehicle first");
                                    }
                                  },
                                ),
                                PrimaryButton(
                                  width: 0.3.sw,
                                  text: LocaleKeys.tripReport.tr(),
                                  onPressed: () {
                                    if (entity != null) {
                                      homeCubit.tracCarDeviceId = entity!.deviceId;
                                      ReportsSheet.show(
                                        context: context,
                                      );
                                    } else {
                                      Fluttertoast.showToast(msg: "Select vehicle first");
                                    }
                                  },
                                ),
                              ],
                            ),
                            10.verticalSpace,
                            PrimaryButton(
                              width: 0.3.sw,
                              text: LocaleKeys.vehicleRoutes.tr(),
                              onPressed: () {
                                if (entity != null) {
                                  homeCubit.tracCarDeviceId = entity!.deviceId;
                                  VehicleRoutesSheet.show(
                                    context: context,
                                  );
                                } else {
                                  Fluttertoast.showToast(msg: "Select vehicle first");
                                }
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    10.verticalSpace,
                  ],
                ),
              ));
        },
      ),
    );
  }

  Widget searchField() {
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: TypeAheadField<CarsDataEntity>(
        controller: searchKeyController,
        suggestionsCallback: (search) {
          List<CarsDataEntity> temp = [];
          if (search.isNotEmpty) {
            for (var item in widget.carsList) {
              if (item.deviceName.toLowerCase().contains(search.toLowerCase()) ||
                  item.driverEntity.name.toLowerCase().contains(search.toLowerCase())) {
                temp.add(item);
              }
            }
          }
          return temp.isEmpty ? widget.carsList : temp;
        },
        builder: (context, controller, focusNode) {
          return CustomTextField(
            controller: searchKeyController,
            focusNode: focusNode,
            hint: "Search for a car",
          );
        },
        itemBuilder: (context, car) {
          return Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: ListTile(
              title: Text(car.deviceName),
              subtitle: Text(car.driverEntity.name),
            ),
          );
        },
        onSelected: (car) {
          searchKeyController.text = car.deviceName;
          entity = car;
          widget.onCarSelected(
            LatLng(
              car.locationEntity.latitude,
              car.locationEntity.longitude,
            ),
          );

          refreshCubit.refresh();
        },
      ),
    );
  }
}
