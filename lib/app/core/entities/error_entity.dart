import 'package:tracking/app/network/exceptions.dart';


class ErrorEntity {
  ErrorEntity({
    this.code,
    this.errorMessage,
  });

  ErrorEntity.fromException(AppException exception) {
    code = exception.code;
    errorMessage = exception.message;
  }

  int? code;
  String? errorMessage;
}
