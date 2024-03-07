import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking/app/core/bases/base_usecase.dart';
import 'package:tracking/app/core/entities/error_entity.dart';
import 'package:tracking/features/home/domain/entities/cars_data_entity.dart';
import 'package:tracking/features/home/domain/repository/home_repository.dart';

@injectable
class GetCarsDataUseCase extends BaseUseCase<void, Either<ErrorEntity, RecordsCarsDataEntity>> {
  final HomeRepository _repository;

  GetCarsDataUseCase(this._repository);

  @override
  Future<Either<ErrorEntity, RecordsCarsDataEntity>> execute(void input) async {
    return await _repository.getCarsData();
  }

  @override
  void dispose() {}
}
