import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking/app/core/bases/base_usecase.dart';
import 'package:tracking/app/core/entities/error_entity.dart';
import 'package:tracking/features/home/domain/entities/car_location_entity.dart';
import 'package:tracking/features/home/domain/repository/home_repository.dart';

@injectable
class GetCarLocationUseCase extends BaseUseCase<int, Either<ErrorEntity, RecordsCarLocationEntity>> {
  final HomeRepository _repository;

  GetCarLocationUseCase(this._repository);

  @override
  Future<Either<ErrorEntity, RecordsCarLocationEntity>> execute(int input) async {
    return await _repository.getCarLocation(tracCarDeviceId: input);
  }

  @override
  void dispose() {}
}
