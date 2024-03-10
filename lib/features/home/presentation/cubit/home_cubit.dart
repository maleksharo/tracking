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
import 'package:tracking/features/home/domain/usecases/get_company_vehicles_usecase.dart';
import 'package:tracking/features/home/domain/usecases/get_trip_info_usecase.dart';
import 'package:tracking/features/home/presentation/screens/widgets/car_info_dialog.dart';
import 'package:tracking/features/home/presentation/trips_params.dart';

part 'home_state.dart';

@lazySingleton
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this.getCarLocationUseCase,
    this.getCarTripRouteUseCase,
    this.getCarsDataUseCase,
    this.getCompanyVehiclesUseCase,
    this.getTripInfoUseCase,
    this.appPreferences,
  ) : super(HomeInitial());
  final GetCarLocationUseCase getCarLocationUseCase;
  final GetCarTripRouteUseCase getCarTripRouteUseCase;
  final GetCarsDataUseCase getCarsDataUseCase;
  final GetCompanyVehiclesUseCase getCompanyVehiclesUseCase;
  final GetTripInfoUseCase getTripInfoUseCase;
  final AppPreferences appPreferences;

  List<CarLocationEntity> carLocationsRoute = [];
  /// This api is for giving last trip for a specific car
  Future<void> getCarLocation({required int tracCarDeviceId}) async {
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

  Future<void> getCarTripRoute({required int tracCarDeviceId, required TripParams tripParams}) async {
    emit(GetCarTripRouteLoadingState());
    (await getCarTripRouteUseCase.execute(
      GetTripInfoUseCaseParams(tripParams: tripParams, tracCarDeviceId: tracCarDeviceId),
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

  /// This api is giving me all cars data related to the company
  Future<void> getCarsData({bool firstTime = false, bool homeSource = true}) async {
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
  /// Useless api just giving me the cars without any additional information
  Future<void> getCompanyVehicles() async {
    emit(GetCompanyVehiclesLoadingState());
    (await getCompanyVehiclesUseCase.execute(Void)).fold(
      (l) {
        emit(GetCompanyVehiclesFailedState(message: l.errorMessage ?? LocaleKeys.defaultError.tr()));
      },
      (responseEntity) async {
        emit(GetCompanyVehiclesSuccessState(companyVehicles: responseEntity));
      },
    );
  }
  /// This api will give me
  Future<void> getTripInfo({required int tracCarDeviceId, required TripParams tripParams}) async {
    emit(GetTripInfoLoadingState());
    (await getTripInfoUseCase.execute(GetTripInfoUseCaseParams(
      tracCarDeviceId: tracCarDeviceId,
      tripParams: tripParams,
    )))
        .fold(
      (l) {
        emit(GetTripInfoFailedState(message: l.errorMessage ?? LocaleKeys.defaultError.tr()));
      },
      (responseEntity) async {
        emit(GetTripInfoSuccessState(recordsVehicleRoutesEntity: responseEntity));
      },
    );
  }

  LatLng initCamera({required List<CarsDataEntity> carsList}) {
    double long = 0.0, lat = 0.0;
    int carsNumber = 0;
    for (var car in carsList) {
      carsNumber++;
      long += car.locationEntity.longitude;
      lat += car.locationEntity.latitude;
    }
    if (lat != 0 && long != 0 && carsNumber != 0) {
      lat = lat / carsNumber;
      long = long / carsNumber;
    }
    return LatLng(lat, long);
  }

  Marker buildPin({required CarsDataEntity entity, required BuildContext context}) {
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
          carInfoDialog(
              context: context,
              entity: entity,
              onShowRoutePressed: (entity) {
                getCarLocation(tracCarDeviceId: entity.deviceId);
              });
        },
        child: Image.asset(
          detectCarColorPath(carStatus: entity.status),
          width: 20.w,
          height: 20.w,
        ),
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
      (value) async => await getCarsData(),
    );
  }

  Future<void> logout() async {
    await appPreferences.logout();
  }
}
