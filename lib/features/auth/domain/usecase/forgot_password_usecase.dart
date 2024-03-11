import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tracking/app/core/bases/base_response.dart';
import 'package:tracking/app/core/bases/base_usecase.dart';
import 'package:tracking/app/core/entities/error_entity.dart';
import 'package:tracking/features/auth/domain/repository/repository.dart';

part 'forgot_password_usecase.g.dart';

@injectable
class ForgotPasswordUseCase extends BaseUseCase<ForgotPasswordUseCaseParams, Either<ErrorEntity, BaseResponse>> {
  final LoginRepository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<ErrorEntity, BaseResponse>> execute(ForgotPasswordUseCaseParams input) async {
    return await _repository.forgotPassword(input);
  }

  @override
  void dispose() {}
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ForgotPasswordUseCaseParams {
  final String login;

  ForgotPasswordUseCaseParams({required this.login});

  Map<String, dynamic> toJson() => _$ForgotPasswordUseCaseParamsToJson(this);
}
