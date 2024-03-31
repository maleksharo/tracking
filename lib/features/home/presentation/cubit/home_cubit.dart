import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:tracking/app/app_prefs.dart';
import 'package:tracking/app/resources/assets_manager.dart';
import 'package:tracking/app/resources/strings_manager.g.dart';
import 'package:tracking/features/home/domain/entities/car_location_entity.dart';
import 'package:tracking/features/home/domain/entities/cars_data_entity.dart';
import 'package:tracking/features/home/domain/entities/company_vehicles_entity.dart';
import 'package:tracking/features/home/domain/entities/vehicle_routes_entity.dart';
import 'package:tracking/features/home/domain/entities/vehicle_trips_entity.dart';
import 'package:tracking/features/home/domain/usecases/get_car_location_usecase.dart';
import 'package:tracking/features/home/domain/usecases/get_car_trip_route_usecase.dart';
import 'package:tracking/features/home/domain/usecases/get_cars_data_usecase.dart';
import 'package:tracking/features/home/domain/usecases/get_trip_info_usecase.dart';
import 'package:tracking/features/home/presentation/screens/widgets/car_info_sheet.dart';
import 'package:tracking/features/home/presentation/trips_params.dart';

part 'home_state.dart';

@lazySingleton
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this.getCarLocationUseCase,
    this.getCarTripRouteUseCase,
    this.getCarsDataUseCase,
    this.getTripInfoUseCase,
    this.appPreferences,
  ) : super(HomeInitial());
  final GetCarLocationUseCase getCarLocationUseCase;
  final GetCarTripRouteUseCase getCarTripRouteUseCase;
  final GetCarsDataUseCase getCarsDataUseCase;
  final GetTripInfoUseCase getTripInfoUseCase;
  final AppPreferences appPreferences;

  List<dynamic> carLocationsRoute = [];

  TextEditingController fromTimeController = TextEditingController();
  TextEditingController toTimeController = TextEditingController();
  String fromTimeServer = "";
  String toTimeServer = "";
  int tracCarDeviceId = -1;


  /// This api is for giving last one hour trip for a specific car
  Future<void> getVehicleLastOneHourRoute({required int tracCarDeviceId}) async {
    emit(GetCarLocationLoadingState());
    (await getCarLocationUseCase.execute(tracCarDeviceId)).fold(
      (l) {
        emit(GetCarLocationFailedState(message: l.errorMessage ?? LocaleKeys.defaultError.tr()));
      },
      (responseEntity) async {
        carLocationsRoute.clear();
        carLocationsRoute.addAll(responseEntity.carLocations);
        emit(GetCarLocationSuccessState(recordsCarLocationEntity: responseEntity));
      },
    );
  }

  /// This api will give me all vehicle trips between 2 times
  Future<void> getVehicleTripsBetweenTwoTime() async {

    emit(GetCarTripRouteLoadingState());
    (await getCarTripRouteUseCase.execute(
      GetTripInfoUseCaseParams(tripParams: TripParams(from: fromTimeServer, to: toTimeServer), tracCarDeviceId: tracCarDeviceId),
    ))
        .fold(
      (l) {
        emit(GetCarTripRouteFailedState(message: l.errorMessage ?? LocaleKeys.defaultError.tr()));
      },
      (responseEntity) async {
        emit(GetCarTripRouteSuccessState(recordsVehicleTripsEntity: responseEntity));
      },
    );
  }

  /// This api is giving me all vehicles data
  Future<void> getVehiclesData({bool firstTime = false, bool homeSource = true}) async {
    emit(GetCarsDataLoadingState(firstTime: firstTime));
    (await getCarsDataUseCase.execute(Void)).fold(
      (l) {
        emit(GetCarsDataFailedState(message: l.errorMessage ?? LocaleKeys.defaultError.tr()));
      },
      (responseEntity) async {
        emit(GetCarsDataSuccessState(
          carsDataEntity: responseEntity,
          firstTime: firstTime,
          homeSource: homeSource,
        ));
      },
    );
  }

  /// This api will give me all vehicle routes between 2 times
  Future<void> getVehicleRoutesBetweenTwoTimes() async {

    emit(GetTripInfoLoadingState());
    (await getTripInfoUseCase.execute(GetTripInfoUseCaseParams(
      tracCarDeviceId: tracCarDeviceId,
      tripParams:  TripParams(from: fromTimeServer, to: toTimeServer),
    )))
        .fold(
      (l) {
        emit(GetTripInfoFailedState(message: l.errorMessage ?? LocaleKeys.defaultError.tr()));
      },
      (responseEntity) async {
        carLocationsRoute.clear();
        carLocationsRoute.addAll(responseEntity.vehicleRoutes);
        emit(GetTripInfoSuccessState(recordsVehicleRoutesEntity: responseEntity));
      },
    );
  }

  LatLng initCamera({required List<dynamic> carsList}) {
    double long = 0.0, lat = 0.0;
    int carsNumber = 0;
    if (carsList.first.runtimeType.toString() == "CarsDataEntity") {
      for (var car in carsList) {
        carsNumber++;
        long += car.locationEntity.longitude;
        lat += car.locationEntity.latitude;
      }
    } else if (carsList.first.runtimeType.toString() == "CarLocationEntity") {
      for (var car in carsList) {
        carsNumber++;
        long += car.longitude;
        lat += car.latitude;
      }
    }

    if (lat != 0 && long != 0 && carsNumber != 0) {
      lat = lat / carsNumber;
      long = long / carsNumber;
    }
    return LatLng(lat, long);
  }

  Marker buildCarMarker({
    required BuildContext context,
    required CarsDataEntity entity,
  }) {
    return Marker(
      point: LatLng(
        entity.locationEntity.latitude,
        entity.locationEntity.longitude,
      ),
      width: 50.w,
      height: 60.h,
      child: GestureDetector(
        onTap: () {
          emit(MoveToCarLocation(
            latLng: LatLng(
              entity.locationEntity.latitude,
              entity.locationEntity.longitude,
            ),
          ));

          CarInfoSheet.show(
            context: context,
            entity: entity,
          );
        },
        child: Image.asset(
          detectCarColorPath(carStatus: entity.status),
          width: 20.w,
          height: 20.w,
        ),
      ),
    );
  }

  Marker buildFlagMarker({
    required entity,
    required BuildContext context,
    required bool isStart,
  }) {
    return Marker(
      point: LatLng(
        entity.latitude,
        entity.longitude,
      ),
      width: 35.w,
      height: 35.w,
      child: Image.asset(
        isStart ? ImageManager.greenFlag : ImageManager.redFlag,
        width: 15.w,
        height: 15.w,
      ),
    );
  }


  String detectCarColorPath({required String carStatus}) {
    String iconPath = "";
    if (carStatus.toLowerCase() == "engine off") {
      iconPath = ImageManager.redCar;
    } else if (carStatus.toLowerCase() == "engine on") {
      iconPath = ImageManager.greenCar;
    } else if (carStatus.toLowerCase() == "idling") {
      iconPath = ImageManager.purpleCar;
    } else if (carStatus.toLowerCase() == "off duty") {
      iconPath = ImageManager.blueCar;
    } else if (carStatus.toLowerCase() == "no news") {
      iconPath = ImageManager.greyCar;
    }
    return iconPath;
  }

  Future<void> updateData() async {
    await Future.delayed(const Duration(seconds: 10)).then(
          (value) async => await getVehiclesData(),
    );
  }

  Future<void> logout() async {
    await appPreferences.logout();
  }


}
