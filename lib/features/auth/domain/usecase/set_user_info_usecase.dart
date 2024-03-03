import 'package:tracking/app/core/bases/base_usecase.dart';
import 'package:tracking/features/auth/domain/repository/repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SetUserInfoUseCase extends BaseUseCase<SetUserInfoUseCaseParams, void> {
  final LoginRepository _repository;

  SetUserInfoUseCase(this._repository);

  @override
  Future<void> execute(SetUserInfoUseCaseParams input) async {
    return _repository.setUserInfo(input);
  }

  @override
  void dispose() {}
}

class SetUserInfoUseCaseParams {
  final String token;
  final String email;
  final String password;

  SetUserInfoUseCaseParams({
    required this.email,
    required this.password,
    required this.token,
  });
}
