import 'package:tracking/app/core/bases/base_params/base_params.dart';
import 'package:tracking/app/core/models/api_response.dart';
import 'package:tracking/app/network/app_api.dart';
import 'package:tracking/features/auth/data/models/user_model.dart';
import 'package:tracking/features/auth/domain/usecase/forgot_password_usecase.dart';
import 'package:tracking/features/auth/domain/usecase/login_usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/core/bases/base_response.dart';

abstract class LoginRemoteDataSource {
  Future<Result<UserModel>> login(LoginUseCaseParams input);
  Future<Result<BaseResponse>> forgotPassword(ForgotPasswordUseCaseParams input);
}

@Injectable(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final AppServiceClient client;

  LoginRemoteDataSourceImpl({required this.client});

  @override
  Future<Result<UserModel>> login(LoginUseCaseParams input) async {
    return await client.login(Params(params: input));
  }

  @override
  Future<Result<BaseResponse>> forgotPassword(ForgotPasswordUseCaseParams input) async{
    return await client.forgotPassword(Params(params: input));
  }
}
