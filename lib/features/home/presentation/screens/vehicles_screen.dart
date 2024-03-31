import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:tracking/app/core/refresh_cubit/refresh_cubit.dart';
import 'package:tracking/app/core/widgets/custom_text_field.dart';
import 'package:tracking/app/core/widgets/error_view.dart';
import 'package:tracking/app/di/injection.dart';
import 'package:tracking/app/resources/color_manager.dart';
import 'package:tracking/app/resources/strings_manager.g.dart';
import 'package:tracking/features/home/domain/entities/cars_data_entity.dart';
import 'package:tracking/features/home/presentation/cubit/home_cubit.dart';
import 'package:tracking/features/home/presentation/screens/widgets/car_info_card.dart';

import '../../../../app/core/utils/font_utils.dart';

@RoutePage()
class VehiclesScreen extends StatefulWidget {
  const VehiclesScreen({super.key});

  @override
  State<VehiclesScreen> createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen> with TickerProviderStateMixin {
  final homeCubit = getIt<HomeCubit>();
  final refresh = getIt<RefreshCubit>();
  List<CarsDataEntity> carsList = [];
  List<CarsDataEntity> searchedList = [];
  TextEditingController searchKeyController = TextEditingController();

  @override
  void initState() {
    homeCubit.getVehiclesData(firstTime: true, homeSource: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.vehicles.tr()),
      ),
      body: BlocBuilder(
        bloc: refresh,
        builder: (context, state) {
          return BlocConsumer(
            bloc: homeCubit,
            listener: (context, state) {
              if (state is GetCarsDataSuccessState) {
                if (state.firstTime) {
                  carsList.clear();
                  carsList.addAll(state.carsDataEntity.carsList);
                  searchedList.addAll(state.carsDataEntity.carsList);
                }
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
              return Column(
                children: [
                  searchField(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: searchedList.length,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 3,
                          child: ExpansionTile(
                            title: Text(
                              searchedList[index].deviceName,
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
                                  entity: searchedList[index],
                                ),
                              ),
                              // PrimaryButton(
                              //   width: 0.3.sw,
                              //   text: LocaleKeys.tripReport.tr(),
                              //   onPressed: () {
                              //     homeCubit.tracCarDeviceId = searchedList[index].deviceId;
                              //     ReportsSheet.show(
                              //       context: context,
                              //     );
                              //   },
                              // ),
                              // 10.verticalSpace,
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget searchField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: TypeAheadField<CarsDataEntity>(
        controller: searchKeyController,
        suggestionsCallback: (search) {
          if (search.isEmpty) {
            searchedList.clear();
            searchedList.addAll(carsList);
            refresh.refresh();
            return searchedList;
          }
          else {
            searchedList.clear();
            for (var item in carsList) {
              if (item.deviceName.toLowerCase().contains(search.toLowerCase()) ||
                  item.driverEntity.name.toLowerCase().contains(search.toLowerCase())) {
                searchedList.add(item);
              }
            }
            return searchedList.isEmpty ? carsList : searchedList;
          }
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
          searchedList.clear();
          searchedList.add(car);
          refresh.refresh();
        },
      ),
    );
  }
}
