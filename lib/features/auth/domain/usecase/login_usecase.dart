import 'package:tracking/app/core/bases/base_usecase.dart';
import 'package:tracking/app/core/entities/error_entity.dart';
import 'package:tracking/features/auth/domain/entity/user_entity.dart';
import 'package:tracking/features/auth/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_usecase.g.dart';

@injectable
class LoginUseCase extends BaseUseCase<LoginUseCaseParams, Either<ErrorEntity, UserEntity>> {
  final LoginRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<ErrorEntity, UserEntity>> execute(LoginUseCaseParams input) async {
    return await _repository.login(input);
  }

  @override
  void dispose() {}
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginUseCaseParams {
  final String login;
  final String password;

  LoginUseCaseParams({required this.login, required this.password});

  Map<String, dynamic> toJson() => _$LoginUseCaseParamsToJson(this);
}

