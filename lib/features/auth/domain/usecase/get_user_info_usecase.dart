import 'package:tracking/app/core/bases/base_usecase.dart';
import 'package:tracking/features/auth/domain/repository/repository.dart';
import 'package:tracking/features/auth/domain/usecase/set_user_info_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserInfoUseCase extends BaseUseCase<NoUseCaseParams, SetUserInfoUseCaseParams> {
  final LoginRepository _repository;

  GetUserInfoUseCase(this._repository);

  @override
  void dispose() {}

  @override
  Future<SetUserInfoUseCaseParams> execute(NoUseCaseParams input) {
    return _repository.getUserInfo();
  }
}
