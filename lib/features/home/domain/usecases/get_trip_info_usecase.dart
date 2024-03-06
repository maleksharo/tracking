import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking/app/core/bases/base_usecase.dart';
import 'package:tracking/app/core/entities/error_entity.dart';
import 'package:tracking/features/home/domain/repository/home_repository.dart';
import 'package:tracking/features/home/presentation/trips_params.dart';

import '../entities/vehicle_routes_entity.dart';

@injectable
class GetTripInfoUseCase
    extends BaseUseCase<GetTripInfoUseCaseParams, Either<ErrorEntity, RecordsVehicleRoutesEntity>> {
  final HomeRepository _repository;

  GetTripInfoUseCase(this._repository);

  @override
  Future<Either<ErrorEntity, RecordsVehicleRoutesEntity>> execute(GetTripInfoUseCaseParams input) async {
    return await _repository.getTripInfo(
      tracCarDeviceId: input.tracCarDeviceId,
      tripParams: input.tripParams,
    );
  }

  @override
  void dispose() {}
}

class GetTripInfoUseCaseParams {
  final int tracCarDeviceId;
  final TripParams tripParams;

  GetTripInfoUseCaseParams({required this.tracCarDeviceId, required this.tripParams});
}
