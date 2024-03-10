import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking/app/core/bases/base_usecase.dart';
import 'package:tracking/app/core/entities/error_entity.dart';
import 'package:tracking/features/home/domain/entities/vehicle_trips_entity.dart';
import 'package:tracking/features/home/domain/repository/home_repository.dart';

import 'get_trip_info_usecase.dart';

@injectable
class GetCarTripRouteUseCase
    extends BaseUseCase<GetTripInfoUseCaseParams, Either<ErrorEntity, RecordsVehicleTripsEntity>> {
  final HomeRepository _repository;

  GetCarTripRouteUseCase(this._repository);

  @override
  Future<Either<ErrorEntity, RecordsVehicleTripsEntity>> execute(GetTripInfoUseCaseParams input) async {
    return await _repository.getVehicleTripsBetweenTwoTime(
      tracCarDeviceId: input.tracCarDeviceId,
      tripParams: input.tripParams,
    );
  }

  @override
  void dispose() {}
}
