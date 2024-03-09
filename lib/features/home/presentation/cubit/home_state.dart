part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetCarLocationSuccessState extends HomeState {
  final RecordsCarLocationEntity recordsCarLocationEntity;

  GetCarLocationSuccessState({required this.recordsCarLocationEntity});
}

class GetCarLocationLoadingState extends HomeState {}

class GetCarLocationFailedState extends HomeState {
  final String message;

  GetCarLocationFailedState({required this.message});
}

///
class GetCarTripRouteSuccessState extends HomeState {
  final RecordsVehicleTripsEntity recordsVehicleTripsEntity;

  GetCarTripRouteSuccessState({required this.recordsVehicleTripsEntity});
}

class GetCarTripRouteLoadingState extends HomeState {}

class GetCarTripRouteFailedState extends HomeState {
  final String message;

  GetCarTripRouteFailedState({required this.message});
}

///
class GetCarsDataSuccessState extends HomeState {
  final RecordsCarsDataEntity carsDataEntity;
  final bool firstTime;
  final bool homeSource;

  GetCarsDataSuccessState({
    required this.homeSource,
    required this.carsDataEntity,
    required this.firstTime,
  });
}

class GetCarsDataLoadingState extends HomeState {
  final bool firstTime;

  GetCarsDataLoadingState({required this.firstTime});
}

class GetCarsDataFailedState extends HomeState {
  final String message;

  GetCarsDataFailedState({required this.message});
}

class MoveToCarLocation extends HomeState {
  final LatLng latLng;

  MoveToCarLocation({required this.latLng});
}

///
class GetCompanyVehiclesSuccessState extends HomeState {
  final List<CompanyVehiclesEntity> companyVehicles;

  GetCompanyVehiclesSuccessState({required this.companyVehicles});
}

class GetCompanyVehiclesLoadingState extends HomeState {}

class GetCompanyVehiclesFailedState extends HomeState {
  final String message;

  GetCompanyVehiclesFailedState({required this.message});
}

///
class GetTripInfoSuccessState extends HomeState {
  final RecordsVehicleRoutesEntity recordsVehicleRoutesEntity;

  GetTripInfoSuccessState({required this.recordsVehicleRoutesEntity});
}

class GetTripInfoLoadingState extends HomeState {}

class GetTripInfoFailedState extends HomeState {
  final String message;

  GetTripInfoFailedState({required this.message});
}
