import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:tracking/app/core/refresh_cubit/refresh_cubit.dart';
import 'package:tracking/app/core/utils/string_extensions.dart';
import 'package:tracking/app/core/widgets/alert_dialog.dart';
import 'package:tracking/app/core/widgets/custom_text_field.dart';
import 'package:tracking/app/core/widgets/primary_button.dart';
import 'package:tracking/app/di/injection.dart';
import 'package:tracking/app/resources/color_manager.dart';
import 'package:tracking/app/resources/strings_manager.g.dart';
import 'package:tracking/features/home/domain/entities/vehicle_trips_entity.dart';
import 'package:tracking/features/home/presentation/cubit/home_cubit.dart';

import '../../../../../app/core/widgets/date_time_picker.dart';
import '../../../../../app/functions.dart';
import '../../../../../app/resources/assets_manager.dart';

class VehicleRoutesSheet extends StatefulWidget {
  const VehicleRoutesSheet({super.key});

  @override
  State<VehicleRoutesSheet> createState() => _VehicleRoutesSheetState();

  static void show({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      useSafeArea: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.sp),
          topLeft: Radius.circular(10.sp),
        ),
      ),
      builder: (_) => const Wrap(
        children: [
          VehicleRoutesSheet(),
        ],
      ),
    );
  }
}

class _VehicleRoutesSheetState extends State<VehicleRoutesSheet> {
  final HomeCubit homeCubit = getIt<HomeCubit>();
  final RefreshCubit refreshCubit = getIt<RefreshCubit>();
  List<VehicleTripsEntity> vehicleTrips = [];
  final formKey = GlobalKey<FormState>();
  int hour = 00;
  int min = 00;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

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
            padding: EdgeInsets.all(8.0.sp),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Card(
                    child: ExpansionTile(
                      title: Text(
                        LocaleKeys.vehicleRoutes.tr(),
                      ),
                      initiallyExpanded: true,
                      shape: const Border(
                        top: BorderSide.none,
                        bottom: BorderSide.none,
                      ),
                      childrenPadding: EdgeInsets.all(8.0.sp),
                      children: [
                        CustomTextField(
                          controller: homeCubit.fromTimeController,
                          labelText: LocaleKeys.startTime.tr(),
                          hint: LocaleKeys.startTime.tr(),
                          isFieldObscure: false,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          readOnly: true,
                          validator: (val){
                            if (val!.isEmpty) {
                              return LocaleKeys.fieldRequired.tr();
                            }
                            else {
                              return null;
                            }
                          },
                          onTab: () async {
                            DateTime? selectedDateTime = await selectDate(context: context, hours: 07, min: 00);
                            if (selectedDateTime != null) {
                              DateTime combinedDateTime = combineDateAndTime(selectedDateTime, selectedTime);
                              homeCubit.fromTimeController.text = combinedDateTime.toString().removeSeconds();
                              homeCubit.fromTimeServer = combinedDateTime.toUtc().toIso8601String();
                              DateTime dateTime = DateTime.parse(homeCubit.fromTimeController.text);

                              hour = dateTime.hour;
                              min = dateTime.minute;
                            }

                            refreshCubit.refresh();
                          },
                        ),
                        10.verticalSpace,
                        CustomTextField(
                          controller: homeCubit.toTimeController,
                          labelText: LocaleKeys.endTime.tr(),
                          hint: LocaleKeys.endTime.tr(),
                          isFieldObscure: false,
                          validator: (value) {
                            return compareDateValidator(
                              endDateTime: homeCubit.toTimeController.text,
                              startDateTime: homeCubit.fromTimeController.text,
                              checkTimeGap: true,
                            );
                          },
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          readOnly: true,
                          onTab: () async {
                            DateTime? selectedDateTime = await selectDate(context: context, hours: hour + 6, min: min);
                            if (selectedDateTime != null) {
                              DateTime combinedDateTime = combineDateAndTime(selectedDateTime, selectedTime);
                              homeCubit.toTimeController.text = combinedDateTime.toString().removeSeconds();
                              homeCubit.toTimeServer = combinedDateTime.toUtc().toIso8601String();
                            }
                            refreshCubit.refresh();
                          },
                        ),
                        10.verticalSpace,
                        BlocConsumer(
                          bloc: homeCubit,
                          listener: (context, state) {
                            if (state is GetTripInfoFailedState) {
                              alertDialog(
                                context: context,
                                image: SvgManager.infoWarning,
                                message: state.message,
                                approveButtonTitle: LocaleKeys.retry,
                                onConfirm: () {
                                  if (formKey.currentState!.validate()) {
                                    if (homeCubit.fromTimeServer.isNotEmpty && homeCubit.toTimeServer.isNotEmpty) {
                                      homeCubit.getVehicleRoutesBetweenTwoTimes();
                                    } else {
                                      Fluttertoast.showToast(msg: LocaleKeys.fieldRequired.tr());
                                    }
                                  }
                                },
                              );
                            }
                            if(state is GetTripInfoLoadingState){
                              isLoading = true;
                              refreshCubit.refresh();
                            }
                            if(state is GetTripInfoSuccessState){
                              isLoading = false;
                              log(isLoading.toString(),name: "isExpanded");
                              refreshCubit.refresh();
                            }

                          },
                          builder: (context, state) {
                            return PrimaryButton(
                              width: 0.5.sw,
                              text: LocaleKeys.ok.tr(),
                              isLoading: isLoading,
                              backgroundColor: checkButtonAvailability() ? null : ColorManager.grey ,
                              onPressed:  () {
                                if(checkButtonAvailability()){
                                  if (formKey.currentState!.validate()) {
                                    if (homeCubit.fromTimeServer.isNotEmpty && homeCubit.toTimeServer.isNotEmpty) {
                                      homeCubit.getVehicleRoutesBetweenTwoTimes();
                                    } else {
                                      Fluttertoast.showToast(msg: LocaleKeys.fieldRequired.tr());
                                    }
                                  }
                                }

                              },
                            );
                          },
                        ),
                        10.verticalSpace,
                      ],
                    ),
                  ),
                  10.verticalSpace,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
    bool checkButtonAvailability(){
    return homeCubit.fromTimeController.text.isNotEmpty && homeCubit.toTimeController.text.isNotEmpty;
  }
}
