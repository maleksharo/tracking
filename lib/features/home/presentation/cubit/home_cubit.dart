import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
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
import 'package:tracking/features/home/presentation/trips_params.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this.getCarLocationUseCase,
    this.getCarTripRouteUseCase,
    this.getCarsDataUseCase,
    this.getCompanyVehiclesUseCase,
    this.getTripInfoUseCase,
  ) : super(HomeInitial());
  final GetCarLocationUseCase getCarLocationUseCase;
  final GetCarTripRouteUseCase getCarTripRouteUseCase;
  final GetCarsDataUseCase getCarsDataUseCase;
  final GetCompanyVehiclesUseCase getCompanyVehiclesUseCase;
  final GetTripInfoUseCase getTripInfoUseCase;

  Future<void> getCarLocation({required int tracCarDeviceId}) async {
    emit(GetCarLocationLoadingState());
    (await getCarLocationUseCase.execute(tracCarDeviceId)).fold(
      (l) {
        emit(GetCarLocationFailedState(message: l.errorMessage ?? LocaleKeys.defaultError.tr()));
      },
      (responseEntity) async {
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

  Future<void> getCarsData() async {
    emit(GetCarsDataLoadingState());
    (await getCarsDataUseCase.execute(Void)).fold(
      (l) {
        emit(GetCarsDataFailedState(message: l.errorMessage ?? LocaleKeys.defaultError.tr()));
      },
      (responseEntity) async {
        emit(GetCarsDataSuccessState(carsDataEntity: responseEntity));
      },
    );
  }

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
}
