import 'package:tracking/app/core/entities/error_entity.dart';
import 'package:tracking/features/auth/domain/entity/user_entity.dart';
import 'package:tracking/features/auth/domain/usecase/login_usecase.dart';
import 'package:tracking/features/auth/domain/usecase/set_user_info_usecase.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<ErrorEntity, UserEntity>> login(LoginUseCaseParams input);

  void setUserInfo(SetUserInfoUseCaseParams input);

  Future<SetUserInfoUseCaseParams> getUserInfo();
}
