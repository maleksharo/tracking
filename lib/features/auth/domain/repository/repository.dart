import 'package:dartz/dartz.dart';
import 'package:tracking/app/core/bases/base_response.dart';
import 'package:tracking/app/core/entities/error_entity.dart';
import 'package:tracking/features/auth/domain/entity/user_entity.dart';
import 'package:tracking/features/auth/domain/usecase/forgot_password_usecase.dart';
import 'package:tracking/features/auth/domain/usecase/login_usecase.dart';
import 'package:tracking/features/auth/domain/usecase/set_user_info_usecase.dart';

abstract class LoginRepository {
  Future<Either<ErrorEntity, UserEntity>> login(LoginUseCaseParams input);

  Future<Either<ErrorEntity, BaseResponse>> forgotPassword(ForgotPasswordUseCaseParams input);

  void setUserInfo(SetUserInfoUseCaseParams input);

  Future<SetUserInfoUseCaseParams> getUserInfo();

  Future<Either<ErrorEntity,List<String>>> getServers();
}
