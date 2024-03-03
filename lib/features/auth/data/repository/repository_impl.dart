import 'package:tracking/app/network/exceptions.dart';
import 'package:tracking/features/auth/data/datasource/local_datasource.dart';
import 'package:tracking/features/auth/domain/entity/user_entity.dart';
import 'package:tracking/features/auth/domain/usecase/login_usecase.dart';
import 'package:tracking/features/auth/domain/usecase/set_user_info_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../app/core/entities/error_entity.dart';
import '../../domain/repository/repository.dart';
import '../datasource/remote_datasource.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource _remoteDataSource;
  final LoginLocalDataSource _localDataSource;

  LoginRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<ErrorEntity, UserEntity>> login(LoginUseCaseParams input) async {
    try {
      final response = await _remoteDataSource.login(input);
      if (response.result?.success == true) {
        return Right(response.result?.response?.toEntity() ?? UserEntity(token: ""));
      } else {
        return Left(ErrorEntity(
          errorMessage: response.result?.message,
        ));
      }
    } on DioException catch (e) {
      return Left(ErrorEntity.fromException(e.convertToAppException()));
    }
  }

  @override
  void setUserInfo(SetUserInfoUseCaseParams input) {
    _localDataSource.saveUserInfo(input: input);
  }

  @override
  Future<SetUserInfoUseCaseParams> getUserInfo() async {
    return await _localDataSource.getUserInfo();
  }
}
