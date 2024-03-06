import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking/app/core/bases/base_usecase.dart';
import 'package:tracking/app/core/entities/error_entity.dart';
import 'package:tracking/features/home/domain/entities/company_vehicles_entity.dart';
import 'package:tracking/features/home/domain/repository/home_repository.dart';

@injectable
class GetCompanyVehiclesUseCase extends BaseUseCase<void, Either<ErrorEntity, List<CompanyVehiclesEntity>>> {
  final HomeRepository _repository;

  GetCompanyVehiclesUseCase(this._repository);

  @override
  Future<Either<ErrorEntity, List<CompanyVehiclesEntity>>> execute(void input) async {
    return await _repository.getCompanyVehicles();
  }

  @override
  void dispose() {}
}
