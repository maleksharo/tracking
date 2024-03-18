import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking/app/core/bases/base_usecase.dart';
import 'package:tracking/app/core/entities/error_entity.dart';
import 'package:tracking/features/auth/domain/repository/repository.dart';

@injectable
class GetServerUseCase extends BaseUseCase<void, Either<ErrorEntity, List<String>>> {
  final LoginRepository _repository;

  GetServerUseCase(this._repository);

  @override
  Future<Either<ErrorEntity, List<String>>> execute(void input) async {
    return await _repository.getServers();
  }

  @override
  void dispose() {}
}
