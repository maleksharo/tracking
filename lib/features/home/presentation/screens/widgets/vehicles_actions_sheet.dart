import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart';
import 'package:tracking/app/resources/assets_manager.dart';
import 'package:tracking/app/resources/color_manager.dart';
import 'package:tracking/app/resources/strings_manager.g.dart';
import 'package:tracking/features/home/presentation/screens/widgets/report_sheet.dart';
import 'package:tracking/features/home/presentation/screens/widgets/vehicle_routes_sheet.dart';

import '../../../../../app/core/refresh_cubit/refresh_cubit.dart';
import '../../../../../app/core/widgets/custom_text_field.dart';
import '../../../../../app/core/widgets/primary_button.dart';
import '../../../../../app/di/injection.dart';
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
  bool isGetCarLastRouteLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIfTheListContainsOneVehicle();
  }

  checkIfTheListContainsOneVehicle() async {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (widget.carsList.length == 1) {
        print(widget.carsList.length);
        searchKeyController = TextEditingController(text: widget.carsList.first.deviceName);
        entity = widget.carsList.first;
        widget.onCarSelected(
          LatLng(
            widget.carsList.first.locationEntity.latitude,
            widget.carsList.first.locationEntity.longitude,
          ),
        );
        refreshCubit.refresh();
        timer.cancel();
      } else if (widget.carsList.isNotEmpty){
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.21.sh,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8.sp),
          topLeft: Radius.circular(8.sp),
        ),
        child: Scaffold(
            backgroundColor: ColorManager.lightGreyCalendar2,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder(
                  bloc: refreshCubit,
                  builder: (context, state) {
                    return searchField();
                  },
                ),
                BlocConsumer(
                  bloc: homeCubit,
                  listener: (context, state) {
                    if (state is GetCarLocationLoadingState) {
                      isGetCarLastRouteLoading = true;
                    }
                    if (state is GetCarLocationSuccessState) {
                      isGetCarLastRouteLoading = false;
                    }
                    if (state is GetCarLocationFailedState) {
                      isGetCarLastRouteLoading = false;
                    }
                  },
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            PrimaryButton(
                              width: 0.2.sw,
                              icon: const Icon(Icons.flag),
                              isLoading: isGetCarLastRouteLoading,
                              onPressed: () {
                                if (entity != null) {
                                  widget.onShowRoutePressed(entity!);
                                } else {
                                  Fluttertoast.showToast(msg: "Select vehicle first");
                                }
                              },
                            ),
                            Text(LocaleKeys.lastTrip.tr()),
                          ],
                        ),
                        Column(
                          children: [
                            PrimaryButton(
                              width: 0.2.sw,
                              icon: const Icon(Icons.description),
                              // text: LocaleKeys.tripReport.tr(),
                              onPressed: () {
                                homeCubit.clearTimes();
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
                            Text(LocaleKeys.tripReport.tr()),
                          ],
                        ),
                        Column(
                          children: [
                            PrimaryButton(
                              width: 0.2.sw,
                              icon: const Icon(Icons.route_sharp),
                              onPressed: () {
                                homeCubit.clearTimes();

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
                            Text(LocaleKeys.vehicleRoutes.tr()),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                10.verticalSpace,
              ],
            )),
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
