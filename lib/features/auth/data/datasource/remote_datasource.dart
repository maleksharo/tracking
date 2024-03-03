import 'package:tracking/app/core/bases/base_params/base_params.dart';
import 'package:tracking/app/core/models/api_response.dart';
import 'package:tracking/app/network/app_api.dart';
import 'package:tracking/features/auth/data/models/user_model.dart';
import 'package:tracking/features/auth/domain/usecase/login_usecase.dart';
import 'package:injectable/injectable.dart';

abstract class LoginRemoteDataSource {
  Future<Result<UserModel>> login(LoginUseCaseParams input);
}

@Injectable(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final AppServiceClient client;

  LoginRemoteDataSourceImpl({required this.client});

  @override
  Future<Result<UserModel>> login(LoginUseCaseParams input) async {
    return await client.login(Params(params: input));
  }
}
